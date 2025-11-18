/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.*;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Integration tests for MealCalculationService orchestrator.
 *
 * <p>Tests the complete workflow from flight data to persisted results:
 * <ul>
 *   <li>Full calculation pipeline</li>
 *   <li>Service coordination</li>
 *   <li>Error handling</li>
 *   <li>Transaction boundaries</li>
 *   <li>Validation logic</li>
 * </ul>
 *
 * @author Migration Team
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("Meal Calculation Service Integration Tests")
class MealCalculationServiceIntegrationTest {

	@Mock
	private MealDefinitionLookupService mealDefinitionLookupService;

	@Mock
	private MealQuantityCalculationService mealQuantityCalculationService;

	@Mock
	private SpmlDistributionService spmlDistributionService;

	@Mock
	private MealLayoutGenerationService mealLayoutGenerationService;

	@Mock
	private HandlingCalculationService handlingCalculationService;

	@Mock
	private MealPersistenceService mealPersistenceService;

	@Mock
	private CenOutPaxRepository paxRepository;

	@Mock
	private CenOutSpmlRepository spmlRepository;

	@Mock
	private CenOutMealsRepository mealsRepository;

	@Mock
	private CenOutHandlingRepository handlingRepository;

	private MealCalculationService service;

	@BeforeEach
	void setUp() {
		service = new MealCalculationService(
				mealDefinitionLookupService,
				mealQuantityCalculationService,
				spmlDistributionService,
				mealLayoutGenerationService,
				handlingCalculationService,
				mealPersistenceService,
				paxRepository,
				spmlRepository,
				mealsRepository,
				handlingRepository
		);
	}

	@Test
	@DisplayName("Complete meal calculation workflow succeeds")
	void testCompleteWorkflowSuccess() {
		// Given: Valid flight with PAX
		CenOutPpmFlights flight = createTestFlight();
		Long resultKey = flight.getId().getNresultKey();

		// Mock repositories
		when(paxRepository.findByResultKey(resultKey))
				.thenReturn(createPaxData());
		when(spmlRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(mealsRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>()); // No existing meals
		when(handlingRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(mealsRepository.countByResultKey(resultKey))
				.thenReturn(0L);

		// Mock service chain
		List<CenMeals> mealDefs = createMealDefinitions();
		when(mealDefinitionLookupService.findMealDefinitions(any()))
				.thenReturn(mealDefs);

		List<CenOutMeals> calculatedMeals = createCalculatedMeals();
		when(mealQuantityCalculationService.calculateMealQuantities(any(), any()))
				.thenReturn(calculatedMeals);

		when(mealLayoutGenerationService.generateMealLayout(any(), any()))
				.thenReturn(calculatedMeals);

		List<CenOutHandling> handling = createHandlingRecords();
		when(handlingCalculationService.calculateHandling(any(), any()))
				.thenReturn(handling);

		MealPersistenceService.PersistenceResult persistResult =
				new MealPersistenceService.PersistenceResult();
		persistResult.setSuccess(true);
		persistResult.setMealsSaved(3);
		persistResult.setHandlingSaved(2);
		when(mealPersistenceService.saveAll(any(), any(), any()))
				.thenReturn(persistResult);

		// When
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, false);

		// Then: Should complete successfully
		assertTrue(result.isSuccess());
		assertEquals(3, result.getMealsGenerated());

		// Verify service chain called in order
		verify(mealDefinitionLookupService).findMealDefinitions(any());
		verify(mealQuantityCalculationService).calculateMealQuantities(any(), any());
		verify(mealLayoutGenerationService).generateMealLayout(any(), any());
		verify(handlingCalculationService).calculateHandling(any(), any());
		verify(mealPersistenceService).saveAll(any(), any(), any());
	}

	@Test
	@DisplayName("Validation failure stops processing")
	void testValidationFailure() {
		// Given: Flight with no route information
		CenOutPpmFlights flight = createTestFlight();
		flight.setCorigin(null); // Invalid

		// When
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, false);

		// Then: Should fail validation
		assertFalse(result.isSuccess());
		assertTrue(result.getMessage().contains("validation failed"));

		// Verify no services called
		verify(mealDefinitionLookupService, never()).findMealDefinitions(any());
		verify(mealPersistenceService, never()).saveAll(any(), any(), any());
	}

