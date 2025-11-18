/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.config.FlightCalculationProperties;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightCalcRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FlightCalculationResult;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for {@link FlightCalculationScheduler}.
 *
 * @author Migration Team
 */
@ExtendWith(MockitoExtension.class)
class FlightCalculationSchedulerTest {

	@Mock
	private FlightCalculationProperties properties;

	@Mock
	private SysQueueFlightCalcRepository jobRepository;

	@Mock
	private FlightJobProcessor jobProcessor;

	@InjectMocks
	private FlightCalculationScheduler scheduler;

	private FlightCalculationProperties.SchedulerConfig schedulerConfig;

	@BeforeEach
	void setUp() {
		schedulerConfig = new FlightCalculationProperties.SchedulerConfig();
		schedulerConfig.setEnabled(true);
		schedulerConfig.setIntervalSeconds(60);

		when(properties.getScheduler()).thenReturn(schedulerConfig);
		when(properties.getInstanceName()).thenReturn("INSTANCE99");
		when(properties.getProcessFunctions()).thenReturn(List.of(1));
		when(properties.getNumberOfCalculationsPerCycle()).thenReturn(10);
		when(properties.isProcessAllFunctions()).thenReturn(false);
	}

	@Test
	void testPollAndProcessJobs_NoPendingJobs() {
		// Given: No pending jobs
		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(Collections.emptyList());

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: No jobs processed
		verify(jobRepository).findPendingJobs(List.of(1), "INSTANCE99", false);
		verify(jobProcessor, never()).processJob(any());
	}

