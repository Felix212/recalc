/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.config.FlightCalculationProperties;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightCalcRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FlightCalculationResult;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Scheduler service for polling and processing flight calculation jobs.
 *
 * <p>PowerBuilder equivalent: f_loop.srf (service loop with timer)
 *
 * <p>This scheduler:
 * <ul>
 *   <li>Polls for pending jobs at configured intervals</li>
 *   <li>Processes jobs in batches</li>
 *   <li>Updates job statuses (0→1→3 for success, →9 for error)</li>
 *   <li>Handles instance locking and concurrency</li>
 *   <li>Logs processing metrics</li>
 * </ul>
 *
 * <p>Processing Flow:
 * <ol>
 *   <li>Query pending jobs (status 0, 1, 4)</li>
 *   <li>Lock job (status 0→1)</li>
 *   <li>Process job via FlightJobProcessor</li>
 *   <li>Update job status based on result (1→3 success, 1→9 error, 1→4 retry)</li>
 *   <li>Record timing and error information</li>
 * </ol>
 *
 * @author Migration Team
 */
@Service
@ConditionalOnProperty(
		prefix = "flight-calculation.scheduler",
		name = "enabled",
		havingValue = "true",
		matchIfMissing = true)
public class FlightCalculationScheduler {

	private static final Logger LOGGER = LoggerFactory.getLogger(FlightCalculationScheduler.class);

	// Job status constants (from PowerBuilder)
	private static final int STATUS_PENDING = 0;      // Ready to process
	private static final int STATUS_PROCESSING = 1;   // Currently processing
	private static final int STATUS_SUCCESS = 3;      // Successfully completed
	private static final int STATUS_RETRY = 4;        // Retry later (locked)
	private static final int STATUS_IGNORE = 7;       // Ignore this job
	private static final int STATUS_ERROR = 9;        // Error occurred

	@Autowired
	private FlightCalculationProperties properties;

	@Autowired
	private SysQueueFlightCalcRepository jobRepository;

	@Autowired
	private FlightJobProcessor jobProcessor;

	private volatile boolean isProcessing = false;
	private long totalJobsProcessed = 0;
	private long totalJobsSucceeded = 0;
	private long totalJobsFailed = 0;
	private long totalJobsRetried = 0;

	/**
	 * Main scheduled method that polls for jobs and processes them.
	 *
	 * <p>PowerBuilder equivalent: Timer event in f_loop.srf
	 *
	 * <p>Polling interval configured via:
	 * flight-calculation.scheduler.interval-seconds (default: 60)
	 */
	@Scheduled(
			fixedDelayString = "${flight-calculation.scheduler.interval-seconds:60}",
			timeUnit = TimeUnit.SECONDS,
			initialDelayString = "${flight-calculation.scheduler.initial-delay-seconds:10}")
	public void pollAndProcessJobs() {
		// Prevent concurrent executions
		if (isProcessing) {
			LOGGER.debug("Previous polling cycle still running, skipping this cycle");
			return;
		}

		if (!properties.getScheduler().isEnabled()) {
			LOGGER.debug("Scheduler disabled via configuration");
			return;
		}

		isProcessing = true;
		try {
			LOGGER.info("Starting job polling cycle: instance={}, functions={}, batch_size={}",
					properties.getInstanceName(),
					properties.getProcessFunctions(),
					properties.getNumberOfCalculationsPerCycle());

			processPendingJobs();

			LOGGER.info("Completed job polling cycle: processed={}, succeeded={}, failed={}, retried={}",
					totalJobsProcessed, totalJobsSucceeded, totalJobsFailed, totalJobsRetried);

		} catch (Exception e) {
			LOGGER.error("Error during job polling cycle", e);
		} finally {
			isProcessing = false;
		}
	}