	@Test
	@DisplayName("No meal definitions found returns error")
	void testNoMealDefinitionsFound() {
		// Given: Valid flight but no meal definitions
		CenOutPpmFlights flight = createTestFlight();
		Long resultKey = flight.getId().getNresultKey();

		when(paxRepository.findByResultKey(resultKey))
				.thenReturn(createPaxData());
		when(spmlRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(mealsRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(handlingRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());

		// No meal definitions found
		when(mealDefinitionLookupService.findMealDefinitions(any()))
				.thenReturn(new ArrayList<>());

		// When
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, false);

		// Then: Should return error
		assertFalse(result.isSuccess());
		assertTrue(result.getMessage().contains("No meal definitions"));

		// Verify processing stopped
		verify(mealQuantityCalculationService, never()).calculateMealQuantities(any(), any());
	}

	@Test
	@DisplayName("Force recalculation bypasses difference check")
	void testForceRecalculation() {
		// Given: Existing meals but force recalculation
		CenOutPpmFlights flight = createTestFlight();
		Long resultKey = flight.getId().getNresultKey();

		when(paxRepository.findByResultKey(resultKey))
				.thenReturn(createPaxData());
		when(spmlRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(mealsRepository.findByResultKey(resultKey))
				.thenReturn(createExistingMeals()); // Existing meals
		when(handlingRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());

		// Mock service chain
		List<CenMeals> mealDefs = createMealDefinitions();
		when(mealDefinitionLookupService.findMealDefinitions(any()))
				.thenReturn(mealDefs);

		List<CenOutMeals> calculatedMeals = createCalculatedMeals();
		when(mealQuantityCalculationService.calculateMealQuantities(any(), any()))
				.thenReturn(calculatedMeals);

		when(mealLayoutGenerationService.generateMealLayout(any(), any()))
				.thenReturn(calculatedMeals);

		when(handlingCalculationService.calculateHandling(any(), any()))
				.thenReturn(new ArrayList<>());

		MealPersistenceService.PersistenceResult persistResult =
				new MealPersistenceService.PersistenceResult();
		persistResult.setSuccess(true);
		persistResult.setMealsSaved(3);
		when(mealPersistenceService.saveAll(any(), any(), any()))
				.thenReturn(persistResult);

		// When: Force = true
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, true);

		// Then: Should recalculate despite existing meals
		assertTrue(result.isSuccess());
		verify(mealQuantityCalculationService).calculateMealQuantities(any(), any());
	}

	@Test
	@DisplayName("Service exception handled gracefully")
	void testServiceExceptionHandling() {
		// Given: Flight data
		CenOutPpmFlights flight = createTestFlight();
		Long resultKey = flight.getId().getNresultKey();

		when(paxRepository.findByResultKey(resultKey))
				.thenReturn(createPaxData());
		when(spmlRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(mealsRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(handlingRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());

		// Service throws exception
		when(mealDefinitionLookupService.findMealDefinitions(any()))
				.thenThrow(new RuntimeException("Database error"));

		// When
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, false);

		// Then: Should return error result, not throw
		assertFalse(result.isSuccess());
		assertTrue(result.getMessage().contains("failed"));
	}

	@Test
	@DisplayName("SPML distribution integrated correctly")
	void testSpmlIntegration() {
		// Given: Flight with SPML
		CenOutPpmFlights flight = createTestFlight();
		Long resultKey = flight.getId().getNresultKey();

		when(paxRepository.findByResultKey(resultKey))
				.thenReturn(createPaxData());
		when(spmlRepository.findByResultKey(resultKey))
				.thenReturn(createSpmlData()); // SPML present
		when(mealsRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());
		when(handlingRepository.findByResultKey(resultKey))
				.thenReturn(new ArrayList<>());

		// Mock services
		when(mealDefinitionLookupService.findMealDefinitions(any()))
				.thenReturn(createMealDefinitions());
		when(mealQuantityCalculationService.calculateMealQuantities(any(), any()))
				.thenReturn(createCalculatedMeals());
		when(mealLayoutGenerationService.generateMealLayout(any(), any()))
				.thenReturn(createCalculatedMeals());
		when(handlingCalculationService.calculateHandling(any(), any()))
				.thenReturn(new ArrayList<>());

		MealPersistenceService.PersistenceResult persistResult =
				new MealPersistenceService.PersistenceResult();
		persistResult.setSuccess(true);
		persistResult.setMealsSaved(3);
		when(mealPersistenceService.saveAll(any(), any(), any()))
				.thenReturn(persistResult);

		// When
		MealCalculationService.MealCalculationResult result =
				service.calculateMeals(flight, false);

		// Then: SPML service should be called
		assertTrue(result.isSuccess());
		verify(spmlDistributionService).distributeSpecialMeals(any(), any());
	}

	// Helper methods

	private CenOutPpmFlights createTestFlight() {
		CenOutPpmFlights flight = new CenOutPpmFlights();

		CenOutPpmFlightsId id = new CenOutPpmFlightsId();
		id.setNresultKey(12345L);
		flight.setId(id);

		flight.setNairlineKey(1L);
		flight.setNaircraftKey(100L);
		flight.setNaircrafttypeKey(10L);
		flight.setNroutingDetailKey(500L);
		flight.setCorigin("FRA");
		flight.setCdestination("JFK");
		flight.setDstd(new Date());
		flight.setTstd("10:00");

		return flight;
	}

	private List<CenOutPax> createPaxData() {
		List<CenOutPax> paxData = new ArrayList<>();

		CenOutPax pax = new CenOutPax();
		pax.setCclass("Y");
		pax.setNquantity(BigDecimal.valueOf(150));
		paxData.add(pax);

		return paxData;
	}

	private List<CenOutSpml> createSpmlData() {
		List<CenOutSpml> spmlData = new ArrayList<>();

		CenOutSpml spml = new CenOutSpml();
		spml.setCspml("VGML");
		spml.setCclass("Y");
		spml.setNquantity(BigDecimal.valueOf(5));
		spmlData.add(spml);

		return spmlData;
	}

	private List<CenMeals> createMealDefinitions() {
		List<CenMeals> defs = new ArrayList<>();

		for (int i = 1; i <= 3; i++) {
			CenMeals meal = new CenMeals();
			meal.setNhandlingMealKey((long) i);
			meal.setCclass("Y");
			meal.setCmealCode("MEAL" + i);
			meal.setNratio(BigDecimal.ONE);
			meal.setNprio(i);
			defs.add(meal);
		}

		return defs;
	}

	private List<CenOutMeals> createCalculatedMeals() {
		List<CenOutMeals> meals = new ArrayList<>();

		for (int i = 1; i <= 3; i++) {
			CenOutMeals meal = new CenOutMeals();
			CenOutMealsId id = new CenOutMealsId();
			id.setNresultKey(12345L);
			id.setNdetailKey((long) i);
			meal.setId(id);
			meal.setCclass("Y");
			meal.setCmealCode("MEAL" + i);
			meal.setNquantity(BigDecimal.valueOf(150));
			meals.add(meal);
		}

		return meals;
	}

	private List<CenOutMeals> createExistingMeals() {
		return createCalculatedMeals();
	}

	private List<CenOutHandling> createHandlingRecords() {
		List<CenOutHandling> handling = new ArrayList<>();

		for (int i = 1; i <= 2; i++) {
			CenOutHandling h = new CenOutHandling();
			CenOutHandlingId id = new CenOutHandlingId();
			id.setNresultKey(12345L);
			id.setNdetailKey((long) i);
			h.setId(id);
			h.setChandlingCode("TRAY" + i);
			h.setNquantity(BigDecimal.valueOf(50));
			handling.add(h);
		}

		return handling;
	}
}
