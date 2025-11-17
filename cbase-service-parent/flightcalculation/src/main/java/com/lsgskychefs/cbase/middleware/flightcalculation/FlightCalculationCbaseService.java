package com.lsgskychefs.cbase.middleware.flightcalculation;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.flightcalculation.business.FlightCalculationService;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistance.constant.SysQueueFlightCalcProcessStatusType;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import com.lsgskychefs.cbase.middleware.persistence.general.SysQueueFlightCalcRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnNotWebApplication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
 * Implementation of the Flight Calculation as a CBASE Service
 *
 * @author Dirk Bunk - U200035
 */
@Service
@ConditionalOnNotWebApplication
public class FlightCalculationCbaseService extends AbstractCbaseService<SysQueueFlightCalc> {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(FlightCalculationCbaseService.class);

	@Autowired
	private SysQueueFlightCalcRepository sysQueueFlightCalcRepository;

	@Autowired
	private FlightCalculationService flightCalculationService;

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	protected void init() {
		setServiceName("cbase_flight_calculation");
	}

	@Override
	protected List<SysQueueFlightCalc> getOpenJobs() {
		final List<SysQueueFlightCalc> openFlightCalculations = sysQueueFlightCalcRepository
				.findByNprocessStatus(SysQueueFlightCalcProcessStatusType.ASSIGNED.getTypeValue());
		final List<SysQueueFlightCalc> openJobs = new ArrayList<>();
		final List<String> instanceNames = getInstanceNames();

//		for (final SysQueueFlightCalc openFlightCalculation : openFlightCalculations) {
//			if (instanceNames.contains(openFlightCalculation.getCinstance())) {
//				openJobs.add(openFlightCalculation);
//			}
//		}

		// Faking a single job
		openJobs.add(sysQueueFlightCalcRepository.findByNresultKey(96389531L).get(0));

		return openJobs;
	}

	@Override
	protected Long getJobId(final SysQueueFlightCalc jobEntity) {
		return jobEntity.getNjobNr();
	}

	@Override
	protected void onJobStart(final SysQueueFlightCalc jobEntity) {
		// check for duplicate flight calculations
		final List<SysQueueFlightCalc> similarFlightCalcs = sysQueueFlightCalcRepository.findByNresultKey(jobEntity.getNresultKey());
		for (final SysQueueFlightCalc similarFlightCalc : similarFlightCalcs) {
			if (similarFlightCalc.getNjobNr() == jobEntity.getNjobNr()) {
				continue;
			}

			if (similarFlightCalc.getNprocessStatus() == SysQueueFlightCalcProcessStatusType.OPEN.getTypeValue()
					|| similarFlightCalc.getNprocessStatus() == SysQueueFlightCalcProcessStatusType.ASSIGNED.getTypeValue()) {
				jobEntity.setNprocessStatus(SysQueueFlightCalcProcessStatusType.DUPLICATED.getTypeValue());
			}

			if (similarFlightCalc.getNprocessStatus() == SysQueueFlightCalcProcessStatusType.STARTED.getTypeValue()) {
				jobEntity.setNprocessStatus(SysQueueFlightCalcProcessStatusType.OPEN.getTypeValue());
			}
		}

		// set flight calculation status to started
		if (jobEntity.getNprocessStatus() == SysQueueFlightCalcProcessStatusType.ASSIGNED.getTypeValue()) {
			jobEntity.setNprocessStatus(SysQueueFlightCalcProcessStatusType.STARTED.getTypeValue());
			jobEntity.setDstartComputing(now());
			jobEntity.setDstopComputing(null);
		}

		// save the flight calculation entity
		sysQueueFlightCalcRepository.save(jobEntity);
	}

	@Override
	protected CompletableFuture<Boolean> processJob(final SysQueueFlightCalc jobEntity) {
		return CompletableFuture.supplyAsync(() -> {
			final long resultKey = jobEntity.getNresultKey();
			try {
				LOGGER.info("Async flight calculation started for result key {}.", resultKey);
				flightCalculationService.calculateFlight(resultKey);
				return true;
			} catch (final CbaseMiddlewareBusinessException | NullPointerException e) {
				LOGGER.error("Async flight calculation for result key {} failed!", resultKey, e);
				return false;
			}
		}, taskExecutor);
	}

	@Override
	protected void onJobDone(final SysQueueFlightCalc jobEntity) {
		updateIsAliveEntry(jobEntity.getCinstance());
	}

	@Override
	protected void onJobSuccess(final SysQueueFlightCalc jobEntity) {
		jobEntity.setNprocessStatus(SysQueueFlightCalcProcessStatusType.DONE.getTypeValue());
		jobEntity.setDstopComputing(now());
		sysQueueFlightCalcRepository.save(jobEntity);
	}

	@Override
	protected void onJobFail(final SysQueueFlightCalc jobEntity) {
		jobEntity.setNprocessStatus(SysQueueFlightCalcProcessStatusType.FAILED.getTypeValue());
		jobEntity.setDstopComputing(now());
		sysQueueFlightCalcRepository.save(jobEntity);
	}
}