	@Test
	void testPollAndProcessJobs_SingleJob_Success() {
		// Given: One pending job that succeeds
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult successResult = FlightCalculationResult.success();
		successResult.setJobNr(12345L);
		successResult.setResultKey(96389531L);

		when(jobProcessor.processJob(job)).thenReturn(successResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Job is processed successfully
		verify(jobProcessor).processJob(job);
		verify(jobRepository).save(job);

		// Verify job status updated to SUCCESS (3)
		assertEquals(3, job.getNprocessStatus());
		assertEquals(0, job.getNerror());
		assertNull(job.getCerror());
	}

	@Test
	void testPollAndProcessJobs_SingleJob_Error() {
		// Given: One pending job that fails
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult errorResult = FlightCalculationResult.error("Test error");
		errorResult.setJobNr(12345L);
		errorResult.setResultKey(96389531L);

		when(jobProcessor.processJob(job)).thenReturn(errorResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Job is marked as error
		verify(jobProcessor).processJob(job);
		verify(jobRepository).save(job);

		// Verify job status updated to ERROR (9)
		assertEquals(9, job.getNprocessStatus());
		assertEquals(1, job.getNerror());
		assertEquals("Test error", job.getCerror());
	}

	@Test
	void testPollAndProcessJobs_SingleJob_Locked() {
		// Given: One pending job that is locked
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult lockedResult = FlightCalculationResult.locked();
		lockedResult.setJobNr(12345L);
		lockedResult.setResultKey(96389531L);

		when(jobProcessor.processJob(job)).thenReturn(lockedResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Job is marked for retry
		verify(jobProcessor).processJob(job);
		verify(jobRepository).save(job);

		// Verify job status updated to RETRY (4)
		assertEquals(4, job.getNprocessStatus());
		assertEquals(0, job.getNerror());
		assertEquals("Flight locked by another process", job.getCerror());
	}

	@Test
	void testPollAndProcessJobs_MultipleJobs_RespectsBatchLimit() {
		// Given: 5 pending jobs but batch limit is 3
		when(properties.getNumberOfCalculationsPerCycle()).thenReturn(3);

		List<SysQueueFlightCalc> jobs = new ArrayList<>();
		for (int i = 1; i <= 5; i++) {
			jobs.add(createTestJob((long) i, (long) (1000 + i), 1, 0));
		}

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(jobs);

		FlightCalculationResult successResult = FlightCalculationResult.success();
		when(jobProcessor.processJob(any())).thenReturn(successResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Only 3 jobs processed (batch limit)
		verify(jobProcessor, times(3)).processJob(any());
		verify(jobRepository, times(3)).save(any());
	}

	@Test
	void testPollAndProcessJobs_SkipsIfDisabled() {
		// Given: Scheduler is disabled
		schedulerConfig.setEnabled(false);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: No jobs retrieved or processed
		verify(jobRepository, never()).findPendingJobs(anyList(), anyString(), anyBoolean());
		verify(jobProcessor, never()).processJob(any());
	}

	@Test
	void testPollAndProcessJobs_UpdatesJobStatus_BeforeProcessing() {
		// Given: Job with status 0 (PENDING)
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult successResult = FlightCalculationResult.success();
		when(jobProcessor.processJob(job)).thenReturn(successResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Job status updated to PROCESSING (1) before processing
		ArgumentCaptor<SysQueueFlightCalc> jobCaptor = ArgumentCaptor.forClass(SysQueueFlightCalc.class);
		verify(jobRepository).save(jobCaptor.capture());

		SysQueueFlightCalc savedJob = jobCaptor.getValue();
		assertNotNull(savedJob.getDstartComputing());
	}

	@Test
	void testPollAndProcessJobs_AlreadyProcessing_DoesNotStartAgain() {
		// Given: Job with status 1 (already processing)
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 1);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult successResult = FlightCalculationResult.success();
		when(jobProcessor.processJob(job)).thenReturn(successResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Job is processed without status change
		verify(jobProcessor).processJob(job);
	}

	@Test
	void testPollAndProcessJobs_ErrorMessageTruncation() {
		// Given: Job that fails with very long error message
		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 1, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		// Create error message longer than 255 chars
		String longError = "A".repeat(300);
		FlightCalculationResult errorResult = FlightCalculationResult.error(longError);

		when(jobProcessor.processJob(job)).thenReturn(errorResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Error message is truncated to 255 chars
		verify(jobRepository).save(job);
		assertNotNull(job.getCerror());
		assertTrue(job.getCerror().length() <= 255);
		assertTrue(job.getCerror().endsWith("..."));
	}

	@Test
	void testPollAndProcessJobs_ProcessAllFunctions() {
		// Given: Process all functions enabled
		when(properties.isProcessAllFunctions()).thenReturn(true);

		SysQueueFlightCalc job = createTestJob(12345L, 96389531L, 2, 0);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));

		FlightCalculationResult successResult = FlightCalculationResult.success();
		when(jobProcessor.processJob(job)).thenReturn(successResult);

		// When: Polling cycle runs
		scheduler.pollAndProcessJobs();

		// Then: Jobs retrieved with processAll=true
		verify(jobRepository).findPendingJobs(List.of(1), "INSTANCE99", true);
		verify(jobProcessor).processJob(job);
	}

	@Test
	void testGetStatistics() {
		// Given: Some jobs processed
		List<SysQueueFlightCalc> jobs = List.of(
				createTestJob(1L, 1001L, 1, 0),
				createTestJob(2L, 1002L, 1, 0),
				createTestJob(3L, 1003L, 1, 0)
		);

		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(jobs);

		// First two succeed, third fails
		when(jobProcessor.processJob(jobs.get(0)))
				.thenReturn(FlightCalculationResult.success());
		when(jobProcessor.processJob(jobs.get(1)))
				.thenReturn(FlightCalculationResult.success());
		when(jobProcessor.processJob(jobs.get(2)))
				.thenReturn(FlightCalculationResult.error("Test error"));

		scheduler.pollAndProcessJobs();

		// When: Get statistics
		String stats = scheduler.getStatistics();

		// Then: Statistics reflect processing
		assertNotNull(stats);
		assertTrue(stats.contains("Processed: 3"));
		assertTrue(stats.contains("Succeeded: 2"));
		assertTrue(stats.contains("Failed: 1"));
	}

	@Test
	void testResetStatistics() {
		// Given: Some jobs processed
		SysQueueFlightCalc job = createTestJob(1L, 1001L, 1, 0);
		when(jobRepository.findPendingJobs(anyList(), anyString(), anyBoolean()))
				.thenReturn(List.of(job));
		when(jobProcessor.processJob(job))
				.thenReturn(FlightCalculationResult.success());

		scheduler.pollAndProcessJobs();

		// When: Reset statistics
		scheduler.resetStatistics();

		// Then: Statistics are cleared
		String stats = scheduler.getStatistics();
		assertTrue(stats.contains("Processed: 0"));
		assertTrue(stats.contains("Succeeded: 0"));
		assertTrue(stats.contains("Failed: 0"));
	}

	/**
	 * Helper method to create test job.
	 */
	private SysQueueFlightCalc createTestJob(Long jobNr, Long resultKey, Integer function, Integer status) {
		SysQueueFlightCalc job = new SysQueueFlightCalc();
		job.setNjobNr(jobNr);
		job.setNresultKey(resultKey);
		job.setNfunction(function);
		job.setNprocessStatus(status);
		return job;
	}
}
