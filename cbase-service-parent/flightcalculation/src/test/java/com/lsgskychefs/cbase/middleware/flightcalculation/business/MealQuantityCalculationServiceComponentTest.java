/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealDefinitionWithComponents;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

/**
 * Unit tests for component-level meal calculation.
 *
 * <p>Tests PowerBuilder component processing (lines 3080-3098, 4700-5070)
 */
@DisplayName("Component-Level Meal Calculation Tests")
class MealQuantityCalculationServiceComponentTest {

	private MealQuantityCalculationService service;

	@Mock
	private SpmlCountCalculator spmlCountCalculator;

	@BeforeEach
	void setUp() {
		MockitoAnnotations.openMocks(this);
		service = new MealQuantityCalculationService(spmlCountCalculator);
	}

	@Test
	@DisplayName("Calculate components with SPML deduction per component")
	void testComponentLevelCalculationWithSpmlDeduction() {
		// Given: Meal with 3 components, 2 with SPML deduction
		CenMeals mealHeader = createMealHeader("C", 10, 0, 0, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 1),  // Appetizer: SPML deduction = 1
				createComponent(2L, 2, 100, 1),  // Main: SPML deduction = 1
				createComponent(3L, 3, 100, 0)   // Dessert: NO SPML deduction
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		// Context: 150 PAX, 10 SPML for class C, aircraft version 180
		MealCalculationContext context = createContext(150, 10, 180, "C");

		// Mock SPML calculator
		Map<String, Integer> spmlByClass = new HashMap<>();
		spmlByClass.put("C", 10);
		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(spmlByClass);

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: Should have 3 component records
		assertEquals(3, result.size(), "Should create 3 component records");

		// Appetizer: (150 PAX - 10 SPML) + 10 reserve = 150
		CenOutMeals appetizer = result.get(0);
		assertEquals(150, appetizer.getNquantity().intValue(), "Appetizer: 140+10=150");
		assertEquals(1, appetizer.getNspmlDeduction(), "Appetizer: SPML deducted");
		assertEquals(10, appetizer.getNspmlQuantity(), "Appetizer: 10 SPMLs tracked");
		assertEquals(1, appetizer.getNcomponentGroup(), "Appetizer: component group 1");

		// Main: (150 PAX - 10 SPML) + 10 reserve = 150
		CenOutMeals main = result.get(1);
		assertEquals(150, main.getNquantity().intValue(), "Main: 140+10=150");
		assertEquals(1, main.getNspmlDeduction(), "Main: SPML deducted");
		assertEquals(10, main.getNspmlQuantity(), "Main: 10 SPMLs tracked");
		assertEquals(2, main.getNcomponentGroup(), "Main: component group 2");

		// Dessert: 150 PAX (NO SPML deduction) + 10 reserve = 160
		CenOutMeals dessert = result.get(2);
		assertEquals(160, dessert.getNquantity().intValue(), "Dessert: 150+10=160 (NO SPML deduction)");
		assertEquals(0, dessert.getNspmlDeduction(), "Dessert: NO SPML deduction");
		assertEquals(0, dessert.getNspmlQuantity(), "Dessert: 0 SPMLs tracked");
		assertEquals(3, dessert.getNcomponentGroup(), "Dessert: component group 3");
	}

	@Test
	@DisplayName("Calculate components without SPML data")
	void testComponentCalculationWithoutSpml() {
		// Given: Meal with 2 components, no SPML
		CenMeals mealHeader = createMealHeader("Y", 5, 0, 0, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 1),
				createComponent(2L, 2, 100, 0)
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		// Context: 100 PAX, 0 SPML
		MealCalculationContext context = createContext(100, 0, 180, "Y");

		Map<String, Integer> spmlByClass = new HashMap<>();
		spmlByClass.put("Y", 0);
		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(spmlByClass);

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: Should have 2 component records, no SPML deduction
		assertEquals(2, result.size(), "Should create 2 component records");

		CenOutMeals comp1 = result.get(0);
		assertEquals(105, comp1.getNquantity().intValue(), "Component 1: 100+5=105");
		assertEquals(0, comp1.getNspmlDeduction(), "No SPML deduction (even with flag=1, count=0)");

		CenOutMeals comp2 = result.get(1);
		assertEquals(105, comp2.getNquantity().intValue(), "Component 2: 100+5=105");
		assertEquals(0, comp2.getNspmlDeduction(), "No SPML deduction");
	}

