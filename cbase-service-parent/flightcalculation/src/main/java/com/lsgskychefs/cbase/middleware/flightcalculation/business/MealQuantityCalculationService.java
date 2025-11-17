/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealCover;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPax;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

/**
 * Service for calculating meal quantities based on PAX counts.
 *
 * <p>PowerBuilder equivalent methods from uo_meal_calculation:
 * <ul>
 *   <li>uf_calculate_meals() - Main calculation</li>
 *   <li>uf_calculate_base_quantity() - Base meal calc</li>
 *   <li>uf_apply_reserves() - Apply reserve quantities</li>
 *   <li>uf_apply_topoffs() - Apply top-off quantities</li>
 *   <li>uf_calculate_ratio() - Meals per PAX ratio</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class MealQuantityCalculationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MealQuantityCalculationService.class);

	/**
	 * Calculate meal quantities for all service classes.
	 *
	 * <p>PowerBuilder: uf_calculate_meals()
	 *
	 * @param paxData List of PAX counts per class
	 * @param mealDefinitions List of meal definitions
	 * @param mealCovers List of meal covers (optional)
	 * @return Map of class code to meal quantities
	 */
	public Map<String, MealQuantityResult> calculateMealQuantities(
			List<CenOutPax> paxData,
			List<CenMeals> mealDefinitions,
			List<CenMealCover> mealCovers) {

		Map<String, MealQuantityResult> results = new HashMap<>();

		LOGGER.info("Calculating meal quantities for {} PAX records and {} meal definitions",
				paxData.size(), mealDefinitions.size());

		// Group PAX by class
		Map<String, Integer> paxByClass = groupPaxByClass(paxData);

		// Calculate for each class
		for (Map.Entry<String, Integer> entry : paxByClass.entrySet()) {
			String classCode = entry.getKey();
			int paxCount = entry.getValue();

			LOGGER.debug("Processing class={}, pax={}", classCode, paxCount);

			// Find meal definition for this class
			Optional<CenMeals> mealDef = findMealDefinitionForClass(
					mealDefinitions, classCode);

			if (mealDef.isPresent()) {
				MealQuantityResult result = calculateForClass(
						paxCount, mealDef.get(), mealCovers);
				results.put(classCode, result);

				LOGGER.info("Class {}: {} PAX -> {} meals (base={}, reserve={}, topoff={})",
						classCode, paxCount, result.getFinalQuantity(),
						result.getBaseQuantity(), result.getReserveQuantity(),
						result.getTopoffQuantity());
			} else {
				LOGGER.warn("No meal definition found for class={}", classCode);
			}
		}

		return results;
	}

	/**
	 * Calculate meal quantity for a single class.
	 *
	 * @param paxCount PAX count for the class
	 * @param mealDef Meal definition
	 * @param mealCovers Meal covers (optional)
	 * @return Calculation result
	 */
	private MealQuantityResult calculateForClass(
			int paxCount,
			CenMeals mealDef,
			List<CenMealCover> mealCovers) {

		MealQuantityResult result = new MealQuantityResult();
		result.setPaxCount(paxCount);

		// Step 1: Calculate base quantity
		int baseQuantity = calculateBaseQuantity(paxCount, mealCovers);
		result.setBaseQuantity(baseQuantity);

		// Step 2: Apply reserves
		int reserveQuantity = applyReserves(
				baseQuantity,
				paxCount,
				mealDef.getNreserveQuantity(),
				mealDef.getNreserveType());
		result.setReserveQuantity(reserveQuantity);

		int quantityWithReserve = baseQuantity + reserveQuantity;

		// Step 3: Apply top-offs
		int topoffQuantity = applyTopOffs(
				quantityWithReserve,
				paxCount,
				mealDef.getNtopoffQuantity(),
				mealDef.getNtopoffType());
		result.setTopoffQuantity(topoffQuantity);

		// Step 4: Final quantity
		int finalQuantity = quantityWithReserve + topoffQuantity;
		result.setFinalQuantity(finalQuantity);

		// Step 5: Calculate ratio
		BigDecimal ratio = calculateRatio(finalQuantity, paxCount);
		result.setRatio(ratio);

		return result;
	}

	/**
	 * Calculate base meal quantity.
	 *
	 * <p>PowerBuilder: uf_calculate_base_quantity()
	 *
	 * <p>Base calculation logic:
	 * <ul>
	 *   <li>If meal covers exist: Use cover ratio * PAX</li>
	 *   <li>Otherwise: 1:1 ratio (1 meal per PAX)</li>
	 * </ul>
	 *
	 * @param paxCount PAX count
	 * @param mealCovers Meal covers (optional)
	 * @return Base meal quantity
	 */
	public int calculateBaseQuantity(int paxCount, List<CenMealCover> mealCovers) {
		if (paxCount == 0) {
			return 0;
		}

		// If no meal covers, use 1:1 ratio
		if (mealCovers == null || mealCovers.isEmpty()) {
			LOGGER.debug("No meal covers, using 1:1 ratio: {} PAX -> {} meals",
					paxCount, paxCount);
			return paxCount;
		}

		// Use meal cover ratio (typically the first cover)
		CenMealCover primaryCover = mealCovers.get(0);
		// Note: Meal cover ratio logic would go here if the entity has a ratio field
		// For now, use 1:1 as default
		int baseQuantity = paxCount;

		LOGGER.debug("Base quantity calculated: {} meals for {} PAX",
				baseQuantity, paxCount);

		return baseQuantity;
	}

	/**
	 * Apply reserve quantities.
	 *
	 * <p>PowerBuilder: uf_apply_reserves()
	 *
	 * <p>Reserve types:
	 * <ul>
	 *   <li>0: Fixed quantity</li>
	 *   <li>1: Percentage of PAX</li>
	 *   <li>2: Percentage of base meals</li>
	 * </ul>
	 *
	 * @param baseMealQuantity Base meal quantity
	 * @param paxCount PAX count
	 * @param reserveQuantity Reserve amount
	 * @param reserveType Reserve type (0, 1, or 2)
	 * @return Additional reserve quantity
	 */
	public int applyReserves(
			int baseMealQuantity,
			int paxCount,
			int reserveQuantity,
			int reserveType) {

		if (reserveQuantity == 0) {
			return 0;
		}

		int reserve;

		switch (reserveType) {
			case 0:
				// Fixed quantity
				reserve = reserveQuantity;
				LOGGER.debug("Reserve (fixed): {}", reserve);
				break;

			case 1:
				// Percentage of PAX
				reserve = (int) Math.ceil((paxCount * reserveQuantity) / 100.0);
				LOGGER.debug("Reserve ({}% of {} PAX): {}",
						reserveQuantity, paxCount, reserve);
				break;

			case 2:
				// Percentage of base meals
				reserve = (int) Math.ceil((baseMealQuantity * reserveQuantity) / 100.0);
				LOGGER.debug("Reserve ({}% of {} meals): {}",
						reserveQuantity, baseMealQuantity, reserve);
				break;

			default:
				LOGGER.warn("Unknown reserve type: {}, using 0", reserveType);
				reserve = 0;
		}

		return reserve;
	}

	/**
	 * Apply top-off quantities.
	 *
	 * <p>PowerBuilder: uf_apply_topoffs()
	 *
	 * <p>Top-off types:
	 * <ul>
	 *   <li>0: Fixed quantity</li>
	 *   <li>1: Percentage of current quantity</li>
	 *   <li>2: Round up to nearest multiple</li>
	 * </ul>
	 *
	 * @param mealQuantity Current meal quantity
	 * @param paxCount PAX count
	 * @param topoffQuantity Top-off amount
	 * @param topoffType Top-off type (0, 1, or 2)
	 * @return Additional top-off quantity
	 */
	public int applyTopOffs(
			int mealQuantity,
			int paxCount,
			int topoffQuantity,
			int topoffType) {

		if (topoffQuantity == 0) {
			return 0;
		}

		int topoff;

		switch (topoffType) {
			case 0:
				// Fixed quantity
				topoff = topoffQuantity;
				LOGGER.debug("Top-off (fixed): {}", topoff);
				break;

			case 1:
				// Percentage of current quantity
				topoff = (int) Math.ceil((mealQuantity * topoffQuantity) / 100.0);
				LOGGER.debug("Top-off ({}% of {} meals): {}",
						topoffQuantity, mealQuantity, topoff);
				break;

			case 2:
				// Round up to nearest multiple
				int roundedUp = roundUpToMultiple(mealQuantity, topoffQuantity);
				topoff = roundedUp - mealQuantity;
				LOGGER.debug("Top-off (round to multiple of {}): {} -> {}, topoff={}",
						topoffQuantity, mealQuantity, roundedUp, topoff);
				break;

			default:
				LOGGER.warn("Unknown topoff type: {}, using 0", topoffType);
				topoff = 0;
		}

		return topoff;
	}

	/**
	 * Round up to nearest multiple.
	 *
	 * @param value Value to round
	 * @param multiple Multiple to round to
	 * @return Rounded value
	 */
	private int roundUpToMultiple(int value, int multiple) {
		if (multiple <= 0) {
			return value;
		}
		return ((value + multiple - 1) / multiple) * multiple;
	}

	/**
	 * Calculate meal ratio (meals per passenger).
	 *
	 * <p>PowerBuilder: uf_calculate_ratio()
	 *
	 * @param mealQuantity Total meal quantity
	 * @param paxCount PAX count
	 * @return Ratio with 3 decimal places
	 */
	public BigDecimal calculateRatio(int mealQuantity, int paxCount) {
		if (paxCount == 0) {
			return BigDecimal.ZERO;
		}

		BigDecimal ratio = BigDecimal.valueOf(mealQuantity)
				.divide(BigDecimal.valueOf(paxCount), 3, RoundingMode.HALF_UP);

		LOGGER.debug("Calculated ratio: {} meals / {} PAX = {}",
				mealQuantity, paxCount, ratio);

		return ratio;
	}

	/**
	 * Group PAX data by service class.
	 *
	 * @param paxData List of PAX records
	 * @return Map of class code to total PAX count
	 */
	private Map<String, Integer> groupPaxByClass(List<CenOutPax> paxData) {
		Map<String, Integer> grouped = new HashMap<>();

		for (CenOutPax pax : paxData) {
			String classCode = pax.getCclass();
			int paxCount = pax.getNpax() != null ? pax.getNpax().intValue() : 0;

			grouped.merge(classCode, paxCount, Integer::sum);
		}

		return grouped;
	}

	/**
	 * Find meal definition for a service class.
	 *
	 * @param mealDefinitions List of meal definitions
	 * @param classCode Service class code
	 * @return Meal definition if found
	 */
	private Optional<CenMeals> findMealDefinitionForClass(
			List<CenMeals> mealDefinitions,
			String classCode) {

		return mealDefinitions.stream()
				.filter(m -> Objects.equals(String.valueOf(m.getNclassNumber()), classCode))
				.findFirst();
	}

	/**
	 * Result of meal quantity calculation for a class.
	 */
	public static class MealQuantityResult {
		private int paxCount;
		private int baseQuantity;
		private int reserveQuantity;
		private int topoffQuantity;
		private int finalQuantity;
		private BigDecimal ratio;

		// Getters and setters

		public int getPaxCount() {
			return paxCount;
		}

		public void setPaxCount(int paxCount) {
			this.paxCount = paxCount;
		}

		public int getBaseQuantity() {
			return baseQuantity;
		}

		public void setBaseQuantity(int baseQuantity) {
			this.baseQuantity = baseQuantity;
		}

		public int getReserveQuantity() {
			return reserveQuantity;
		}

		public void setReserveQuantity(int reserveQuantity) {
			this.reserveQuantity = reserveQuantity;
		}

		public int getTopoffQuantity() {
			return topoffQuantity;
		}

		public void setTopoffQuantity(int topoffQuantity) {
			this.topoffQuantity = topoffQuantity;
		}

		public int getFinalQuantity() {
			return finalQuantity;
		}

		public void setFinalQuantity(int finalQuantity) {
			this.finalQuantity = finalQuantity;
		}

		public BigDecimal getRatio() {
			return ratio;
		}

		public void setRatio(BigDecimal ratio) {
			this.ratio = ratio;
		}
	}
}