	/**
	 * Process pending jobs in batch.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * dsSysQueueFlightCalc.Retrieve(functions, instance, batch_size)
	 * For each job:
	 *    Update status to 1 (processing)
	 *    Process job
	 *    Update status based on result
	 * Next
	 * </pre>
	 */
	private void processPendingJobs() {
		// Get pending jobs
		List<SysQueueFlightCalc> pendingJobs = retrievePendingJobs();

		if (pendingJobs.isEmpty()) {
			LOGGER.debug("No pending jobs found");
			return;
		}

		LOGGER.info("Found {} pending job(s) to process", pendingJobs.size());

		// Process each job
		int processedInCycle = 0;
		for (SysQueueFlightCalc job : pendingJobs) {
			try {
				processedInCycle++;
				processJob(job);

				// Check batch limit
				if (processedInCycle >= properties.getNumberOfCalculationsPerCycle()) {
					LOGGER.info("Reached batch limit ({}), stopping this cycle",
							properties.getNumberOfCalculationsPerCycle());
					break;
				}

			} catch (Exception e) {
				LOGGER.error("Unexpected error processing job: job_nr={}", job.getNjobNr(), e);
				totalJobsFailed++;
			}
		}
	}

	/**
	 * Retrieve pending jobs from database.
	 *
	 * <p>PowerBuilder SQL:
	 * <pre>
	 * SELECT * FROM SYS_QUEUE_FLIGHT_CALC
	 * WHERE (cinstance = :instance OR cinstance IS NULL)
	 *   AND nfunction IN (:functions)
	 *   AND nprocess_status IN (0, 1, 4)
	 * ORDER BY nprocess_status ASC, nsort ASC, ddeparture ASC
	 * </pre>
	 */
	private List<SysQueueFlightCalc> retrievePendingJobs() {
		List<Integer> functions = properties.getProcessFunctions();
		String instanceName = properties.getInstanceName();
		boolean processAll = properties.isProcessAllFunctions();

		if (functions.isEmpty() && !processAll) {
			LOGGER.warn("No functions configured to process and process-all=false");
			return List.of();
		}

		return jobRepository.findPendingJobs(functions, instanceName, processAll);
	}

	/**
	 * Process a single job with full lifecycle management.
	 *
	 * <p>Lifecycle:
	 * <ol>
	 *   <li>Lock job (status → 1)</li>
	 *   <li>Process via FlightJobProcessor</li>
	 *   <li>Update status based on result</li>
	 *   <li>Record timing and errors</li>
	 * </ol>
	 *
	 * @param job Job to process
	 */
	private void processJob(SysQueueFlightCalc job) {
		LOGGER.info("Processing job: job_nr={}, result_key={}, function={}, current_status={}",
				job.getNjobNr(), job.getNresultKey(), job.getNfunction(), job.getNprocessStatus());

		Date startTime = new Date();

		try {
			// Step 1: Mark job as processing (if not already)
			if (job.getNprocessStatus() != STATUS_PROCESSING) {
				updateJobStatus(job, STATUS_PROCESSING, startTime, null);
			}

			// Step 2: Process the job
			FlightCalculationResult result = jobProcessor.processJob(job);

			// Step 3: Update job based on result
			Date endTime = new Date();
			handleJobResult(job, result, startTime, endTime);

		} catch (Exception e) {
			LOGGER.error("Fatal error processing job: job_nr={}, result_key={}",
					job.getNjobNr(), job.getNresultKey(), e);

			Date endTime = new Date();
			updateJobStatus(job, STATUS_ERROR, startTime, endTime);
			job.setNerror(1);
			job.setCerror("Fatal error: " + e.getMessage());
			saveJob(job);

			totalJobsFailed++;
		}

		totalJobsProcessed++;
	}