	@Test
	@DisplayName("Calculate components with percentage less than 100%")
	void testComponentCalculationWithPercentage() {
		// Given: Meal with components at different percentages
		CenMeals mealHeader = createMealHeader("C", 0, 0, 0, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 0),  // 100% - full PAX
				createComponent(2L, 2, 50, 0),   // 50% - half PAX
				createComponent(3L, 3, 25, 0)    // 25% - quarter PAX
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		// Context: 100 PAX
		MealCalculationContext context = createContext(100, 0, 180, "C");

		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(Collections.emptyMap());

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: Should apply percentages
		assertEquals(3, result.size());
		assertEquals(100, result.get(0).getNquantity().intValue(), "100% of 100 = 100");
		assertEquals(50, result.get(1).getNquantity().intValue(), "50% of 100 = 50");
		assertEquals(25, result.get(2).getNquantity().intValue(), "25% of 100 = 25 (ceil)");
	}

	@Test
	@DisplayName("Calculate components with topoff")
	void testComponentCalculationWithTopoff() {
		// Given: Meal with topoff type 0 (always add)
		CenMeals mealHeader = createMealHeader("Y", 10, 0, 20, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 0)
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		// Context: 150 PAX
		MealCalculationContext context = createContext(150, 0, 200, "Y");

		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(Collections.emptyMap());

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: 150 + 10 reserve + 20 topoff = 180
		assertEquals(1, result.size());
		assertEquals(180, result.get(0).getNquantity().intValue(), "150+10+20=180");
	}

	@Test
	@DisplayName("Calculate components with SPML deduction resulting in negative (should be 0)")
	void testComponentCalculationSpmlExceedsPax() {
		// Given: More SPMLs than PAX
		CenMeals mealHeader = createMealHeader("Y", 0, 0, 0, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 1)  // SPML deduction enabled
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		// Context: 50 PAX, 100 SPML (SPML > PAX)
		MealCalculationContext context = createContext(50, 100, 180, "Y");

		Map<String, Integer> spmlByClass = new HashMap<>();
		spmlByClass.put("Y", 100);
		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(spmlByClass);

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: (50 PAX - 100 SPML) = -50, should be clamped to 0
		assertEquals(1, result.size());
		assertEquals(0, result.get(0).getNquantity().intValue(), "Negative should be clamped to 0");
		assertEquals(1, result.get(0).getNspmlDeduction(), "SPML deduction flag set");
		assertEquals(100, result.get(0).getNspmlQuantity(), "SPML quantity tracked");
	}

	@Test
	@DisplayName("Calculate multiple meals with components")
	void testMultipleMealsWithComponents() {
		// Given: 2 meals, each with 2 components
		CenMeals meal1 = createMealHeader("C", 5, 0, 0, 0);
		List<CenMealsDetail> components1 = Arrays.asList(
				createComponent(1L, 1, 100, 0),
				createComponent(2L, 2, 100, 0)
		);

		CenMeals meal2 = createMealHeader("C", 10, 0, 0, 0);
		List<CenMealsDetail> components2 = Arrays.asList(
				createComponent(3L, 1, 100, 0),
				createComponent(4L, 2, 100, 0)
		);

		List<MealDefinitionWithComponents> mealDefs = Arrays.asList(
				new MealDefinitionWithComponents(meal1, components1),
				new MealDefinitionWithComponents(meal2, components2)
		);

		MealCalculationContext context = createContext(100, 0, 180, "C");

		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(Collections.emptyMap());

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, mealDefs);

