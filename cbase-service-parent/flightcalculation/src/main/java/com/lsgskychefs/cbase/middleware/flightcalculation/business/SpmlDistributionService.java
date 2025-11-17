/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenMealsSpmlRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsSpml;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service for distributing special meals (SPML) and deducting from regular meals.
 *
 * <p>PowerBuilder equivalent methods from uo_meal_calculation:
 * <ul>
 *   <li>uf_calculate_spml() - Calculate SPML distribution</li>
 *   <li>uf_distribute_spml() - Distribute SPML across meals</li>
 *   <li>uf_deduct_spml_from_meals() - Deduct from regular meals</li>
 *   <li>of_resolve_spml() - Resolve SPML codes to definitions</li>
 * </ul>
 *
 * <p>SPML (Special Meals) are dietary-specific meals such as:
 * <ul>
 *   <li>VGML - Vegetarian meal</li>
 *   <li>KSML - Kosher meal</li>
 *   <li>GFML - Gluten-free meal</li>
 *   <li>DBML - Diabetic meal</li>
 *   <li>MOML - Muslim meal</li>
 *   <li>etc.</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class SpmlDistributionService {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpmlDistributionService.class);

	private final CenMealsSpmlRepository spmlRepository;

	@Autowired
	public SpmlDistributionService(CenMealsSpmlRepository spmlRepository) {
		this.spmlRepository = spmlRepository;
	}

	/**
	 * Distribute special meals and deduct from regular meals.
	 *
	 * <p>PowerBuilder: uf_calculate_spml() + uf_distribute_spml()
	 *
	 * <p>This method:
	 * <ol>
	 *   <li>Groups SPML by class and code</li>
	 *   <li>Finds matching meal definitions for each SPML</li>
	 *   <li>Deducts SPML quantities from regular meals</li>
	 *   <li>Creates SPML meal records</li>
	 * </ol>
	 *
	 * @param context Meal calculation context with SPML data
	 * @param regularMeals List of regular meal records
	 * @return List of SPML distribution results
	 */
	public List<SpmlDistribution> distributeSpecialMeals(
			MealCalculationContext context,
			List<CenOutMeals> regularMeals) {

		List<CenOutSpml> spmlData = context.getSpmlData();
		Long resultKey = context.getResultKey();
		Long rotationKey = context.getRotationKey();

		if (spmlData == null || spmlData.isEmpty()) {
			LOGGER.debug("No SPML data for result_key={}", resultKey);
			return Collections.emptyList();
		}

		LOGGER.info("Distributing {} SPML records for result_key={}",
				spmlData.size(), resultKey);

		List<SpmlDistribution> distributions = new ArrayList<>();

		// Group SPML by class
		Map<String, List<CenOutSpml>> spmlByClass = groupSpmlByClass(spmlData);

		for (Map.Entry<String, List<CenOutSpml>> entry : spmlByClass.entrySet()) {
			String classCode = entry.getKey();
			List<CenOutSpml> classSpml = entry.getValue();

			LOGGER.debug("Processing {} SPML records for class={}",
					classSpml.size(), classCode);

			// Find regular meals for this class
			List<CenOutMeals> classMeals = findMealsForClass(regularMeals, classCode);

			// Distribute each SPML type
			for (CenOutSpml spml : classSpml) {
				SpmlDistribution dist = distributeSpmlType(
						spml, classMeals, rotationKey, resultKey);
				if (dist != null) {
					distributions.add(dist);
				}
			}
		}

		LOGGER.info("Created {} SPML distributions for result_key={}",
				distributions.size(), resultKey);

		return distributions;
	}

	/**
	 * Distribute a single SPML type.
	 *
	 * @param spml SPML record
	 * @param classMeals Regular meals for the class
	 * @param rotationKey Rotation key
	 * @param resultKey Flight result key
	 * @return SPML distribution result
	 */
	private SpmlDistribution distributeSpmlType(
			CenOutSpml spml,
			List<CenOutMeals> classMeals,
			Long rotationKey,
			Long resultKey) {

		String spmlCode = spml.getCspml();
		int spmlQuantity = spml.getNquantity().intValue();

		LOGGER.debug("Distributing SPML code={}, quantity={} for result_key={}",
				spmlCode, spmlQuantity, resultKey);

		// Resolve SPML definition
		Optional<CenMealsSpml> spmlDef = resolveSpmlCode(spmlCode, rotationKey);

		if (!spmlDef.isPresent()) {
			LOGGER.warn("SPML code={} not found in definitions for rotation_key={}",
					spmlCode, rotationKey);
			// Still create distribution with basic info
			return createBasicSpmlDistribution(spml, classMeals);
		}

		// Create distribution
		SpmlDistribution dist = new SpmlDistribution();
		dist.setSpmlCode(spmlCode);
		dist.setSpmlQuantity(spmlQuantity);
		dist.setClassCode(spml.getCclass());
		dist.setSpmlDefinition(spmlDef.get());

		// Deduct from regular meals
		int deducted = deductFromRegularMeals(classMeals, spmlQuantity);
		dist.setDeductedQuantity(deducted);

		LOGGER.info("SPML {}: {} quantity, {} deducted from regular meals",
				spmlCode, spmlQuantity, deducted);

		return dist;
	}

	/**
	 * Deduct SPML quantities from regular meals.
	 *
	 * <p>PowerBuilder: uf_deduct_spml_from_meals()
	 *
	 * <p>Logic:
	 * <ol>
	 *   <li>Find the first available regular meal</li>
	 *   <li>Deduct SPML quantity from it</li>
	 *   <li>If not enough, move to next meal</li>
	 *   <li>Track total deducted</li>
	 * </ol>
	 *
	 * @param regularMeals List of regular meals
	 * @param spmlQuantity Quantity to deduct
	 * @return Total quantity deducted
	 */
	public int deductFromRegularMeals(List<CenOutMeals> regularMeals, int spmlQuantity) {
		if (regularMeals == null || regularMeals.isEmpty()) {
			LOGGER.warn("No regular meals available for SPML deduction");
			return 0;
		}

		int remainingToDeduct = spmlQuantity;
		int totalDeducted = 0;

		// Sort meals by priority for deduction
		List<CenOutMeals> sortedMeals = regularMeals.stream()
				.sorted(Comparator.comparingInt(CenOutMeals::getNprio))
				.collect(Collectors.toList());

		for (CenOutMeals meal : sortedMeals) {
			if (remainingToDeduct <= 0) {
				break;
			}

			int currentQuantity = meal.getNquantity() != null
					? meal.getNquantity().intValue()
					: 0;

			if (currentQuantity > 0) {
				int toDeduct = Math.min(currentQuantity, remainingToDeduct);

				// Deduct from meal
				int newQuantity = currentQuantity - toDeduct;
				meal.setNquantity(BigDecimal.valueOf(newQuantity));

				remainingToDeduct -= toDeduct;
				totalDeducted += toDeduct;

				LOGGER.debug("Deducted {} from meal (detail_key={}): {} -> {}",
						toDeduct, meal.getNdetailKey(),
						currentQuantity, newQuantity);
			}
		}

		if (remainingToDeduct > 0) {
			LOGGER.warn("Could not deduct all SPML: {} remaining after deducting {}",
					remainingToDeduct, totalDeducted);
		}

		return totalDeducted;
	}

	/**
	 * Resolve SPML code to meal definition.
	 *
	 * <p>PowerBuilder: of_resolve_spml()
	 *
	 * @param spmlCode SPML code (e.g., VGML, KSML)
	 * @param rotationKey Rotation key
	 * @return SPML definition if found
	 */
	public Optional<CenMealsSpml> resolveSpmlCode(String spmlCode, Long rotationKey) {
		if (spmlCode == null || spmlCode.trim().isEmpty()) {
			return Optional.empty();
		}

		// Try rotation-specific definition first
		if (rotationKey != null) {
			Optional<CenMealsSpml> spmlDef = spmlRepository
					.findBySpmlCodeAndRotation(spmlCode, rotationKey);
			if (spmlDef.isPresent()) {
				LOGGER.debug("Found SPML definition: code={}, rotation={}",
						spmlCode, rotationKey);
				return spmlDef;
			}
		}

		// Fall back to generic SPML code
		Optional<CenMealsSpml> spmlDef = spmlRepository.findBySpmlCode(spmlCode);
		if (spmlDef.isPresent()) {
			LOGGER.debug("Found generic SPML definition: code={}", spmlCode);
		} else {
			LOGGER.debug("No SPML definition found for code={}", spmlCode);
		}

		return spmlDef;
	}

	/**
	 * Validate SPML quantities against PAX.
	 *
	 * <p>Ensures SPML quantities do not exceed total PAX for the class.
	 *
	 * @param spmlData SPML records
	 * @param paxByClass PAX counts by class
	 * @return List of validation warnings (empty if all valid)
	 */
	public List<String> validateSpmlQuantities(
			List<CenOutSpml> spmlData,
			Map<String, Integer> paxByClass) {

		List<String> warnings = new ArrayList<>();

		if (spmlData == null || spmlData.isEmpty()) {
			return warnings;
		}

		// Group SPML by class
		Map<String, Integer> spmlByClass = new HashMap<>();
		for (CenOutSpml spml : spmlData) {
			String classCode = spml.getCclass();
			int quantity = spml.getNquantity().intValue();
			spmlByClass.merge(classCode, quantity, Integer::sum);
		}

		// Validate against PAX
		for (Map.Entry<String, Integer> entry : spmlByClass.entrySet()) {
			String classCode = entry.getKey();
			int totalSpml = entry.getValue();
			int totalPax = paxByClass.getOrDefault(classCode, 0);

			if (totalSpml > totalPax) {
				String warning = String.format(
						"Class %s: SPML quantity (%d) exceeds PAX count (%d)",
						classCode, totalSpml, totalPax);
				warnings.add(warning);
				LOGGER.warn(warning);
			}
		}

		return warnings;
	}

	/**
	 * Group SPML by service class.
	 */
	private Map<String, List<CenOutSpml>> groupSpmlByClass(List<CenOutSpml> spmlData) {
		return spmlData.stream()
				.collect(Collectors.groupingBy(CenOutSpml::getCclass));
	}

	/**
	 * Find meals for a specific class.
	 */
	private List<CenOutMeals> findMealsForClass(
			List<CenOutMeals> meals,
			String classCode) {

		return meals.stream()
				.filter(m -> Objects.equals(m.getCclass(), classCode))
				.collect(Collectors.toList());
	}

	/**
	 * Create basic SPML distribution when definition not found.
	 */
	private SpmlDistribution createBasicSpmlDistribution(
			CenOutSpml spml,
			List<CenOutMeals> classMeals) {

		SpmlDistribution dist = new SpmlDistribution();
		dist.setSpmlCode(spml.getCspml());
		dist.setSpmlQuantity(spml.getNquantity().intValue());
		dist.setClassCode(spml.getCclass());

		// Still try to deduct from regular meals
		int deducted = deductFromRegularMeals(classMeals, dist.getSpmlQuantity());
		dist.setDeductedQuantity(deducted);

		return dist;
	}

	/**
	 * Result of SPML distribution.
	 */
	public static class SpmlDistribution {
		private String spmlCode;
		private int spmlQuantity;
		private String classCode;
		private int deductedQuantity;
		private CenMealsSpml spmlDefinition;

		// Getters and setters

		public String getSpmlCode() {
			return spmlCode;
		}

		public void setSpmlCode(String spmlCode) {
			this.spmlCode = spmlCode;
		}

		public int getSpmlQuantity() {
			return spmlQuantity;
		}

		public void setSpmlQuantity(int spmlQuantity) {
			this.spmlQuantity = spmlQuantity;
		}

		public String getClassCode() {
			return classCode;
		}

		public void setClassCode(String classCode) {
			this.classCode = classCode;
		}

		public int getDeductedQuantity() {
			return deductedQuantity;
		}

		public void setDeductedQuantity(int deductedQuantity) {
			this.deductedQuantity = deductedQuantity;
		}

		public CenMealsSpml getSpmlDefinition() {
			return spmlDefinition;
		}

		public void setSpmlDefinition(CenMealsSpml spmlDefinition) {
			this.spmlDefinition = spmlDefinition;
		}
	}
}
