/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for MealQuantityCalculationService.
 *
 * <p>Tests cover:
 * <ul>
 *   <li>Base quantity calculation from PAX</li>
 *   <li>Reserve calculations (fixed, % PAX, % meals)</li>
 *   <li>Top-off calculations (fixed, percentage, round to multiple)</li>
 *   <li>Ratio-based calculations</li>
 *   <li>Edge cases (zero PAX, missing data, etc.)</li>
 * </ul>
 *
 * @author Migration Team
 */
@DisplayName("Meal Quantity Calculation Service Tests")
class MealQuantityCalculationServiceTest {

	private MealQuantityCalculationService service;
	private MealCalculationContext context;

	@BeforeEach
	void setUp() {
		service = new MealQuantityCalculationService();
		context = createTestContext();
	}

	@Test
	@DisplayName("Calculate base quantity from PAX count")
	void testCalculateBaseQuantity() {
		// Given: 150 PAX in economy class
		List<CenOutPax> paxData = createPaxData("Y", 150);
		context.setPaxData(paxData);

		CenMeals mealDef = createMealDefinition("Y", "MEAL1", 1.0);

		// When
		int quantity = service.calculateBaseQuantity(context, mealDef, "Y");

		// Then: Should calculate 150 * 1.0 = 150 meals
		assertEquals(150, quantity, "Base quantity should be PAX count * ratio");
	}

	@Test
	@DisplayName("Calculate with ratio less than 1.0")
	void testCalculateBaseQuantityWithRatio() {
		// Given: 150 PAX, ratio 0.8 (80% take rate)
		List<CenOutPax> paxData = createPaxData("Y", 150);
		context.setPaxData(paxData);

		CenMeals mealDef = createMealDefinition("Y", "MEAL1", 0.8);

		// When
		int quantity = service.calculateBaseQuantity(context, mealDef, "Y");

		// Then: Should calculate ceil(150 * 0.8) = 120 meals
		assertEquals(120, quantity, "Should apply ratio and round up");
	}

	@Test
	@DisplayName("Apply fixed reserve")
	void testApplyReservesFixed() {
		// Given: 100 base meals, fixed reserve of 10
		int baseMeals = 100;
		int paxCount = 120;
		int reserveQuantity = 10;
		int reserveType = 0; // Fixed

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType);

