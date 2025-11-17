/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.dto;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsDetail;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for MealDefinitionWithComponents DTO.
 */
@DisplayName("MealDefinitionWithComponents DTO Tests")
class MealDefinitionWithComponentsTest {

	@Test
	@DisplayName("Create DTO with valid meal and components")
	void testCreateValid() {
		// Given: Valid meal header and components
		CenMeals mealHeader = createMealHeader(100L, "C", "LUNCH");
		List<CenMealsDetail> components = createComponents(3);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: DTO created successfully
		assertNotNull(dto);
		assertEquals(mealHeader, dto.getMealHeader());
		assertEquals(components, dto.getComponents());
		assertEquals(3, dto.getComponentCount());
		assertEquals(100L, dto.getMealKey());
		assertEquals("C", dto.getClassCode());
	}

	@Test
	@DisplayName("Constructor throws exception for null meal header")
	void testNullMealHeader() {
		// Given: Null meal header
		List<CenMealsDetail> components = createComponents(2);

		// When/Then: Should throw exception
		IllegalArgumentException exception = assertThrows(
				IllegalArgumentException.class,
				() -> new MealDefinitionWithComponents(null, components)
		);

		assertEquals("mealHeader cannot be null", exception.getMessage());
	}

	@Test
	@DisplayName("Constructor throws exception for null components list")
	void testNullComponents() {
		// Given: Null components list
		CenMeals mealHeader = createMealHeader(100L, "Y", "DINNER");

		// When/Then: Should throw exception
		IllegalArgumentException exception = assertThrows(
				IllegalArgumentException.class,
				() -> new MealDefinitionWithComponents(mealHeader, null)
		);

		assertEquals("components cannot be null or empty", exception.getMessage());
	}

	@Test
	@DisplayName("Constructor throws exception for empty components list")
	void testEmptyComponents() {
		// Given: Empty components list
		CenMeals mealHeader = createMealHeader(100L, "F", "BREAKFAST");
		List<CenMealsDetail> components = Collections.emptyList();

		// When/Then: Should throw exception
		IllegalArgumentException exception = assertThrows(
				IllegalArgumentException.class,
				() -> new MealDefinitionWithComponents(mealHeader, components)
		);

		assertEquals("components cannot be null or empty", exception.getMessage());
	}

	@Test
	@DisplayName("Get component count")
	void testGetComponentCount() {
		// Given: Meal with 5 components
		CenMeals mealHeader = createMealHeader(200L, "C", "SNACK");
		List<CenMealsDetail> components = createComponents(5);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Component count should be 5
		assertEquals(5, dto.getComponentCount());
	}

	@Test
	@DisplayName("Get meal key")
	void testGetMealKey() {
		// Given: Meal with specific key
		CenMeals mealHeader = createMealHeader(12345L, "Y", "LUNCH");
		List<CenMealsDetail> components = createComponents(2);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Meal key should match
		assertEquals(12345L, dto.getMealKey());
	}

	@Test
	@DisplayName("Get class code")
	void testGetClassCode() {
		// Given: Business class meal
		CenMeals mealHeader = createMealHeader(300L, "C", "DINNER");
		List<CenMealsDetail> components = createComponents(3);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Class code should be "C"
		assertEquals("C", dto.getClassCode());
	}

	@Test
	@DisplayName("ToString contains useful information")
	void testToString() {
		// Given: Meal with components
		CenMeals mealHeader = createMealHeader(999L, "F", "BREAKFAST");
		List<CenMealsDetail> components = createComponents(4);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);
		String toString = dto.toString();

		// Then: ToString contains key info
		assertTrue(toString.contains("999"), "Should contain meal key");
		assertTrue(toString.contains("F"), "Should contain class code");
		assertTrue(toString.contains("4"), "Should contain component count");
	}

	@Test
	@DisplayName("Components list is preserved (not copied)")
	void testComponentsListPreserved() {
		// Given: Mutable components list
		CenMeals mealHeader = createMealHeader(100L, "Y", "LUNCH");
		List<CenMealsDetail> components = createComponents(2);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Same list instance (not a copy)
		assertSame(components, dto.getComponents(),
				"Components should be same instance for performance");
	}

	@Test
	@DisplayName("Create with single component")
	void testSingleComponent() {
		// Given: Meal with single component
		CenMeals mealHeader = createMealHeader(100L, "C", "SNACK");
		List<CenMealsDetail> components = createComponents(1);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Should work with single component
		assertEquals(1, dto.getComponentCount());
		assertEquals(1, dto.getComponents().size());
	}

	@Test
	@DisplayName("Create with many components")
	void testManyComponents() {
		// Given: Meal with many components
		CenMeals mealHeader = createMealHeader(100L, "Y", "DINNER");
		List<CenMealsDetail> components = createComponents(20);

		// When
		MealDefinitionWithComponents dto = new MealDefinitionWithComponents(mealHeader, components);

		// Then: Should handle many components
		assertEquals(20, dto.getComponentCount());
		assertEquals(20, dto.getComponents().size());
	}

	// Helper methods

	private CenMeals createMealHeader(Long mealKey, String classCode, String mealCode) {
		CenMeals meal = new CenMeals();
		meal.setNhandlingMealKey(mealKey);
		meal.setCclass(classCode);
		meal.setCmealCode(mealCode);
		meal.setNreserveQuantity(10);
		meal.setNreserveType(0);
		meal.setNtopoffQuantity(5);
		meal.setNtopoffType(0);
		return meal;
	}

	private List<CenMealsDetail> createComponents(int count) {
		List<CenMealsDetail> components = new ArrayList<>();
		for (int i = 1; i <= count; i++) {
			CenMealsDetail detail = new CenMealsDetail();
			detail.setNhandlingDetailKey((long) i);
			detail.setNcomponentGroup(i);
			detail.setNprio(i);
			detail.setNpercentage(100);
			detail.setNspmlDeduction(i % 2);  // Alternate SPML deduction
			detail.setCproductionText("Component " + i);

			// Set parent meal
			CenMeals parentMeal = new CenMeals();
			parentMeal.setNhandlingMealKey(100L);
			detail.setCenMeals(parentMeal);

			components.add(detail);
		}
		return components;
	}
}
