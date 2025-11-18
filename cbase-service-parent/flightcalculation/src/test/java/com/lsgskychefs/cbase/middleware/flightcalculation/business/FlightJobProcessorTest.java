/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.config.FlightCalculationProperties;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.CenOutPpmFlightsRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightCalcRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FlightCalculationResult;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FunctionConfiguration;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlightsId;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightActype;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpml;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link FlightJobProcessor}.
 *
 * @author Migration Team
 */
@ExtendWith(MockitoExtension.class)
class FlightJobProcessorTest {

	@Mock
	private FlightCalculationProperties properties;

	@Mock
	private FlightLockingService lockingService;

	@Mock
	private FunctionConfigurationService functionConfigService;

	@Mock
	private PaxChangeApplierService paxChangeApplier;

	@Mock
	private AircraftChangeApplierService aircraftChangeApplier;

	@Mock
	private SpmlChangeApplierService spmlChangeApplier;

	@Mock
	private CenOutPpmFlightsRepository flightRepository;

	@Mock
	private SysQueueFlightCalcRepository jobRepository;

	@InjectMocks
	private FlightJobProcessor jobProcessor;

	private SysQueueFlightCalc testJob;
	private CenOutPpmFlights testFlight;
	private FunctionConfiguration testConfig;

	@BeforeEach
	void setUp() {
		// Setup test job
		testJob = new SysQueueFlightCalc();
		testJob.setNjobNr(12345L);
		testJob.setNresultKey(96389531L);
		testJob.setNfunction(1);
		testJob.setNprocessStatus(0);

		// Setup test flight
		testFlight = new CenOutPpmFlights();
		CenOutPpmFlightsId flightId = new CenOutPpmFlightsId();
		flightId.setNresultKey(96389531L);
		testFlight.setId(flightId);
		testFlight.setNstatus(1);

		// Setup function configuration
		testConfig = new FunctionConfiguration();
		testConfig.setFunctionId(1);
		testConfig.setFunctionName("FLIGHT_CALC");
		testConfig.setStatusToProcess(5);
		testConfig.setStatusAfterProcess(2);

		// Setup logging properties mock
		FlightCalculationProperties.LoggingConfig loggingConfig =
				new FlightCalculationProperties.LoggingConfig();
		loggingConfig.setIncludeJobKey(true);
		loggingConfig.setIncludeResultKey(true);

		when(properties.getLogging()).thenReturn(loggingConfig);
		when(properties.isAlwaysForceMealCalculation()).thenReturn(false);
	}

	@Test
	void testProcessJob_Success_NoChanges() {
		// Given: Job with no changes
		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.empty());
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(0L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds
		assertNotNull(result);
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());
		assertEquals(12345L, result.getJobNr());
		assertEquals(96389531L, result.getResultKey());

		// Verify interactions
		verify(lockingService).acquireLock(96389531L);
		verify(flightRepository).save(testFlight);
		verify(flightRepository).countInvalidMealReferences(96389531L);

