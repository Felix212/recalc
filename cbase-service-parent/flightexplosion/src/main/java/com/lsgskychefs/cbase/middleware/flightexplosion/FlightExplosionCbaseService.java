package com.lsgskychefs.cbase.middleware.flightexplosion;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnNotWebApplication;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseService;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.flightexplosion.business.FlightExplosionService;
import com.lsgskychefs.cbase.middleware.flightexplosion.persistence.constant.SysExplosionProcessStatusType;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysExplosion;
import com.lsgskychefs.cbase.middleware.persistence.general.SysExplosionRepository;

/**
 * Implementation of the Flight Explosion as a CBASE Service
 *
 * @author Dirk Bunk - U200035
 */
@Service
@ConditionalOnNotWebApplication
public class FlightExplosionCbaseService extends AbstractCbaseService<SysExplosion> {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(FlightExplosionCbaseService.class);

	@Autowired
	private SysExplosionRepository sysExplosionRepository;

	@Autowired
	private FlightExplosionService flightExplosionService;

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	protected void init() {
		setServiceName("cbase_online_explosion");
	}

	@Override
	protected List<SysExplosion> getOpenJobs() {
		final List<SysExplosion> openExplosions = sysExplosionRepository
				.findByNprocessStatus(SysExplosionProcessStatusType.ASSIGNED.getTypeValue());
		final List<SysExplosion> openJobs = new ArrayList<>();
		final List<String> instanceNames = getInstanceNames();

		for (final SysExplosion openExplosion : openExplosions) {
			if (instanceNames.contains(openExplosion.getCinstance())) {
				openJobs.add(openExplosion);
			}
		}

		return openJobs;
	}

	@Override
	protected Long getJobId(final SysExplosion jobEntity) {
		return jobEntity.getNjobNr();
	}

	@Override
	protected void onJobStart(final SysExplosion jobEntity) {
		// check for duplicate explosions
		final List<SysExplosion> similarExplosions = sysExplosionRepository.findByNresultKey(jobEntity.getNresultKey());
		for (final SysExplosion similarExplosion : similarExplosions) {
			if (similarExplosion.getNjobNr() == jobEntity.getNjobNr()) {
				continue;
			}

			if (similarExplosion.getNprocessStatus() == SysExplosionProcessStatusType.OPEN.getTypeValue()
					|| similarExplosion.getNprocessStatus() == SysExplosionProcessStatusType.ASSIGNED.getTypeValue()) {
				jobEntity.setNprocessStatus(SysExplosionProcessStatusType.DUPLICATED.getTypeValue());
			}

			if (similarExplosion.getNprocessStatus() == SysExplosionProcessStatusType.STARTED.getTypeValue()) {
				jobEntity.setNprocessStatus(SysExplosionProcessStatusType.OPEN.getTypeValue());
			}
		}

		// set explosion status to started
		if (jobEntity.getNprocessStatus() == SysExplosionProcessStatusType.ASSIGNED.getTypeValue()) {
			jobEntity.setNprocessStatus(SysExplosionProcessStatusType.STARTED.getTypeValue());
			jobEntity.setDstartComputing(now());
			jobEntity.setDstopComputing(null);
		}

		// save the explosion entity
		sysExplosionRepository.save(jobEntity);
	}

	@Override
	protected CompletableFuture<Boolean> processJob(final SysExplosion jobEntity) {
		return CompletableFuture.supplyAsync(() -> {
			final long resultKey = jobEntity.getNresultKey();
			try {
				LOGGER.info("Async flight explosion started for result key {}.", resultKey);
				flightExplosionService.explodeFlight(resultKey, false);
				return true;
			} catch (final CbaseMiddlewareBusinessException | NullPointerException e) {
				LOGGER.error("Async flight explosion for result key {} failed!", resultKey, e);
				return false;
			}
		}, taskExecutor);
	}

	@Override
	protected void onJobDone(final SysExplosion jobEntity) {
		updateIsAliveEntry(jobEntity.getCinstance());
	}

	@Override
	protected void onJobSuccess(final SysExplosion jobEntity) {
		jobEntity.setNprocessStatus(SysExplosionProcessStatusType.DONE.getTypeValue());
		jobEntity.setDstopComputing(now());
		sysExplosionRepository.save(jobEntity);
	}

	@Override
	protected void onJobFail(final SysExplosion jobEntity) {
		jobEntity.setNprocessStatus(SysExplosionProcessStatusType.FAILED.getTypeValue());
		jobEntity.setDstopComputing(now());
		sysExplosionRepository.save(jobEntity);
	}
}