		// Then: Should have 4 component records total (2 per meal)
		assertEquals(4, result.size(), "Should create 4 component records");

		// First meal: 100 + 5 = 105 each
		assertEquals(105, result.get(0).getNquantity().intValue());
		assertEquals(105, result.get(1).getNquantity().intValue());

		// Second meal: 100 + 10 = 110 each
		assertEquals(110, result.get(2).getNquantity().intValue());
		assertEquals(110, result.get(3).getNquantity().intValue());
	}

	@Test
	@DisplayName("Sequential detail key generation")
	void testSequentialDetailKeyGeneration() {
		// Given: Meal with 3 components
		CenMeals mealHeader = createMealHeader("Y", 0, 0, 0, 0);

		List<CenMealsDetail> components = Arrays.asList(
				createComponent(1L, 1, 100, 0),
				createComponent(2L, 2, 100, 0),
				createComponent(3L, 3, 100, 0)
		);

		MealDefinitionWithComponents mealDef = new MealDefinitionWithComponents(mealHeader, components);

		MealCalculationContext context = createContext(100, 0, 180, "Y");

		when(spmlCountCalculator.calculateSpmlCountsByClass(anyList())).thenReturn(Collections.emptyMap());

		// When
		List<CenOutMeals> result = service.calculateMealQuantitiesWithComponents(
				context, Arrays.asList(mealDef));

		// Then: Detail keys should be sequential
		assertEquals(3, result.size());
		assertTrue(result.get(0).getId().getNdetailKey() > 0, "Detail key 1 should be > 0");
		assertTrue(result.get(1).getId().getNdetailKey() > result.get(0).getId().getNdetailKey(),
				"Detail key 2 should be > detail key 1");
		assertTrue(result.get(2).getId().getNdetailKey() > result.get(1).getId().getNdetailKey(),
				"Detail key 3 should be > detail key 2");
	}

	// Helper methods

	private MealCalculationContext createContext(int paxCount, int spmlCount, int aircraftVersion, String classCode) {
		MealCalculationContext context = new MealCalculationContext();
		context.setResultKey(1000L);
		context.setAircraftVersion(aircraftVersion);

		// Create PAX data
		CenOutPax pax = new CenOutPax();
		pax.setCclass(classCode);
		pax.setNpax(BigDecimal.valueOf(paxCount));
		context.setPaxData(Arrays.asList(pax));

		// Create SPML data
		if (spmlCount > 0) {
			CenOutSpml spml = new CenOutSpml();
			spml.setCclass(classCode);
			spml.setCspml("VGML");
			spml.setNquantity(BigDecimal.valueOf(spmlCount));
			spml.setNtopoff(0);
			context.setSpmlData(Arrays.asList(spml));
		} else {
			context.setSpmlData(Collections.emptyList());
		}

		return context;
	}

	private CenMeals createMealHeader(String classCode, int reserveQty, int reserveType,
	                                   int topoffQty, int topoffType) {
		CenMeals meal = new CenMeals();
		meal.setNhandlingMealKey(100L);
		meal.setCclass(classCode);
		meal.setCmealCode("LUNCH");
		meal.setNreserveQuantity(reserveQty);
		meal.setNreserveType(reserveType);
		meal.setNtopoffQuantity(topoffQty);
		meal.setNtopoffType(topoffType);
		return meal;
	}

	private CenMealsDetail createComponent(Long detailKey, int componentGroup, int percentage, int spmlDeduction) {
		CenMealsDetail detail = new CenMealsDetail();
		detail.setNhandlingDetailKey(detailKey);
		detail.setNcomponentGroup(componentGroup);
		detail.setNpercentage(percentage);
		detail.setNspmlDeduction(spmlDeduction);
		detail.setNprio(componentGroup);  // Use component group as priority
		detail.setCproductionText("Component " + componentGroup);

		// Set the parent meal
		CenMeals parentMeal = new CenMeals();
		parentMeal.setNhandlingMealKey(100L);
		detail.setCenMeals(parentMeal);

		return detail;
	}
}
