/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenHandlingTypesRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service for calculating handling requirements and extra loading.
 *
 * <p>PowerBuilder equivalent methods from uo_generate.sru:
 * <ul>
 *   <li>uf_calculate_handling() - Calculate handling equipment</li>
 *   <li>uf_calculate_extra() - Calculate extra items (newspapers, etc.)</li>
 *   <li>uf_determine_handling_type() - Determine handling type</li>
 *   <li>uf_calculate_handling_quantity() - Calculate handling quantities</li>
 *   <li>uf_apply_handling_rules() - Apply handling business rules</li>
 * </ul>
 *
 * <p>Handling includes:
 * <ul>
 *   <li>Service equipment (trays, carts, containers)</li>
 *   <li>Extra items (newspapers, magazines, amenity kits)</li>
 *   <li>Special equipment (beverage carts, wine carts)</li>
 *   <li>Quantity calculations based on PAX and class</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class HandlingCalculationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(HandlingCalculationService.class);

	private final CenHandlingTypesRepository handlingTypesRepository;

	@Autowired
	public HandlingCalculationService(CenHandlingTypesRepository handlingTypesRepository) {
		this.handlingTypesRepository = handlingTypesRepository;
	}

	/**
	 * Calculate handling requirements for a flight.
	 *
	 * <p>PowerBuilder: uf_calculate_handling()
	 *
	 * <p>This method:
	 * <ol>
	 *   <li>Retrieves handling type definitions</li>
	 *   <li>Calculates quantities based on PAX and meals</li>
	 *   <li>Applies business rules (minimums, maximums, rounding)</li>
	 *   <li>Creates handling records</li>
	 * </ol>
	 *
	 * @param context Meal calculation context
	 * @param meals Calculated meals
	 * @return List of handling records
	 */
	public List<CenOutHandling> calculateHandling(
			MealCalculationContext context,
			List<CenOutMeals> meals) {

		Long resultKey = context.getResultKey();
		Long rotationKey = context.getRotationKey();

		LOGGER.info("Calculating handling for result_key={}, rotation_key={}",
				resultKey, rotationKey);

		if (rotationKey == null) {
			LOGGER.warn("No rotation_key available, cannot calculate handling");
			return Collections.emptyList();
		}

		// Step 1: Get handling type definitions
		List<CenHandlingTypes> handlingTypes = getHandlingTypes(rotationKey);
		if (handlingTypes.isEmpty()) {
			LOGGER.warn("No handling types found for rotation_key={}", rotationKey);
			return Collections.emptyList();
		}

		LOGGER.debug("Found {} handling types for rotation_key={}",
				handlingTypes.size(), rotationKey);

		// Step 2: Get PAX data
		List<CenOutPax> paxData = context.getPaxData();
		Map<String, Integer> paxByClass = aggregatePaxByClass(paxData);

		// Step 3: Get meal data by class
		Map<String, List<CenOutMeals>> mealsByClass = groupMealsByClass(meals);

		// Step 4: Calculate handling for each type
		List<CenOutHandling> handlingRecords = new ArrayList<>();
		int priority = 1;

		for (CenHandlingTypes handlingType : handlingTypes) {
			List<CenOutHandling> typeRecords = calculateHandlingForType(
					handlingType, paxByClass, mealsByClass, context, priority);
			handlingRecords.addAll(typeRecords);
			priority += typeRecords.size();
		}

		LOGGER.info("Calculated {} handling records for result_key={}",
				handlingRecords.size(), resultKey);

		return handlingRecords;
	}

	/**
	 * Calculate handling for a specific type.
	 *
	 * <p>PowerBuilder: uf_calculate_handling_quantity()
	 *
	 * @param handlingType Handling type definition
	 * @param paxByClass PAX counts by class
	 * @param mealsByClass Meals grouped by class
	 * @param context Calculation context
	 * @param basePriority Base priority for sequencing
	 * @return List of handling records
	 */
	private List<CenOutHandling> calculateHandlingForType(
			CenHandlingTypes handlingType,
			Map<String, Integer> paxByClass,
			Map<String, List<CenOutMeals>> mealsByClass,
			MealCalculationContext context,
			int basePriority) {

		List<CenOutHandling> records = new ArrayList<>();

		String handlingCode = handlingType.getChandlingCode();
		String applicableClass = handlingType.getCclass();

		LOGGER.debug("Calculating handling type={}, class={}", handlingCode, applicableClass);

		// Determine which classes this handling applies to
		List<String> targetClasses = determineTargetClasses(applicableClass, paxByClass);

		int priority = basePriority;
		for (String classCode : targetClasses) {
			int paxCount = paxByClass.getOrDefault(classCode, 0);
			int mealCount = getMealCountForClass(mealsByClass, classCode);

			if (paxCount == 0 && mealCount == 0) {
				LOGGER.debug("Skipping handling type={} for class={} (no PAX or meals)",
						handlingCode, classCode);
				continue;
			}

			// Calculate quantity
			int quantity = calculateHandlingQuantity(
					handlingType, paxCount, mealCount);

			if (quantity > 0) {
				CenOutHandling handling = createHandlingRecord(
						context, handlingType, classCode, quantity, priority);
				records.add(handling);

				LOGGER.debug("Created handling: type={}, class={}, quantity={}, priority={}",
						handlingCode, classCode, quantity, priority);

				priority++;
			}
		}

		return records;
	}

	/**
	 * Calculate quantity for a handling type.
	 *
	 * <p>PowerBuilder: uf_calculate_handling_quantity() + uf_apply_handling_rules()
	 *
	 * <p>Calculation types:
	 * <ul>
	 *   <li>0: Fixed quantity</li>
	 *   <li>1: Per PAX (with ratio)</li>
	 *   <li>2: Per meal (with ratio)</li>
	 *   <li>3: Per PAX with rounding</li>
	 * </ul>
	 *
	 * @param handlingType Handling type definition
	 * @param paxCount PAX count
	 * @param mealCount Meal count
	 * @return Calculated quantity
	 */
	private int calculateHandlingQuantity(
			CenHandlingTypes handlingType,
			int paxCount,
			int mealCount) {

		int calculationType = handlingType.getNcalculationType();
		int baseQuantity = handlingType.getNquantity() != null
				? handlingType.getNquantity().intValue()
				: 0;
		BigDecimal ratio = handlingType.getNratio();

		int quantity = 0;

		switch (calculationType) {
			case 0: // Fixed quantity
				quantity = baseQuantity;
				LOGGER.debug("Fixed quantity: {}", quantity);
				break;

			case 1: // Per PAX with ratio
				if (ratio != null && ratio.compareTo(BigDecimal.ZERO) > 0) {
					quantity = (int) Math.ceil(paxCount * ratio.doubleValue());
				} else {
					quantity = paxCount;
				}
				LOGGER.debug("Per PAX: {} PAX * {} ratio = {}", paxCount, ratio, quantity);
				break;

			case 2: // Per meal with ratio
				if (ratio != null && ratio.compareTo(BigDecimal.ZERO) > 0) {
					quantity = (int) Math.ceil(mealCount * ratio.doubleValue());
				} else {
					quantity = mealCount;
				}
				LOGGER.debug("Per meal: {} meals * {} ratio = {}", mealCount, ratio, quantity);
				break;

			case 3: // Per PAX with rounding to base quantity
				if (baseQuantity > 0) {
					quantity = (int) Math.ceil((double) paxCount / baseQuantity);
				} else {
					quantity = paxCount;
				}
				LOGGER.debug("Per PAX rounded: {} PAX / {} = {}", paxCount, baseQuantity, quantity);
				break;

			default:
				LOGGER.warn("Unknown calculation type: {}, using fixed quantity", calculationType);
				quantity = baseQuantity;
		}

		// Apply minimum and maximum
		int minQuantity = handlingType.getNminQuantity() != null
				? handlingType.getNminQuantity()
				: 0;
		int maxQuantity = handlingType.getNmaxQuantity() != null
				? handlingType.getNmaxQuantity()
				: Integer.MAX_VALUE;

		quantity = Math.max(minQuantity, Math.min(quantity, maxQuantity));

		LOGGER.debug("Final quantity after min/max: {}", quantity);

		return quantity;
	}

	/**
	 * Create a handling record.
	 *
	 * @param context Calculation context
	 * @param handlingType Handling type
	 * @param classCode Service class
	 * @param quantity Calculated quantity
	 * @param priority Priority for sequencing
	 * @return Handling record
	 */
	private CenOutHandling createHandlingRecord(
			MealCalculationContext context,
			CenHandlingTypes handlingType,
			String classCode,
			int quantity,
			int priority) {

		CenOutHandling handling = new CenOutHandling();

		// Set composite key
		CenOutHandlingId id = new CenOutHandlingId();
		id.setNresultKey(context.getResultKey());
		id.setNdetailKey(generateDetailKey());
		handling.setId(id);

		// Set handling details
		handling.setChandlingCode(handlingType.getChandlingCode());
		handling.setCclass(classCode);
		handling.setNquantity(BigDecimal.valueOf(quantity));
		handling.setNprio(priority);

		// Set description
		handling.setCdescription(handlingType.getCdescription());

		// Set handling type reference
		handling.setNhandlingTypeKey(handlingType.getNhandlingTypeKey());

		return handling;
	}

	/**
	 * Calculate extra items (newspapers, magazines, amenity kits).
	 *
	 * <p>PowerBuilder: uf_calculate_extra()
	 *
	 * <p>Extra items are typically:
	 * <ul>
	 *   <li>Newspapers (one per PAX in First/Business)</li>
	 *   <li>Magazines (one per row or per PAX)</li>
	 *   <li>Amenity kits (one per PAX in premium classes)</li>
	 *   <li>Headphones, blankets, pillows</li>
	 * </ul>
	 *
	 * @param context Meal calculation context
	 * @return List of extra item handling records
	 */
	public List<CenOutHandling> calculateExtraItems(MealCalculationContext context) {
		Long resultKey = context.getResultKey();
		Long rotationKey = context.getRotationKey();

		LOGGER.info("Calculating extra items for result_key={}", resultKey);

		if (rotationKey == null) {
			LOGGER.warn("No rotation_key available, cannot calculate extra items");
			return Collections.emptyList();
		}

		// Get extra item handling types (module_type = 1)
		List<CenHandlingTypes> extraTypes = handlingTypesRepository
				.findByRotationKeyAndModuleType(rotationKey, 1);

		if (extraTypes.isEmpty()) {
			LOGGER.debug("No extra item types found for rotation_key={}", rotationKey);
			return Collections.emptyList();
		}

		LOGGER.debug("Found {} extra item types for rotation_key={}",
				extraTypes.size(), rotationKey);

		// Calculate same as handling
		List<CenOutPax> paxData = context.getPaxData();
		Map<String, Integer> paxByClass = aggregatePaxByClass(paxData);

		List<CenOutHandling> extraRecords = new ArrayList<>();
		int priority = 1000; // Start at higher priority to separate from regular handling

		for (CenHandlingTypes extraType : extraTypes) {
			List<CenOutHandling> typeRecords = calculateHandlingForType(
					extraType, paxByClass, Collections.emptyMap(), context, priority);
			extraRecords.addAll(typeRecords);
			priority += typeRecords.size();
		}

		LOGGER.info("Calculated {} extra item records for result_key={}",
				extraRecords.size(), resultKey);

		return extraRecords;
	}

	/**
	 * Determine target classes for handling.
	 *
	 * @param applicableClass Class specification (null/empty = all classes)
	 * @param paxByClass Available classes with PAX
	 * @return List of class codes to apply handling to
	 */
	private List<String> determineTargetClasses(
			String applicableClass,
			Map<String, Integer> paxByClass) {

		if (applicableClass == null || applicableClass.trim().isEmpty()
				|| applicableClass.equals("*")) {
			// Apply to all classes
			return new ArrayList<>(paxByClass.keySet());
		} else {
			// Apply to specific class only
			return paxByClass.containsKey(applicableClass)
					? Collections.singletonList(applicableClass)
					: Collections.emptyList();
		}
	}

	/**
	 * Get handling types for a rotation.
	 *
	 * @param rotationKey Rotation key
	 * @return List of handling type definitions
	 */
	private List<CenHandlingTypes> getHandlingTypes(Long rotationKey) {
		// Get handling types (module_type = 0 for regular handling)
		return handlingTypesRepository.findByRotationKeyAndModuleType(rotationKey, 0);
	}

	/**
	 * Aggregate PAX by class.
	 *
	 * @param paxData PAX records
	 * @return Map of class to PAX count
	 */
	private Map<String, Integer> aggregatePaxByClass(List<CenOutPax> paxData) {
		if (paxData == null || paxData.isEmpty()) {
			return Collections.emptyMap();
		}

		return paxData.stream()
				.collect(Collectors.groupingBy(
						CenOutPax::getCclass,
						Collectors.summingInt(p -> p.getNquantity() != null
								? p.getNquantity().intValue()
								: 0)));
	}

	/**
	 * Group meals by class.
	 *
	 * @param meals Meal records
	 * @return Map of class to meals
	 */
	private Map<String, List<CenOutMeals>> groupMealsByClass(List<CenOutMeals> meals) {
		if (meals == null || meals.isEmpty()) {
			return Collections.emptyMap();
		}

		return meals.stream()
				.collect(Collectors.groupingBy(
						m -> m.getCclass() != null ? m.getCclass() : "Y"));
	}

	/**
	 * Get total meal count for a class.
	 *
	 * @param mealsByClass Meals grouped by class
	 * @param classCode Service class
	 * @return Total meal count
	 */
	private int getMealCountForClass(
			Map<String, List<CenOutMeals>> mealsByClass,
			String classCode) {

		List<CenOutMeals> classMeals = mealsByClass.get(classCode);
		if (classMeals == null || classMeals.isEmpty()) {
			return 0;
		}

		return classMeals.stream()
				.mapToInt(m -> m.getNquantity() != null ? m.getNquantity().intValue() : 0)
				.sum();
	}

	/**
	 * Generate unique detail key for handling record.
	 *
	 * <p>In production, this would use a database sequence or similar.
	 *
	 * @return Detail key
	 */
	private Long generateDetailKey() {
		return System.currentTimeMillis();
	}

	/**
	 * Validate handling records.
	 *
	 * @param handlingRecords Handling records to validate
	 * @return List of validation warnings
	 */
	public List<String> validateHandling(List<CenOutHandling> handlingRecords) {
		List<String> warnings = new ArrayList<>();

		if (handlingRecords == null || handlingRecords.isEmpty()) {
			return warnings;
		}

		// Check for duplicate handling codes per class
		Map<String, Set<String>> codesByClass = new HashMap<>();

		for (CenOutHandling handling : handlingRecords) {
			String classCode = handling.getCclass();
			String handlingCode = handling.getChandlingCode();

			Set<String> classCodes = codesByClass.computeIfAbsent(
					classCode, k -> new HashSet<>());

			if (classCodes.contains(handlingCode)) {
				String warning = String.format(
						"Duplicate handling code '%s' for class '%s'",
						handlingCode, classCode);
				warnings.add(warning);
				LOGGER.warn(warning);
			} else {
				classCodes.add(handlingCode);
			}
		}

		return warnings;
	}
}
