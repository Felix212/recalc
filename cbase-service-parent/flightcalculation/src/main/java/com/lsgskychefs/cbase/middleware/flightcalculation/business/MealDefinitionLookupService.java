/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealDefinitionWithComponents;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.*;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service for looking up meal definitions for flights.
 *
 * <p>PowerBuilder equivalent methods from uo_meal_calculation:
 * <ul>
 *   <li>uf_retrieve_meal_definitions() - Find meal defs</li>
 *   <li>uf_get_meal_period() - Determine meal period</li>
 *   <li>uf_match_rotation() - Match routing</li>
 *   <li>uf_get_handling_meal_key() - Get meal definition key</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class MealDefinitionLookupService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MealDefinitionLookupService.class);

	private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("HH:mm");

	// Meal period definitions (can be externalized to configuration)
	private static final LocalTime BREAKFAST_START = LocalTime.of(5, 0);
	private static final LocalTime BREAKFAST_END = LocalTime.of(10, 30);
	private static final LocalTime LUNCH_START = LocalTime.of(11, 0);
	private static final LocalTime LUNCH_END = LocalTime.of(14, 30);
	private static final LocalTime DINNER_START = LocalTime.of(17, 0);
	private static final LocalTime DINNER_END = LocalTime.of(22, 0);

	private final CenMealsRepository mealsRepository;
	private final CenMealsDetailRepository mealsDetailRepository;
	private final CenRotationsRepository rotationsRepository;
	private final CenMealCoverRepository mealCoverRepository;
	private final CenMealsSpmlRepository mealsSpmlRepository;

	@Autowired
	public MealDefinitionLookupService(
			CenMealsRepository mealsRepository,
			CenMealsDetailRepository mealsDetailRepository,
			CenRotationsRepository rotationsRepository,
			CenMealCoverRepository mealCoverRepository,
			CenMealsSpmlRepository mealsSpmlRepository) {
		this.mealsRepository = mealsRepository;
		this.mealsDetailRepository = mealsDetailRepository;
		this.rotationsRepository = rotationsRepository;
		this.mealCoverRepository = mealCoverRepository;
		this.mealsSpmlRepository = mealsSpmlRepository;
	}

	/**
	 * Find meal definitions WITH components for a flight context.
	 *
	 * <p>PowerBuilder: uf_retrieve_meal_definitions() + component loading
	 *
	 * <p>This method:
	 * <ol>
	 *   <li>Determines the rotation key from routing</li>
	 *   <li>Determines the meal period from departure time</li>
	 *   <li>Finds matching meal definitions (headers)</li>
	 *   <li>Loads components (CenMealsDetail) for each meal</li>
	 *   <li>Combines into MealDefinitionWithComponents DTOs</li>
	 *   <li>Filters by validity date</li>
	 *   <li>Orders by priority</li>
	 * </ol>
	 *
	 * <p>CRITICAL: Each component becomes ONE CenOutMeals record in output.
	 *
	 * @param context The meal calculation context
	 * @return List of meal definitions with components, or empty list if none found
	 */
	public List<MealDefinitionWithComponents> findMealDefinitionsWithComponents(MealCalculationContext context) {
		Long resultKey = context.getResultKey();

		LOGGER.info("Finding meal definitions WITH components for result_key={}", resultKey);

		// Step 1: Get or determine rotation key
		Long rotationKey = context.getRotationKey();
		if (rotationKey == null && context.getRoutingDetailKey() != null) {
			rotationKey = matchRotation(
					context.getRoutingDetailKey(),
					context.getDepartureDate());
			context.setRotationKey(rotationKey);
		}

		if (rotationKey == null) {
			LOGGER.warn("No rotation found for result_key={}", resultKey);
			return Collections.emptyList();
		}

		LOGGER.debug("Using rotation_key={} for result_key={}", rotationKey, resultKey);

		// Step 2: Get all meal definitions for this rotation
		List<CenMeals> allMeals = findByRotationAndValidity(
				rotationKey,
				context.getDepartureDate());

		LOGGER.info("Found {} meal definitions for rotation_key={}",
				allMeals.size(), rotationKey);

		// Step 3: Filter by meal period if needed
		MealPeriod mealPeriod = determineMealPeriod(context.getDepartureTime());
		LOGGER.debug("Meal period determined: {} for result_key={}", mealPeriod, resultKey);

		// Step 4: Filter to regular meals only (nmodule_type = 0)
		List<CenMeals> regularMeals = allMeals.stream()
				.filter(m -> m.getNmoduleType() == 0)  // 0 = meals, 1 = extras
				.collect(Collectors.toList());

		LOGGER.info("Found {} regular meal headers for result_key={}",
				regularMeals.size(), resultKey);

		// Step 5: Load components for each meal (BATCH operation for performance)
		List<MealDefinitionWithComponents> mealsWithComponents =
				loadComponentsForMeals(regularMeals, context.getDepartureDate());

		LOGGER.info("Returning {} meals with {} total components for result_key={}",
				mealsWithComponents.size(),
				mealsWithComponents.stream().mapToInt(MealDefinitionWithComponents::getComponentCount).sum(),
				resultKey);

		return mealsWithComponents;
	}

	/**
	 * Load components for a list of meal definitions.
	 *
	 * <p>Uses batch loading for performance - one query for all meals.
	 *
	 * @param mealHeaders List of meal headers
	 * @param validityDate Date for component validity check
	 * @return List of MealDefinitionWithComponents (only meals that have components)
	 */
	private List<MealDefinitionWithComponents> loadComponentsForMeals(
			List<CenMeals> mealHeaders,
			Date validityDate) {

		if (mealHeaders == null || mealHeaders.isEmpty()) {
			return Collections.emptyList();
		}

		// Collect all meal keys
		List<Long> mealKeys = mealHeaders.stream()
				.map(CenMeals::getNhandlingMealKey)
				.collect(Collectors.toList());

		// Batch load all components in one query
		List<CenMealsDetail> allComponents = mealsDetailRepository
				.findByMealKeysAndDate(mealKeys, validityDate);

		LOGGER.debug("Loaded {} components for {} meals",
				allComponents.size(), mealKeys.size());

		// Group components by meal key
		Map<Long, List<CenMealsDetail>> componentsByMeal = allComponents.stream()
				.collect(Collectors.groupingBy(
						detail -> detail.getCenMeals().getNhandlingMealKey()));

		// Combine headers with components
		List<MealDefinitionWithComponents> result = new ArrayList<>();

		for (CenMeals mealHeader : mealHeaders) {
			Long mealKey = mealHeader.getNhandlingMealKey();
			List<CenMealsDetail> components = componentsByMeal.get(mealKey);

			if (components == null || components.isEmpty()) {
				LOGGER.warn("Meal {} has no components, skipping (meal code: {})",
						mealKey, mealHeader.getCmealCode());
				continue;
			}

			// Sort components by priority
			components.sort(Comparator.comparingInt(CenMealsDetail::getNprio));

			MealDefinitionWithComponents mealWithComponents =
					new MealDefinitionWithComponents(mealHeader, components);

			result.add(mealWithComponents);

			LOGGER.debug("Meal {}: {} components loaded",
					mealKey, components.size());
		}

		return result;
	}

	/**
	 * Find meal definitions for a flight context (LEGACY - headers only).
	 *
	 * @deprecated Use {@link #findMealDefinitionsWithComponents(MealCalculationContext)} instead.
	 *             This method only returns meal headers without components.
	 *
	 * @param context The meal calculation context
	 * @return List of meal definitions, or empty list if none found
	 */
	@Deprecated
	public List<CenMeals> findMealDefinitions(MealCalculationContext context) {
		Long resultKey = context.getResultKey();

		LOGGER.warn("DEPRECATED: findMealDefinitions() called for result_key={}. " +
				"Use findMealDefinitionsWithComponents() for component-level processing.", resultKey);

		// Step 1: Get or determine rotation key
		Long rotationKey = context.getRotationKey();
		if (rotationKey == null && context.getRoutingDetailKey() != null) {
			rotationKey = matchRotation(
					context.getRoutingDetailKey(),
					context.getDepartureDate());
			context.setRotationKey(rotationKey);
		}

		if (rotationKey == null) {
			LOGGER.warn("No rotation found for result_key={}", resultKey);
			return Collections.emptyList();
		}

		// Step 2: Get all meal definitions for this rotation
		List<CenMeals> allMeals = findByRotationAndValidity(
				rotationKey,
				context.getDepartureDate());

		// Step 3: Filter to regular meals only (nmodule_type = 0)
		List<CenMeals> regularMeals = allMeals.stream()
				.filter(m -> m.getNmoduleType() == 0)  // 0 = meals, 1 = extras
				.collect(Collectors.toList());

		LOGGER.info("Returning {} regular meal definitions for result_key={}",
				regularMeals.size(), resultKey);

		return regularMeals;
	}

	/**
	 * Find meal definitions by rotation with caching.
	 *
	 * @param rotationKey The rotation key
	 * @param validityDate The validity date
	 * @return List of meal definitions
	 */
	@Cacheable(value = "meal-definitions", key = "#rotationKey + '-' + #validityDate")
	public List<CenMeals> findByRotationAndValidity(Long rotationKey, Date validityDate) {
		return mealsRepository.findByRotationAndValidity(rotationKey, validityDate);
	}

	/**
	 * Match rotation from routing detail key.
	 *
	 * <p>PowerBuilder: uf_match_rotation()
	 *
	 * @param routingDetailKey The routing detail key
	 * @param validityDate The validity date
	 * @return Rotation key if found, null otherwise
	 */
	public Long matchRotation(Long routingDetailKey, Date validityDate) {
		if (routingDetailKey == null) {
			return null;
		}

		Optional<CenRotations> rotation = rotationsRepository
				.findByRoutingDetailKeyAndValidity(routingDetailKey, validityDate);

		if (rotation.isPresent()) {
			Long rotationKey = rotation.get().getNrotationKey();
			LOGGER.debug("Matched rotation_key={} for routing_detail_key={}",
					rotationKey, routingDetailKey);
			return rotationKey;
		}

		LOGGER.warn("No rotation found for routing_detail_key={}", routingDetailKey);
		return null;
	}

	/**
	 * Determine meal period from departure time.
	 *
	 * <p>PowerBuilder: uf_get_meal_period()
	 *
	 * <p>Meal periods:
	 * <ul>
	 *   <li>BREAKFAST: 05:00 - 10:30</li>
	 *   <li>LUNCH: 11:00 - 14:30</li>
	 *   <li>DINNER: 17:00 - 22:00</li>
	 *   <li>SNACK: All other times</li>
	 * </ul>
	 *
	 * @param departureTimeStr Departure time in HH:mm format
	 * @return The meal period
	 */
	public MealPeriod determineMealPeriod(String departureTimeStr) {
		if (departureTimeStr == null || departureTimeStr.trim().isEmpty()) {
			LOGGER.debug("No departure time provided, defaulting to UNSPECIFIED");
			return MealPeriod.UNSPECIFIED;
		}

		try {
			// Parse time (handle both HH:mm and HH:mm:ss formats)
			String timeStr = departureTimeStr.trim();
			if (timeStr.length() > 5) {
				timeStr = timeStr.substring(0, 5);  // Take HH:mm part
			}

			LocalTime departureTime = LocalTime.parse(timeStr, TIME_FORMAT);

			// Determine period
			if (isInRange(departureTime, BREAKFAST_START, BREAKFAST_END)) {
				return MealPeriod.BREAKFAST;
			} else if (isInRange(departureTime, LUNCH_START, LUNCH_END)) {
				return MealPeriod.LUNCH;
			} else if (isInRange(departureTime, DINNER_START, DINNER_END)) {
				return MealPeriod.DINNER;
			} else {
				return MealPeriod.SNACK;
			}
		} catch (Exception e) {
			LOGGER.warn("Failed to parse departure time: {}, defaulting to UNSPECIFIED",
					departureTimeStr, e);
			return MealPeriod.UNSPECIFIED;
		}
	}

	/**
	 * Check if time is in range (handles overnight ranges).
	 */
	private boolean isInRange(LocalTime time, LocalTime start, LocalTime end) {
		if (start.isBefore(end)) {
			// Normal range (e.g., 11:00 - 14:30)
			return !time.isBefore(start) && !time.isAfter(end);
		} else {
			// Overnight range (e.g., 22:00 - 05:00)
			return !time.isBefore(start) || !time.isAfter(end);
		}
	}

	/**
	 * Find meal details for a meal definition.
	 *
	 * @param handlingMealKey The meal definition key
	 * @return List of meal details
	 */
	@Cacheable(value = "meal-details", key = "#handlingMealKey")
	public List<CenMealsDetail> findMealDetails(Long handlingMealKey) {
		return mealsDetailRepository.findByHandlingMealKey(handlingMealKey);
	}

	/**
	 * Find meal covers for a rotation and class.
	 *
	 * @param rotationKey The rotation key
	 * @param classCode The service class code
	 * @return List of meal covers
	 */
	@Cacheable(value = "meal-covers", key = "#rotationKey + '-' + #classCode")
	public List<CenMealCover> findMealCovers(Long rotationKey, String classCode) {
		return mealCoverRepository.findByRotationAndClass(rotationKey, classCode);
	}

	/**
	 * Find SPML definition by code.
	 *
	 * @param spmlCode The SPML code (e.g., VGML, KSML)
	 * @param rotationKey The rotation key
	 * @return SPML definition if found
	 */
	@Cacheable(value = "spml-definitions", key = "#spmlCode + '-' + #rotationKey")
	public Optional<CenMealsSpml> findSpmlDefinition(String spmlCode, Long rotationKey) {
		return mealsSpmlRepository.findBySpmlCodeAndRotation(spmlCode, rotationKey);
	}

	/**
	 * Validate meal definition references exist.
	 *
	 * <p>PowerBuilder checks: "from cen_meals_detail where ..."
	 *
	 * @param handlingDetailKey The handling detail key to validate
	 * @return true if valid references exist
	 */
	public boolean validateMealReferences(Long handlingDetailKey) {
		if (handlingDetailKey == null) {
			return false;
		}
		return mealsDetailRepository.existsByHandlingDetailKey(handlingDetailKey);
	}

	/**
	 * Meal period enumeration.
	 */
	public enum MealPeriod {
		BREAKFAST("Breakfast"),
		LUNCH("Lunch"),
		DINNER("Dinner"),
		SNACK("Snack"),
		UNSPECIFIED("Unspecified");

		private final String displayName;

		MealPeriod(String displayName) {
			this.displayName = displayName;
		}

		public String getDisplayName() {
			return displayName;
		}
	}
}
