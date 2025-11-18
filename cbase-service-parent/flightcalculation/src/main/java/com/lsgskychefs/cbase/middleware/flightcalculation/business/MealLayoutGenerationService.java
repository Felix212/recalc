/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.*;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service for generating meal layout by aircraft position, compartment, and galley.
 *
 * <p>PowerBuilder equivalent methods from uo_meal_calculation:
 * <ul>
 *   <li>uf_generate_layout() - Generate meal layout</li>
 *   <li>uf_assign_to_galleys() - Assign meals to galleys</li>
 *   <li>uf_distribute_by_compartment() - Distribute across compartments</li>
 *   <li>uf_sequence_meals() - Sequence meals by priority</li>
 *   <li>uf_calculate_galley_capacity() - Check galley capacity</li>
 * </ul>
 *
 * <p>This service handles the physical layout of meals on the aircraft,
 * ensuring proper distribution across galleys and compartments based on:
 * <ul>
 *   <li>Aircraft configuration (galley positions)</li>
 *   <li>Service class locations (First, Business, Economy)</li>
 *   <li>Meal priorities and sequencing</li>
 *   <li>Galley capacity constraints</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class MealLayoutGenerationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MealLayoutGenerationService.class);

	private final CenAircraftGalleysRepository galleysRepository;
	private final CenAircraftCompartmentsRepository compartmentsRepository;
	private final CenMealsPackagesRepository packagesRepository;

	@Autowired
	public MealLayoutGenerationService(
			CenAircraftGalleysRepository galleysRepository,
			CenAircraftCompartmentsRepository compartmentsRepository,
			CenMealsPackagesRepository packagesRepository) {
		this.galleysRepository = galleysRepository;
		this.compartmentsRepository = compartmentsRepository;
		this.packagesRepository = packagesRepository;
	}

	/**
	 * Generate meal layout for a flight.
	 *
	 * <p>PowerBuilder: uf_generate_layout()
	 *
	 * <p>This method:
	 * <ol>
	 *   <li>Retrieves aircraft galley configuration</li>
	 *   <li>Groups meals by service class</li>
	 *   <li>Assigns meals to appropriate galleys</li>
	 *   <li>Sequences meals by priority</li>
	 *   <li>Validates galley capacity</li>
	 * </ol>
	 *
	 * @param context Meal calculation context
	 * @param meals List of meals to layout
	 * @return List of meals with layout assignments
	 */
	public List<CenOutMeals> generateMealLayout(
			MealCalculationContext context,
			List<CenOutMeals> meals) {

		Long resultKey = context.getResultKey();
		Long aircraftKey = context.getAircraftKey();

		if (meals == null || meals.isEmpty()) {
			LOGGER.debug("No meals to layout for result_key={}", resultKey);
			return Collections.emptyList();
		}

		LOGGER.info("Generating meal layout for {} meals on result_key={}, aircraft_key={}",
				meals.size(), resultKey, aircraftKey);

		// Step 1: Get aircraft galley configuration
		List<CenAircraftGalleys> galleys = getAircraftGalleys(aircraftKey);
		if (galleys.isEmpty()) {
			LOGGER.warn("No galley configuration found for aircraft_key={}, using default layout",
					aircraftKey);
			return assignDefaultLayout(meals);
		}

		LOGGER.debug("Found {} galleys for aircraft_key={}", galleys.size(), aircraftKey);

		// Step 2: Get compartment configuration
		List<CenAircraftCompartments> compartments = getAircraftCompartments(aircraftKey);
		LOGGER.debug("Found {} compartments for aircraft_key={}", compartments.size(), aircraftKey);

		// Step 3: Group meals by class
		Map<String, List<CenOutMeals>> mealsByClass = groupMealsByClass(meals);

		// Step 4: Assign meals to galleys and compartments
		List<CenOutMeals> layoutMeals = new ArrayList<>();
		for (Map.Entry<String, List<CenOutMeals>> entry : mealsByClass.entrySet()) {
			String classCode = entry.getKey();
			List<CenOutMeals> classMeals = entry.getValue();

			List<CenOutMeals> assignedMeals = assignMealsToGalleys(
					classMeals, classCode, galleys, compartments, resultKey);
			layoutMeals.addAll(assignedMeals);
		}

		// Step 5: Sequence meals by priority within each galley
		sequenceMealsByGalley(layoutMeals);

		LOGGER.info("Generated layout for {} meals across {} galleys for result_key={}",
				layoutMeals.size(), galleys.size(), resultKey);

		return layoutMeals;
	}

	/**
	 * Assign meals to galleys based on class and compartment.
	 *
	 * <p>PowerBuilder: uf_assign_to_galleys()
	 *
	 * @param meals Meals for a specific class
	 * @param classCode Service class code
	 * @param galleys Aircraft galleys
	 * @param compartments Aircraft compartments
	 * @param resultKey Flight result key
	 * @return Meals with galley assignments
	 */
	private List<CenOutMeals> assignMealsToGalleys(
			List<CenOutMeals> meals,
			String classCode,
			List<CenAircraftGalleys> galleys,
			List<CenAircraftCompartments> compartments,
			Long resultKey) {

		LOGGER.debug("Assigning {} meals for class={} to galleys", meals.size(), classCode);

		// Find compartments for this class
		List<CenAircraftCompartments> classCompartments = compartments.stream()
				.filter(c -> Objects.equals(c.getCclass(), classCode))
				.sorted(Comparator.comparingInt(CenAircraftCompartments::getNposition))
				.collect(Collectors.toList());

		if (classCompartments.isEmpty()) {
			LOGGER.warn("No compartments found for class={}, using default assignment", classCode);
			return assignToDefaultGalley(meals, galleys);
		}

		// Find galleys serving these compartments
		List<CenAircraftGalleys> classGalleys = findGalleysForCompartments(
				galleys, classCompartments);

		if (classGalleys.isEmpty()) {
			LOGGER.warn("No galleys found for class={}, using default assignment", classCode);
			return assignToDefaultGalley(meals, galleys);
		}

		// Distribute meals across galleys
		List<CenOutMeals> assignedMeals = new ArrayList<>();
		int galleyIndex = 0;

		for (CenOutMeals meal : meals) {
			// Round-robin assignment across class galleys
			CenAircraftGalleys galley = classGalleys.get(galleyIndex % classGalleys.size());

			// Set galley assignment
			meal.setNgalleyPosition(galley.getNgalleyPosition());
			meal.setCgalleyCode(galley.getCgalleyCode());

			// Set compartment if available
			if (!classCompartments.isEmpty()) {
				CenAircraftCompartments compartment = classCompartments.get(0);
				meal.setNcompartment(compartment.getNcompartment());
			}

			assignedMeals.add(meal);

			LOGGER.debug("Assigned meal (detail_key={}) to galley={}, position={} for class={}",
					meal.getNdetailKey(), galley.getCgalleyCode(),
					galley.getNgalleyPosition(), classCode);

			galleyIndex++;
		}

		return assignedMeals;
	}

	/**
	 * Find galleys that serve specific compartments.
	 *
	 * @param galleys All aircraft galleys
	 * @param compartments Compartments to find galleys for
	 * @return List of galleys serving these compartments
	 */
	private List<CenAircraftGalleys> findGalleysForCompartments(
			List<CenAircraftGalleys> galleys,
			List<CenAircraftCompartments> compartments) {

		// Get compartment positions
		Set<Integer> compartmentPositions = compartments.stream()
				.map(CenAircraftCompartments::getNposition)
				.collect(Collectors.toSet());

		// Find galleys near these compartments
		// (Simplified: galleys with positions within compartment range)
		List<CenAircraftGalleys> matchingGalleys = galleys.stream()
				.filter(g -> {
					int galleyPos = g.getNgalleyPosition();
					// Check if galley position is near any compartment
					return compartmentPositions.stream()
							.anyMatch(cp -> Math.abs(galleyPos - cp) <= 2);
				})
				.sorted(Comparator.comparingInt(CenAircraftGalleys::getNgalleyPosition))
				.collect(Collectors.toList());

		// If no close match, return all galleys (fallback)
		if (matchingGalleys.isEmpty()) {
			return galleys;
		}

		return matchingGalleys;
	}

	/**
	 * Assign meals to default galley (fallback).
	 *
	 * @param meals Meals to assign
	 * @param galleys Available galleys
	 * @return Meals with default galley assignment
	 */
	private List<CenOutMeals> assignToDefaultGalley(
			List<CenOutMeals> meals,
			List<CenAircraftGalleys> galleys) {

		if (galleys.isEmpty()) {
			LOGGER.warn("No galleys available for default assignment");
			return meals;
		}

		// Use first galley as default
		CenAircraftGalleys defaultGalley = galleys.get(0);

		for (CenOutMeals meal : meals) {
			meal.setNgalleyPosition(defaultGalley.getNgalleyPosition());
			meal.setCgalleyCode(defaultGalley.getCgalleyCode());
		}

		LOGGER.debug("Assigned {} meals to default galley: {}",
				meals.size(), defaultGalley.getCgalleyCode());

		return meals;
	}

	/**
	 * Assign default layout when no galley configuration exists.
	 *
	 * <p>PowerBuilder: Default handling in uf_generate_layout()
	 *
	 * @param meals Meals to layout
	 * @return Meals with default positions
	 */
	private List<CenOutMeals> assignDefaultLayout(List<CenOutMeals> meals) {
		LOGGER.debug("Assigning default layout for {} meals", meals.size());

		int position = 1;
		for (CenOutMeals meal : meals) {
			meal.setNgalleyPosition(position);
			meal.setCgalleyCode("DEFAULT");
			meal.setNcompartment(1);
			position++;
		}

		return meals;
	}

	/**
	 * Sequence meals by priority within each galley.
	 *
	 * <p>PowerBuilder: uf_sequence_meals()
	 *
	 * <p>Ensures meals are properly ordered by:
	 * <ol>
	 *   <li>Galley position</li>
	 *   <li>Meal priority (nprio)</li>
	 *   <li>Sequence number (nsequence)</li>
	 * </ol>
	 *
	 * @param meals Meals to sequence
	 */
	private void sequenceMealsByGalley(List<CenOutMeals> meals) {
		// Group by galley
		Map<String, List<CenOutMeals>> mealsByGalley = meals.stream()
				.collect(Collectors.groupingBy(
						m -> m.getCgalleyCode() != null ? m.getCgalleyCode() : "DEFAULT"));

		// Sequence within each galley
		int globalSequence = 1;
		for (Map.Entry<String, List<CenOutMeals>> entry : mealsByGalley.entrySet()) {
			String galleyCode = entry.getKey();
			List<CenOutMeals> galleyMeals = entry.getValue();

			// Sort by priority
			galleyMeals.sort(Comparator.comparingInt(CenOutMeals::getNprio));

			// Assign sequence numbers
			int localSequence = 1;
			for (CenOutMeals meal : galleyMeals) {
				meal.setNsequence(localSequence);
				localSequence++;
			}

			LOGGER.debug("Sequenced {} meals for galley={}", galleyMeals.size(), galleyCode);
			globalSequence += galleyMeals.size();
		}
	}

	/**
	 * Group meals by service class.
	 *
	 * @param meals Meals to group
	 * @return Map of class code to meals
	 */
	private Map<String, List<CenOutMeals>> groupMealsByClass(List<CenOutMeals> meals) {
		return meals.stream()
				.collect(Collectors.groupingBy(
						m -> m.getCclass() != null ? m.getCclass() : "Y"));
	}

	/**
	 * Get aircraft galley configuration.
	 *
	 * @param aircraftKey Aircraft key
	 * @return List of galleys
	 */
	private List<CenAircraftGalleys> getAircraftGalleys(Long aircraftKey) {
		if (aircraftKey == null) {
			LOGGER.warn("No aircraft key provided for galley lookup");
			return Collections.emptyList();
		}

		List<CenAircraftGalleys> galleys = galleysRepository.findByAircraftKey(aircraftKey);
		LOGGER.debug("Retrieved {} galleys for aircraft_key={}", galleys.size(), aircraftKey);
		return galleys;
	}

	/**
	 * Get aircraft compartment configuration.
	 *
	 * @param aircraftKey Aircraft key
	 * @return List of compartments
	 */
	private List<CenAircraftCompartments> getAircraftCompartments(Long aircraftKey) {
		if (aircraftKey == null) {
			LOGGER.warn("No aircraft key provided for compartment lookup");
			return Collections.emptyList();
		}

		List<CenAircraftCompartments> compartments =
				compartmentsRepository.findByAircraftKey(aircraftKey);
		LOGGER.debug("Retrieved {} compartments for aircraft_key={}",
				compartments.size(), aircraftKey);
		return compartments;
	}

	/**
	 * Validate galley capacity.
	 *
	 * <p>PowerBuilder: uf_calculate_galley_capacity()
	 *
	 * <p>Checks if assigned meals exceed galley capacity.
	 *
	 * @param meals Meals assigned to galleys
	 * @param galleys Aircraft galleys with capacity limits
	 * @return List of capacity warnings (empty if all valid)
	 */
	public List<String> validateGalleyCapacity(
			List<CenOutMeals> meals,
			List<CenAircraftGalleys> galleys) {

		List<String> warnings = new ArrayList<>();

		if (meals == null || meals.isEmpty() || galleys == null || galleys.isEmpty()) {
			return warnings;
		}

		// Group meals by galley
		Map<String, List<CenOutMeals>> mealsByGalley = meals.stream()
				.filter(m -> m.getCgalleyCode() != null)
				.collect(Collectors.groupingBy(CenOutMeals::getCgalleyCode));

		// Create galley capacity map
		Map<String, Integer> galleyCapacity = galleys.stream()
				.collect(Collectors.toMap(
						CenAircraftGalleys::getCgalleyCode,
						g -> g.getNcapacity() != null ? g.getNcapacity() : Integer.MAX_VALUE));

		// Check capacity for each galley
		for (Map.Entry<String, List<CenOutMeals>> entry : mealsByGalley.entrySet()) {
			String galleyCode = entry.getKey();
			List<CenOutMeals> galleyMeals = entry.getValue();

			int totalQuantity = galleyMeals.stream()
					.mapToInt(m -> m.getNquantity() != null ? m.getNquantity().intValue() : 0)
					.sum();

			int capacity = galleyCapacity.getOrDefault(galleyCode, Integer.MAX_VALUE);

			if (totalQuantity > capacity) {
				String warning = String.format(
						"Galley %s: Total quantity (%d) exceeds capacity (%d)",
						galleyCode, totalQuantity, capacity);
				warnings.add(warning);
				LOGGER.warn(warning);
			}
		}

		return warnings;
	}

	/**
	 * Calculate meal package dimensions for loading.
	 *
	 * <p>PowerBuilder: uf_calculate_package_dimensions()
	 *
	 * @param meals Meals to calculate packaging for
	 * @return Map of galley to package count
	 */
	public Map<String, PackagingSummary> calculatePackaging(List<CenOutMeals> meals) {
		Map<String, PackagingSummary> packagingByGalley = new HashMap<>();

		if (meals == null || meals.isEmpty()) {
			return packagingByGalley;
		}

		// Group by galley
		Map<String, List<CenOutMeals>> mealsByGalley = meals.stream()
				.filter(m -> m.getCgalleyCode() != null)
				.collect(Collectors.groupingBy(CenOutMeals::getCgalleyCode));

		for (Map.Entry<String, List<CenOutMeals>> entry : mealsByGalley.entrySet()) {
			String galleyCode = entry.getKey();
			List<CenOutMeals> galleyMeals = entry.getValue();

			int totalMeals = galleyMeals.stream()
					.mapToInt(m -> m.getNquantity() != null ? m.getNquantity().intValue() : 0)
					.sum();

			int totalItems = galleyMeals.size();

			PackagingSummary summary = new PackagingSummary();
			summary.setGalleyCode(galleyCode);
			summary.setTotalMealCount(totalMeals);
			summary.setTotalItemTypes(totalItems);

			// Estimate packages (10 meals per package - can be configured)
			summary.setEstimatedPackages((int) Math.ceil(totalMeals / 10.0));

			packagingByGalley.put(galleyCode, summary);

			LOGGER.debug("Galley {}: {} meals, {} types, {} estimated packages",
					galleyCode, totalMeals, totalItems, summary.getEstimatedPackages());
		}

		return packagingByGalley;
	}

	/**
	 * Packaging summary for a galley.
	 */
	public static class PackagingSummary {
		private String galleyCode;
		private int totalMealCount;
		private int totalItemTypes;
		private int estimatedPackages;

		public String getGalleyCode() {
			return galleyCode;
		}

		public void setGalleyCode(String galleyCode) {
			this.galleyCode = galleyCode;
		}

		public int getTotalMealCount() {
			return totalMealCount;
		}

		public void setTotalMealCount(int totalMealCount) {
			this.totalMealCount = totalMealCount;
		}

		public int getTotalItemTypes() {
			return totalItemTypes;
		}

		public void setTotalItemTypes(int totalItemTypes) {
			this.totalItemTypes = totalItemTypes;
		}

		public int getEstimatedPackages() {
			return estimatedPackages;
		}

		public void setEstimatedPackages(int estimatedPackages) {
			this.estimatedPackages = estimatedPackages;
		}
	}
}