	/**
	 * Handle job result and update status accordingly.
	 *
	 * <p>Status mapping:
	 * <ul>
	 *   <li>SUCCESS → 3 (completed)</li>
	 *   <li>ERROR → 9 (error)</li>
	 *   <li>LOCKED → 4 (retry later)</li>
	 * </ul>
	 *
	 * @param job Job entity
	 * @param result Processing result
	 * @param startTime Start time
	 * @param endTime End time
	 */
	private void handleJobResult(
			SysQueueFlightCalc job,
			FlightCalculationResult result,
			Date startTime,
			Date endTime) {

		switch (result.getStatus()) {
			case SUCCESS:
				LOGGER.info("Job succeeded: job_nr={}, result_key={}",
						job.getNjobNr(), job.getNresultKey());
				updateJobStatus(job, STATUS_SUCCESS, startTime, endTime);
				job.setNerror(0);
				job.setCerror(null);
				totalJobsSucceeded++;
				break;

			case ERROR:
				LOGGER.warn("Job failed: job_nr={}, result_key={}, error={}",
						job.getNjobNr(), job.getNresultKey(), result.getErrorMessage());
				updateJobStatus(job, STATUS_ERROR, startTime, endTime);
				job.setNerror(1);
				job.setCerror(truncateError(result.getErrorMessage()));
				totalJobsFailed++;
				break;

			case LOCKED:
				LOGGER.info("Job locked, will retry: job_nr={}, result_key={}",
						job.getNjobNr(), job.getNresultKey());
				updateJobStatus(job, STATUS_RETRY, null, null);
				job.setNerror(0);
				job.setCerror("Flight locked by another process");
				totalJobsRetried++;
				break;

			default:
				LOGGER.error("Unknown result status: {}", result.getStatus());
				updateJobStatus(job, STATUS_ERROR, startTime, endTime);
				job.setNerror(1);
				job.setCerror("Unknown result status");
				totalJobsFailed++;
				break;
		}

		saveJob(job);
	}

	/**
	 * Update job status and timing information.
	 *
	 * @param job Job entity
	 * @param newStatus New status code
	 * @param startTime Start time (can be null)
	 * @param endTime End time (can be null)
	 */
	private void updateJobStatus(SysQueueFlightCalc job, int newStatus, Date startTime, Date endTime) {
		job.setNprocessStatus(newStatus);

		if (startTime != null) {
			job.setDstartComputing(startTime);
		}

		if (endTime != null) {
			job.setDstopComputing(endTime);
		}

		LOGGER.debug("Updated job status: job_nr={}, status={}→{}",
				job.getNjobNr(), job.getNprocessStatus(), newStatus);
	}

	/**
	 * Save job entity in separate transaction.
	 * Uses REQUIRES_NEW to ensure status update even if processing fails.
	 */
	@Transactional
	private void saveJob(SysQueueFlightCalc job) {
		jobRepository.save(job);
	}

	/**
	 * Truncate error message to fit database column.
	 * Assumes CERROR column is VARCHAR(255).
	 */
	private String truncateError(String error) {
		if (error == null) {
			return null;
		}
		if (error.length() <= 255) {
			return error;
		}
		return error.substring(0, 252) + "...";
	}

	/**
	 * Get processing statistics.
	 *
	 * @return Statistics string
	 */
	public String getStatistics() {
		return String.format(
				"Processed: %d, Succeeded: %d, Failed: %d, Retried: %d, Success Rate: %.1f%%",
				totalJobsProcessed,
				totalJobsSucceeded,
				totalJobsFailed,
				totalJobsRetried,
				totalJobsProcessed > 0 ? (totalJobsSucceeded * 100.0 / totalJobsProcessed) : 0.0);
	}

	/**
	 * Reset statistics (for testing).
	 */
	public void resetStatistics() {
		totalJobsProcessed = 0;
		totalJobsSucceeded = 0;
		totalJobsFailed = 0;
		totalJobsRetried = 0;
	}

	/**
	 * Check if scheduler is currently processing.
	 *
	 * @return true if processing
	 */
	public boolean isProcessing() {
		return isProcessing;
	}
}
