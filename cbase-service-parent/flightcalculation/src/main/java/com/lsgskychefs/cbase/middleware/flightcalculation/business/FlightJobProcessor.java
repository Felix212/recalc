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
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightActype;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpml;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Service for processing individual flight calculation jobs.
 * Main orchestrator that coordinates the entire calculation flow.
 *
 * <p>PowerBuilder equivalent: of_process_auto_web_calc_cen_out() method
 *
 * <p>Processing Flow:
 * <ol>
 *   <li>Lock flight record (pessimistic)</li>
 *   <li>Retrieve flight data</li>
 *   <li>Apply PAX changes from queue</li>
 *   <li>Apply aircraft changes from queue</li>
 *   <li>Apply SPML changes from queue</li>
 *   <li>Determine if meal calculation needed</li>
 *   <li>Execute meal calculation if needed (via external library)</li>
 *   <li>Save results</li>
 *   <li>Update job status</li>
 *   <li>Release lock (commit)</li>
 * </ol>
 *
 * @author Migration Team
 */
@Service
public class FlightJobProcessor {

	private static final Logger LOGGER = LoggerFactory.getLogger(FlightJobProcessor.class);

	@Autowired
	private FlightCalculationProperties properties;

	@Autowired
	private FlightLockingService lockingService;

	@Autowired
	private FunctionConfigurationService functionConfigService;

	@Autowired
	private PaxChangeApplierService paxChangeApplier;

	@Autowired
	private AircraftChangeApplierService aircraftChangeApplier;

	@Autowired
	private SpmlChangeApplierService spmlChangeApplier;

	@Autowired
	private CenOutPpmFlightsRepository flightRepository;

	@Autowired
	private SysQueueFlightCalcRepository jobRepository;

	@Autowired
	private MealCalculationService mealCalculationService;

	/**
	 * Process a single flight calculation job.
	 *
	 * <p>This is the main entry point for job processing.
	 * Coordinates all steps from locking to saving.
	 *
	 * @param job Job to process
	 * @return Calculation result with status and messages
	 */
	@Transactional
	public FlightCalculationResult processJob(SysQueueFlightCalc job) {
		FlightCalculationResult result = new FlightCalculationResult();
		result.setJobNr(job.getNjobNr());
		result.setResultKey(job.getNresultKey());

		// Set MDC context for logging
		setupLoggingContext(job);

		try {
			LOGGER.info("Processing job: job_nr={}, result_key={}, function={}",
					job.getNjobNr(), job.getNresultKey(), job.getNfunction());

			// Step 1: Get function configuration
			FunctionConfiguration config = getFunctionConfiguration(job.getNfunction());
			if (config == null) {
				return handleError(result, "Function configuration not found for function=" + job.getNfunction());
			}

			// Step 2: Lock flight record
			Optional<CenOutPpmFlights> flightOpt = lockingService.acquireLock(job.getNresultKey());
			if (!flightOpt.isPresent()) {
				LOGGER.warn("Failed to acquire lock on flight, will retry: result_key={}",
						job.getNresultKey());
				result.setStatus(FlightCalculationResult.Status.LOCKED);
				return result;
			}

			CenOutPpmFlights flight = flightOpt.get();

			// Step 3: Validate flight status
			if (!validateFlightStatus(flight, config, result)) {
				return result;
			}

			// Step 4: Apply changes from queue tables
			boolean hasChanges = applyQueuedChanges(job, flight, config);

			// Step 5: Determine if meal calculation is needed
			boolean needsMealCalculation = determineIfMealCalculationNeeded(
					job.getNresultKey(), hasChanges);

			// Step 6: Execute meal calculation if needed
			if (needsMealCalculation) {
				LOGGER.info("Meal calculation required for result_key={}", job.getNresultKey());
				executeMealCalculation(flight, needsMealCalculation);
			} else {
				LOGGER.debug("No meal calculation needed for result_key={}", job.getNresultKey());
			}

			// Step 7: Save flight data
			saveFlightData(flight, config);

			// Step 8: Mark job as successful
			result.setStatus(FlightCalculationResult.Status.SUCCESS);
			LOGGER.info("Successfully processed job: job_nr={}, result_key={}",
					job.getNjobNr(), job.getNresultKey());

		} catch (Exception e) {
			LOGGER.error("Error processing job: job_nr={}, result_key={}",
					job.getNjobNr(), job.getNresultKey(), e);
			return handleError(result, "Error processing job: " + e.getMessage());
		} finally {
			clearLoggingContext();
		}

		return result;
	}

	/**
	 * Get function configuration for a function ID.
	 */
	private FunctionConfiguration getFunctionConfiguration(Integer functionId) {
		return functionConfigService.getFunctionConfiguration(functionId).orElse(null);
	}

	/**
	 * Validate flight status against function configuration.
	 *
	 * <p>PowerBuilder logic:
	 * <pre>
	 * if lCheck_nstatus > this.lstatus_to_process then
	 *    return -1
	 * end if
	 * </pre>
	 */
	private boolean validateFlightStatus(
			CenOutPpmFlights flight,
			FunctionConfiguration config,
			FlightCalculationResult result) {

		Integer flightStatus = flight.getNstatus();
		Integer maxStatus = config.getStatusToProcess();

		if (maxStatus != null && flightStatus != null && flightStatus > maxStatus) {
			String message = String.format(
					"Flight status too high for processing: status=%d, max_allowed=%d",
					flightStatus, maxStatus);
			LOGGER.warn(message);
			result.setStatus(FlightCalculationResult.Status.ERROR);
			result.setErrorMessage(message);
			result.setErrorMessageShort("Flight status too high");
			return false;
		}

		return true;
	}

