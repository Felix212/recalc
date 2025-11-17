package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.flightcalculation.config.FlightCalculationProperties;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistance.FlightCalculationRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.SysQueueFlightCalcRepository;
import com.lsgskychefs.cbase.middleware.flightcalculation.pojo.FlightCalculationResult;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;

import java.util.List;
import java.util.Optional;

/**
 * Service class for the flight calculation.
 *
 * <p>This service provides:
 * <ul>
 *   <li>Legacy API for backward compatibility (calculateFlight)</li>
 *   <li>Batch job processing for scheduler</li>
 *   <li>Manual job triggering and management</li>
 * </ul>
 *
 * <p>PowerBuilder equivalent: n_cst_cbase_flight_calculation business object
 *
 * @author Dirk Bunk - U200035
 * @author Migration Team
 */
@Service
public class FlightCalculationService extends AbstractCbaseMiddlewareService {
    /**
     * The logger.
     */
    private static final Logger LOGGER = LoggerFactory.getLogger(FlightCalculationService.class);

    /** Flight Calculation repository (legacy). */
    @Autowired
    private FlightCalculationRepository flightCalculationRepository;

    @Autowired
    private FlightCalculationProperties properties;

    @Autowired
    private SysQueueFlightCalcRepository jobRepository;

    @Autowired
    private FlightJobProcessor jobProcessor;

    @Autowired
    private FunctionConfigurationService functionConfigService;

    /**
     * Calculate flight by result key (legacy API).
     *
     * <p>This method provides backward compatibility with the existing API.
     * It looks up the most recent pending job for the given result key and processes it.
     *
     * @param resultKey Flight result key
     * @throws CbaseMiddlewareBusinessException if calculation fails
     */
    @Transactional
    public void calculateFlight(final Long resultKey)
            throws CbaseMiddlewareBusinessException {

        LOGGER.info("Calculate flight with result key: {}", resultKey);

        // Find pending job for this result key
        Optional<SysQueueFlightCalc> jobOpt = findPendingJobForResultKey(resultKey);

        if (!jobOpt.isPresent()) {
            String message = String.format(
                    "No pending job found for result_key=%d. Job may have been processed or does not exist.",
                    resultKey);
            LOGGER.warn(message);
            throw new CbaseMiddlewareBusinessException(message);
        }

        SysQueueFlightCalc job = jobOpt.get();

        LOGGER.info("Found pending job for result_key={}: job_nr={}, function={}",
                resultKey, job.getNjobNr(), job.getNfunction());

        // Process the job using new processor
        FlightCalculationResult result = jobProcessor.processJob(job);

        // Handle result
        if (result.getStatus() == FlightCalculationResult.Status.ERROR) {
            String message = String.format(
                    "Flight calculation failed for result_key=%d: %s",
                    resultKey, result.getErrorMessage());
            LOGGER.error(message);
            throw new CbaseMiddlewareBusinessException(message);
        } else if (result.getStatus() == FlightCalculationResult.Status.LOCKED) {
            String message = String.format(
                    "Flight is locked by another process: result_key=%d",
                    resultKey);
            LOGGER.warn(message);
            throw new CbaseMiddlewareBusinessException(message);
        }

        LOGGER.info("Successfully calculated flight with result_key={}", resultKey);
    }

    /**
     * Process a specific job by job number.
     *
     * <p>This method allows direct processing of a job without going through
     * the scheduler. Useful for manual triggering or API-based processing.
     *
     * @param jobNr Job number
     * @return Processing result
     * @throws CbaseMiddlewareBusinessException if job not found
     */
    @Transactional
    public FlightCalculationResult processJobByNumber(Long jobNr)
            throws CbaseMiddlewareBusinessException {

        LOGGER.info("Processing job by number: job_nr={}", jobNr);

        Optional<SysQueueFlightCalc> jobOpt = jobRepository.findById(jobNr);

        if (!jobOpt.isPresent()) {
            String message = String.format("Job not found: job_nr=%d", jobNr);
            LOGGER.error(message);
            throw new CbaseMiddlewareBusinessException(message);
        }

        SysQueueFlightCalc job = jobOpt.get();
        return jobProcessor.processJob(job);
    }

    /**
     * Get pending jobs for configured functions and instance.
     *
     * @return List of pending jobs
     */
    public List<SysQueueFlightCalc> getPendingJobs() {
        List<Integer> functions = properties.getProcessFunctions();
        String instanceName = properties.getInstanceName();
        boolean processAll = properties.isProcessAllFunctions();

        LOGGER.debug("Getting pending jobs: instance={}, functions={}, processAll={}",
                instanceName, functions, processAll);

        return jobRepository.findPendingJobs(functions, instanceName, processAll);
    }

    /**
     * Find the most recent pending job for a result key.
     *
     * <p>Looks for jobs with status 0 (PENDING) or 4 (RETRY) ordered by job number descending.
     *
     * @param resultKey Flight result key
     * @return Optional pending job
     */
    private Optional<SysQueueFlightCalc> findPendingJobForResultKey(Long resultKey) {
        List<SysQueueFlightCalc> jobs = jobRepository.findByResultKeyAndStatusPending(
                resultKey, List.of(0, 4));

        if (jobs.isEmpty()) {
            return Optional.empty();
        }

        // Return most recent job (highest job_nr)
        SysQueueFlightCalc mostRecentJob = jobs.get(0);
        for (SysQueueFlightCalc job : jobs) {
            if (job.getNjobNr() > mostRecentJob.getNjobNr()) {
                mostRecentJob = job;
            }
        }

        return Optional.of(mostRecentJob);
    }

    /**
     * Get count of pending jobs by function.
     *
     * @param functionId Function ID (null for all functions)
     * @return Count of pending jobs
     */
    public long getPendingJobCount(Integer functionId) {
        if (functionId == null) {
            return jobRepository.countByProcessStatusIn(List.of(0, 1, 4));
        } else {
            return jobRepository.countByFunctionAndStatusPending(functionId, List.of(0, 1, 4));
        }
    }

    /**
     * Check if scheduler is enabled.
     *
     * @return true if enabled
     */
    public boolean isSchedulerEnabled() {
        return properties.getScheduler().isEnabled();
    }

    /**
     * Get current configuration.
     *
     * @return Configuration properties
     */
    public FlightCalculationProperties getConfiguration() {
        return properties;
    }
}