		// Verify flight status updated
		assertEquals(2, testFlight.getNstatus());
	}

	@Test
	void testProcessJob_Success_WithPaxChanges() {
		// Given: Job with PAX changes
		List<SysQueueFlightPax> paxChanges = new ArrayList<>();
		SysQueueFlightPax paxChange = new SysQueueFlightPax();
		paxChange.setCclass("Y");
		paxChange.setNpax(150);
		paxChanges.add(paxChange);

		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(paxChanges);
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.empty());
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(0L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds and meal calculation would be triggered
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify PAX changes were retrieved
		verify(paxChangeApplier).getPaxChanges(12345L);
	}

	@Test
	void testProcessJob_Success_WithAircraftChange() {
		// Given: Job with aircraft change
		SysQueueFlightActype aircraftChange = new SysQueueFlightActype();
		aircraftChange.setNaircrafttypeKey(789L);
		aircraftChange.setCregistration("D-ABCD");

		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.of(aircraftChange));
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(0L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify aircraft change was retrieved
		verify(aircraftChangeApplier).getAircraftChange(12345L);
	}

	@Test
	void testProcessJob_ForceMealCalculation_InvalidReferences() {
		// Given: Invalid meal references exist
		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.empty());
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(5L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds and meal calculation would be forced
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify invalid references were checked
		verify(flightRepository).countInvalidMealReferences(96389531L);
	}

	@Test
	void testProcessJob_ForceMealCalculation_AlwaysEnabled() {
		// Given: Always force meal calculation is enabled
		when(properties.isAlwaysForceMealCalculation()).thenReturn(true);
		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.empty());
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(Collections.emptyList());

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds (meal calc would be forced, no reference check needed)
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify invalid references were NOT checked (always force enabled)
		verify(flightRepository, never()).countInvalidMealReferences(anyLong());
	}

	@Test
	void testProcessJob_Error_FunctionConfigNotFound() {
		// Given: Function configuration not found
		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.empty());

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job fails with error
		assertEquals(FlightCalculationResult.Status.ERROR, result.getStatus());
		assertNotNull(result.getErrorMessage());
		assertTrue(result.getErrorMessage().contains("Function configuration not found"));

		// Verify no further processing
		verify(lockingService, never()).acquireLock(anyLong());
	}

	@Test
	void testProcessJob_Locked_CannotAcquireLock() {
		// Given: Cannot acquire lock on flight
		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.empty());

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job returns LOCKED status for retry
		assertEquals(FlightCalculationResult.Status.LOCKED, result.getStatus());

		// Verify no further processing
		verify(paxChangeApplier, never()).getPaxChanges(anyLong());
		verify(flightRepository, never()).save(any());
	}

	@Test
	void testProcessJob_Error_FlightStatusTooHigh() {
		// Given: Flight status exceeds maximum
		testFlight.setNstatus(10);  // Higher than statusToProcess (5)

		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job fails with status error
		assertEquals(FlightCalculationResult.Status.ERROR, result.getStatus());
		assertNotNull(result.getErrorMessage());
		assertTrue(result.getErrorMessage().contains("Flight status too high"));

		// Verify no changes were applied
		verify(paxChangeApplier, never()).getPaxChanges(anyLong());
		verify(flightRepository, never()).save(any());
	}

	@Test
	void testProcessJob_Success_SpmlChanges() {
		// Given: Job with SPML changes
		List<SysQueueFlightSpml> spmlChanges = new ArrayList<>();
		SysQueueFlightSpml spmlChange = new SysQueueFlightSpml();
		spmlChange.setCclass("C");
		spmlChange.setCspmlCode("VGML");
		spmlChange.setNquantity(5);
		spmlChanges.add(spmlChange);

		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(Collections.emptyList());
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.empty());
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(spmlChanges);
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(0L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify SPML changes were retrieved
		verify(spmlChangeApplier).getSpmlChanges(12345L);
	}

	@Test
	void testProcessJob_Success_AllChangesPresent() {
		// Given: Job with PAX, Aircraft, and SPML changes
		List<SysQueueFlightPax> paxChanges = List.of(new SysQueueFlightPax());
		SysQueueFlightActype aircraftChange = new SysQueueFlightActype();
		List<SysQueueFlightSpml> spmlChanges = List.of(new SysQueueFlightSpml());

		when(functionConfigService.getFunctionConfiguration(1))
				.thenReturn(Optional.of(testConfig));
		when(lockingService.acquireLock(96389531L))
				.thenReturn(Optional.of(testFlight));
		when(paxChangeApplier.getPaxChanges(12345L))
				.thenReturn(paxChanges);
		when(aircraftChangeApplier.getAircraftChange(12345L))
				.thenReturn(Optional.of(aircraftChange));
		when(spmlChangeApplier.getSpmlChanges(12345L))
				.thenReturn(spmlChanges);
		when(flightRepository.countInvalidMealReferences(96389531L))
				.thenReturn(0L);

		// When: Process the job
		FlightCalculationResult result = jobProcessor.processJob(testJob);

		// Then: Job succeeds with all changes applied
		assertEquals(FlightCalculationResult.Status.SUCCESS, result.getStatus());

		// Verify all change appliers were called
		verify(paxChangeApplier).getPaxChanges(12345L);
		verify(aircraftChangeApplier).getAircraftChange(12345L);
		verify(spmlChangeApplier).getSpmlChanges(12345L);
		verify(flightRepository).save(testFlight);
	}
}