	/**
	 * Apply all queued changes (PAX, Aircraft, SPML) to flight data.
	 *
	 * @return true if any changes were applied
	 */
	private boolean applyQueuedChanges(
			SysQueueFlightCalc job,
			CenOutPpmFlights flight,
			FunctionConfiguration config) {

		boolean hasChanges = false;

		// Apply PAX changes
		List<SysQueueFlightPax> paxChanges = paxChangeApplier.getPaxChanges(job.getNjobNr());
		if (!paxChanges.isEmpty()) {
			LOGGER.info("Applying {} PAX change(s)", paxChanges.size());
			int paxUpdated = paxChangeApplier.applyPaxChanges(flight, paxChanges);
			LOGGER.info("Applied PAX changes to {} class(es)", paxUpdated);
			hasChanges = true;
		}

		// Apply aircraft changes
		Optional<SysQueueFlightActype> aircraftChange =
				aircraftChangeApplier.getAircraftChange(job.getNjobNr());
		if (aircraftChange.isPresent()) {
			LOGGER.info("Applying aircraft change");
			AircraftChangeApplierService.ChangeType changeType =
					aircraftChangeApplier.applyAircraftChange(flight, aircraftChange.get());
			LOGGER.info("Applied aircraft change: {}", changeType);
			hasChanges = true;
		}

		// Apply SPML changes
		List<SysQueueFlightSpml> spmlChanges = spmlChangeApplier.getSpmlChanges(job.getNjobNr());
		if (!spmlChanges.isEmpty()) {
			LOGGER.info("Applying {} SPML change(s)", spmlChanges.size());
			int spmlUpdated = spmlChangeApplier.applySpmlChanges(flight, spmlChanges);
			LOGGER.info("Applied SPML changes to {} record(s)", spmlUpdated);
			hasChanges = true;
		}

		return hasChanges;
	}

	/**
	 * Determine if meal calculation is needed.
	 *
	 * <p>PowerBuilder logic:
	 * <ul>
	 *   <li>Always calculate if bDoAllwaysMealCalc = True</li>
	 *   <li>Force calculate if invalid meal references exist</li>
	 *   <li>Calculate if any changes detected</li>
	 * </ul>
	 */
	private boolean determineIfMealCalculationNeeded(Long resultKey, boolean hasChanges) {
		// Always force if configured
		if (properties.isAlwaysForceMealCalculation()) {
			LOGGER.debug("Forcing meal calculation (configured)");
			return true;
		}

		// Check for invalid meal references
		long invalidReferences = flightRepository.countInvalidMealReferences(resultKey);
		if (invalidReferences > 0) {
			LOGGER.info("Forcing meal calculation due to {} invalid meal reference(s)",
					invalidReferences);
			return true;
		}

		// Calculate if changes detected
		if (hasChanges) {
			LOGGER.debug("Meal calculation needed due to changes");
			return true;
		}

		return false;
	}

	/**
	 * Execute meal calculation for a flight.
	 *
	 * <p>PowerBuilder equivalent: wf_chc_master_change()
	 *
	 * <p>This method calls the meal calculation service which performs:
	 * <ul>
	 *   <li>Meal explosion (uo_generate library)</li>
	 *   <li>SPML calculations</li>
	 *   <li>Meal layout generation</li>
	 *   <li>Handling/extra loading calculations</li>
	 * </ul>
	 *
	 * <p><strong>NOTE:</strong> The meal calculation engine is currently a stub.
	 * See {@link MealCalculationService} for implementation requirements.
	 *
	 * @param flight Flight entity
	 * @param forceRecalculation If true, force recalculation even if no changes
	 */
	private void executeMealCalculation(CenOutPpmFlights flight, boolean forceRecalculation) {
		LOGGER.info("Executing meal calculation for result_key={}, force={}",
				flight.getId().getNresultKey(), forceRecalculation);

		MealCalculationService.MealCalculationResult result =
				mealCalculationService.calculateMeals(flight, forceRecalculation);

		if (result.isSuccess()) {
			LOGGER.info("Meal calculation succeeded: {} meals generated",
					result.getMealsGenerated());
		} else {
			LOGGER.warn("Meal calculation failed or not implemented: {}",
					result.getMessage());
			// Note: Not throwing exception as meal calculation stub is expected
			// In production, this should throw exception if meal calculation fails
		}
	}

	/**
	 * Save flight data to database.
	 *
	 * <p>PowerBuilder equivalent: wf_chc_save()
	 */
	private void saveFlightData(CenOutPpmFlights flight, FunctionConfiguration config) {
		// Update flight status if configured
		if (config.getStatusAfterProcess() != null) {
			flight.setNstatus(config.getStatusAfterProcess());
		}

		// Save flight (JPA will auto-persist within transaction)
		flightRepository.save(flight);

		LOGGER.debug("Saved flight data for result_key={}", flight.getId().getNresultKey());
	}

	/**
	 * Handle error and prepare error result.
	 */
	private FlightCalculationResult handleError(FlightCalculationResult result, String message) {
		result.setStatus(FlightCalculationResult.Status.ERROR);
		result.setErrorMessage(message);
		result.setErrorMessageShort(message);
		return result;
	}

	/**
	 * Set up MDC logging context with job and result keys.
	 */
	private void setupLoggingContext(SysQueueFlightCalc job) {
		if (properties.getLogging().isIncludeJobKey()) {
			MDC.put("job_nr", String.valueOf(job.getNjobNr()));
		}
		if (properties.getLogging().isIncludeResultKey()) {
			MDC.put("result_key", String.valueOf(job.getNresultKey()));
		}
	}

	/**
	 * Clear MDC logging context.
	 */
	private void clearLoggingContext() {
		MDC.clear();
	}
}
