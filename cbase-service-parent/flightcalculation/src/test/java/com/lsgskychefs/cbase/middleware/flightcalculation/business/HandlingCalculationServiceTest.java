/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenHandlingTypesRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for HandlingCalculationService.
 *
 * <p>Tests cover:
 * <ul>
 *   <li>Fixed quantity calculation</li>
 *   <li>Per PAX calculation with ratio</li>
 *   <li>Per meal calculation with ratio</li>
 *   <li>Per PAX with rounding</li>
 *   <li>Min/max quantity constraints</li>
 *   <li>Class-specific vs all-class handling</li>
 *   <li>Extra items calculation</li>
 * </ul>
 *
 * @author Migration Team
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("Handling Calculation Service Tests")
class HandlingCalculationServiceTest {

	@Mock
	private CenHandlingTypesRepository handlingTypesRepository;

	private HandlingCalculationService service;
	private MealCalculationContext context;

	@BeforeEach
	void setUp() {
		service = new HandlingCalculationService(handlingTypesRepository);
		context = createTestContext();
	}

	@Test
	@DisplayName("Calculate fixed quantity handling")
	void testCalculateHandlingFixed() {
		// Given: Fixed quantity handling type
		CenHandlingTypes handlingType = createHandlingType("TRAY", 0, 50, null, 0, 0);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// PAX data
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: Should have fixed quantity of 50
		assertEquals(1, result.size());
		assertEquals(50, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Calculate per PAX with ratio")
	void testCalculateHandlingPerPaxWithRatio() {
		// Given: Per PAX calculation with 0.5 ratio (1 tray per 2 PAX)
		CenHandlingTypes handlingType = createHandlingType(
				"TRAY", 1, 0, BigDecimal.valueOf(0.5), 0, 0);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// 150 PAX
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: ceil(150 * 0.5) = 75 trays
		assertEquals(1, result.size());
		assertEquals(75, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Calculate per meal with ratio")
	void testCalculateHandlingPerMeal() {
		// Given: Per meal calculation with 0.1 ratio
		CenHandlingTypes handlingType = createHandlingType(
				"CART", 2, 0, BigDecimal.valueOf(0.1), 0, 0);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// PAX and meals
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		List<CenOutMeals> meals = List.of(createMeal("Y", "MEAL1", 160));

		// When
		List<CenOutHandling> result = service.calculateHandling(context, meals);

		// Then: ceil(160 * 0.1) = 16 carts
		assertEquals(1, result.size());
		assertEquals(16, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Calculate per PAX with rounding")
	void testCalculateHandlingPerPaxRounded() {
		// Given: Per PAX with rounding to base quantity (1 cart per 30 PAX)
		CenHandlingTypes handlingType = createHandlingType(
				"CART", 3, 30, null, 0, 0);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// 150 PAX
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: ceil(150 / 30) = 5 carts
		assertEquals(1, result.size());
		assertEquals(5, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Apply minimum quantity constraint")
	void testMinimumQuantityConstraint() {
		// Given: Handling with min quantity of 10
		CenHandlingTypes handlingType = createHandlingType(
				"ITEM", 1, 0, BigDecimal.valueOf(0.01), 10, 100);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// 50 PAX * 0.01 = 0.5 → 1, but min is 10
		List<CenOutPax> paxData = List.of(createPax("Y", 50));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: Should enforce minimum of 10
		assertEquals(1, result.size());
		assertEquals(10, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Apply maximum quantity constraint")
	void testMaximumQuantityConstraint() {
		// Given: Handling with max quantity of 50
		CenHandlingTypes handlingType = createHandlingType(
				"ITEM", 1, 0, BigDecimal.valueOf(1.0), 0, 50);
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// 150 PAX * 1.0 = 150, but max is 50
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: Should enforce maximum of 50
		assertEquals(1, result.size());
		assertEquals(50, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Handle multiple service classes")
	void testMultipleClasses() {
		// Given: All-class handling type
		CenHandlingTypes handlingType = createHandlingType(
				"TRAY", 1, 0, BigDecimal.valueOf(1.0), 0, 0);
		handlingType.setCclass(null); // Applies to all classes
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// Multiple classes
		List<CenOutPax> paxData = new ArrayList<>();
		paxData.add(createPax("F", 12));
		paxData.add(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: Should have handling for both classes
		assertEquals(2, result.size());
	}

	@Test
	@DisplayName("Calculate extra items")
	void testCalculateExtraItems() {
		// Given: Extra item handling types
		CenHandlingTypes newspaper = createHandlingType(
				"NEWSPAPER", 1, 0, BigDecimal.valueOf(1.0), 0, 0);
		newspaper.setCclass("F"); // First class only
		List<CenHandlingTypes> extraTypes = List.of(newspaper);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(1)))
				.thenReturn(extraTypes);

		// PAX data
		List<CenOutPax> paxData = List.of(createPax("F", 12));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateExtraItems(context);

		// Then: Should calculate newspapers for first class
		assertEquals(1, result.size());
		assertEquals("NEWSPAPER", result.get(0).getChandlingCode());
		assertEquals(12, result.get(0).getNquantity().intValue());
	}

	@Test
	@DisplayName("Skip handling when no PAX")
	void testSkipWhenNoPax() {
		// Given: Handling type for class with no PAX
		CenHandlingTypes handlingType = createHandlingType(
				"TRAY", 1, 0, BigDecimal.valueOf(1.0), 0, 0);
		handlingType.setCclass("F");
		List<CenHandlingTypes> types = List.of(handlingType);

		when(handlingTypesRepository.findByRotationKeyAndModuleType(anyLong(), eq(0)))
				.thenReturn(types);

		// Only economy PAX
		List<CenOutPax> paxData = List.of(createPax("Y", 150));
		context.setPaxData(paxData);

		// When
		List<CenOutHandling> result = service.calculateHandling(context, new ArrayList<>());

		// Then: Should not create handling for first class
		assertEquals(0, result.size());
	}

	@Test
	@DisplayName("Validate handling records for duplicates")
	void testValidateHandling() {
		// Given: Duplicate handling records
		List<CenOutHandling> records = new ArrayList<>();
		records.add(createHandlingRecord("TRAY", "Y", 50));
		records.add(createHandlingRecord("TRAY", "Y", 60)); // Duplicate

		// When
		List<String> warnings = service.validateHandling(records);

		// Then: Should detect duplicate
		assertEquals(1, warnings.size());
		assertTrue(warnings.get(0).contains("Duplicate"));
	}

	// Helper methods

	private MealCalculationContext createTestContext() {
		MealCalculationContext ctx = new MealCalculationContext();
		ctx.setResultKey(12345L);
		ctx.setRotationKey(100L);
		return ctx;
	}

	private CenHandlingTypes createHandlingType(
			String code, int calcType, int baseQuantity,
			BigDecimal ratio, int minQty, int maxQty) {

		CenHandlingTypes type = new CenHandlingTypes();
		type.setNhandlingTypeKey(1L);
		type.setChandlingCode(code);
		type.setNcalculationType(calcType);
		type.setNquantity(BigDecimal.valueOf(baseQuantity));
		type.setNratio(ratio);
		type.setNminQuantity(minQty);
		type.setNmaxQuantity(maxQty);
		type.setCclass("Y"); // Default to economy
		type.setCdescription(code + " description");
		return type;
	}

	private CenOutPax createPax(String classCode, int quantity) {
		CenOutPax pax = new CenOutPax();
		pax.setCclass(classCode);
		pax.setNquantity(BigDecimal.valueOf(quantity));
		return pax;
	}

	private CenOutMeals createMeal(String classCode, String mealCode, int quantity) {
		CenOutMeals meal = new CenOutMeals();
		meal.setCclass(classCode);
		meal.setCmealCode(mealCode);
		meal.setNquantity(BigDecimal.valueOf(quantity));
		return meal;
	}

	private CenOutHandling createHandlingRecord(String code, String classCode, int quantity) {
		CenOutHandling handling = new CenOutHandling();
		CenOutHandlingId id = new CenOutHandlingId();
		id.setNresultKey(12345L);
		id.setNdetailKey(1L);
		handling.setId(id);
		handling.setChandlingCode(code);
		handling.setCclass(classCode);
		handling.setNquantity(BigDecimal.valueOf(quantity));
		return handling;
	}
}