		// Then: Should return exactly 10
		assertEquals(10, reserve, "Fixed reserve should return exact quantity");
	}

	@Test
	@DisplayName("Apply percentage of PAX reserve")
	void testApplyReservesPercentagePax() {
		// Given: 100 base meals, 120 PAX, 10% reserve
		int baseMeals = 100;
		int paxCount = 120;
		int reserveQuantity = 10; // 10%
		int reserveType = 1; // Percentage of PAX

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType);

		// Then: Should calculate ceil(120 * 10 / 100) = 12
		assertEquals(12, reserve, "Should calculate 10% of PAX count");
	}

	@Test
	@DisplayName("Apply percentage of meals reserve")
	void testApplyReservesPercentageMeals() {
		// Given: 100 base meals, 10% reserve
		int baseMeals = 100;
		int paxCount = 120;
		int reserveQuantity = 10; // 10%
		int reserveType = 2; // Percentage of meals

		// When
		int reserve = service.applyReserves(baseMeals, paxCount, reserveQuantity, reserveType);

		// Then: Should calculate ceil(100 * 10 / 100) = 10
		assertEquals(10, reserve, "Should calculate 10% of base meals");
	}

	@Test
	@DisplayName("Apply fixed top-off")
	void testApplyTopOffsFixed() {
		// Given: 110 meals with reserves, fixed top-off of 5
		int mealQuantity = 110;
		int paxCount = 120;
		int topoffQuantity = 5;
		int topoffType = 0; // Fixed

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType);

		// Then: Should return exactly 5
		assertEquals(5, topoff, "Fixed top-off should return exact quantity");
	}

	@Test
	@DisplayName("Apply percentage top-off")
	void testApplyTopOffsPercentage() {
		// Given: 110 meals, 5% top-off
		int mealQuantity = 110;
		int paxCount = 120;
		int topoffQuantity = 5; // 5%
		int topoffType = 1; // Percentage

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType);

		// Then: Should calculate ceil(110 * 5 / 100) = 6
		assertEquals(6, topoff, "Should calculate 5% of meal quantity");
	}

	@Test
	@DisplayName("Apply round to multiple top-off")
	void testApplyTopOffsRoundToMultiple() {
		// Given: 113 meals, round to multiple of 10
		int mealQuantity = 113;
		int paxCount = 120;
		int topoffQuantity = 10; // Round to 10
		int topoffType = 2; // Round to multiple

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType);

		// Then: Should round 113 up to 120, topoff = 7
		assertEquals(7, topoff, "Should round up to next multiple of 10");
	}

	@Test
	@DisplayName("Round to multiple - already aligned")
	void testRoundToMultipleAlreadyAligned() {
		// Given: 120 meals, already multiple of 10
		int mealQuantity = 120;
		int paxCount = 120;
		int topoffQuantity = 10;
		int topoffType = 2;

		// When
		int topoff = service.applyTopOffs(mealQuantity, paxCount, topoffQuantity, topoffType);

		// Then: No top-off needed
		assertEquals(0, topoff, "No top-off needed when already aligned");
	}

	@Test
	@DisplayName("Calculate meals with zero PAX")
	void testCalculateWithZeroPax() {
		// Given: 0 PAX
		List<CenOutPax> paxData = createPaxData("Y", 0);
		context.setPaxData(paxData);

		CenMeals mealDef = createMealDefinition("Y", "MEAL1", 1.0);

		// When
		int quantity = service.calculateBaseQuantity(context, mealDef, "Y");

		// Then: Should return 0
		assertEquals(0, quantity, "Should return 0 when no PAX");
	}

	@Test
	@DisplayName("Calculate full meal quantities with all components")
	void testCalculateMealQuantitiesFull() {
		// Given: Complete meal definition with reserves and top-offs
		List<CenOutPax> paxData = createPaxData("Y", 150);
		context.setPaxData(paxData);

		List<CenMeals> mealDefs = new ArrayList<>();
		CenMeals meal = createMealDefinition("Y", "MEAL1", 1.0);

		// Set reserves: 10% of PAX
		meal.setNreserveQuantity(BigDecimal.valueOf(10));
		meal.setNreserveType(1); // % of PAX

		// Set top-off: round to 10
		meal.setNtopoffQuantity(BigDecimal.valueOf(10));
		meal.setNtopoffType(2); // Round to multiple

		mealDefs.add(meal);

		// When
		List<CenOutMeals> result = service.calculateMealQuantities(context, mealDefs);

		// Then:
		// Base: 150
		// Reserve: ceil(150 * 10%) = 15
		// Subtotal: 165
		// Top-off to 170 (next multiple of 10): +5
		// Total: 170
		assertEquals(1, result.size(), "Should have 1 meal record");
		assertEquals(170, result.get(0).getNquantity().intValue(),
				"Should calculate base + reserve + topoff correctly");
	}

	@Test
	@DisplayName("Handle multiple service classes")
	void testMultipleClasses() {
		// Given: PAX in multiple classes
		List<CenOutPax> paxData = new ArrayList<>();
		paxData.add(createPax("F", 12));
		paxData.add(createPax("C", 30));
		paxData.add(createPax("Y", 150));
		context.setPaxData(paxData);

		List<CenMeals> mealDefs = new ArrayList<>();
		mealDefs.add(createMealDefinition("F", "FIRST_MEAL", 1.0));
		mealDefs.add(createMealDefinition("C", "BIZ_MEAL", 1.0));
		mealDefs.add(createMealDefinition("Y", "ECO_MEAL", 0.9));

		// When
		List<CenOutMeals> result = service.calculateMealQuantities(context, mealDefs);

		// Then: Should have 3 meal records
		assertEquals(3, result.size(), "Should have meals for all classes");
	}

	@Test
	@DisplayName("Handle missing PAX data for class")
	void testMissingPaxForClass() {
		// Given: PAX only in economy, but meal def for first class
		List<CenOutPax> paxData = createPaxData("Y", 150);
		context.setPaxData(paxData);

		List<CenMeals> mealDefs = new ArrayList<>();
		mealDefs.add(createMealDefinition("F", "FIRST_MEAL", 1.0));

		// When
		List<CenOutMeals> result = service.calculateMealQuantities(context, mealDefs);

		// Then: Should return meal with 0 quantity or skip
		assertTrue(result.isEmpty() || result.get(0).getNquantity().intValue() == 0,
				"Should handle missing PAX gracefully");
	}

	// Helper methods

	private MealCalculationContext createTestContext() {
		MealCalculationContext ctx = new MealCalculationContext();
		ctx.setResultKey(12345L);
		ctx.setAirlineKey(1L);
		ctx.setRotationKey(100L);
		return ctx;
	}

	private List<CenOutPax> createPaxData(String classCode, int quantity) {
		List<CenOutPax> paxData = new ArrayList<>();
		paxData.add(createPax(classCode, quantity));
		return paxData;
	}

	private CenOutPax createPax(String classCode, int quantity) {
		CenOutPax pax = new CenOutPax();
		pax.setCclass(classCode);
		pax.setNquantity(BigDecimal.valueOf(quantity));
		return pax;
	}

	private CenMeals createMealDefinition(String classCode, String mealCode, double ratio) {
		CenMeals meal = new CenMeals();
		meal.setNhandlingMealKey(1L);
		meal.setCclass(classCode);
		meal.setCmealCode(mealCode);
		meal.setNratio(BigDecimal.valueOf(ratio));
		meal.setNprio(1);

		// Default: no reserves or top-offs
		meal.setNreserveQuantity(BigDecimal.ZERO);
		meal.setNreserveType(0);
		meal.setNtopoffQuantity(BigDecimal.ZERO);
		meal.setNtopoffType(0);

		return meal;
	}
}
