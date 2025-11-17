/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.env.Environment;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestStatus;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPreorder;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestFlightRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestOutRepository;

/**
 * Abstraction for a CBASE service based on CenRequest logic Extending from this
 * class will fire up your service based on jobs arriving in CenRequest. tbd.
 *
 * @param <T> target CenRequestXXX
 * @author Alex Schaab - U524036
 */
@Transactional
public abstract class AbstractRequestOutService extends AbstractCbaseService<CenRequestOut> {

	protected CenRequestTypes[] types;

	@Autowired
	protected CenRequestOutRepository cenRequestOutRepository;

	@Autowired
	protected CenRequestFlightRepository cenRequestFlightRepository;

	@Autowired
	protected CenOutRepository cenOutRepository;

	// @Qualifier("CenRequestThreadPool")
	// @Autowired
	// private ExecutorService executorService;

	@Qualifier("cenRequestOutThreadPool")
	@Autowired
	private Executor executorService;

	@Autowired
	private Environment environment;

	@Autowired
	public AbstractRequestOutService() {
		if (getClass().isAnnotationPresent(CenRequestType.class)) {
			types = getClass().getAnnotation(CenRequestType.class).types();
			final String commaSeperatedTypes = getClass().getAnnotation(CenRequestType.class).commaSeperatedTypes();

			if (types.length == 0 && !commaSeperatedTypes.matches("\\$\\{(.*?)}")) {
				types = CenRequestTypes.getEnums(commaSeperatedTypes);
			}
		}
	}

	@PostConstruct
	public void postConstruct() {
		if (getClass().isAnnotationPresent(CenRequestType.class)) {
			String commaSeperatedTypes = getClass().getAnnotation(CenRequestType.class).commaSeperatedTypes();

			if (types.length == 0 && commaSeperatedTypes != null && commaSeperatedTypes.matches("\\$\\{(.*?)}")) {
				final String propertyName = StringUtils.substringBetween(commaSeperatedTypes, "{", "}");
				commaSeperatedTypes = environment.getProperty(propertyName);
				types = CenRequestTypes.getEnums(commaSeperatedTypes);
			}

			if (types.length == 0 || types[0] == null) {
				throw new BeanInitializationException("CenRequestType Annotation not properly used!");
			}
		}
	}

	/**
	 * Async Process
	 * 
	 * @param jobEntity
	 * @return
	 */
	protected abstract Boolean process(final CenRequestOut jobEntity);

	@Override
	protected Long getJobId(final CenRequestOut jobEntity) {
		return jobEntity.getNjobNr();
	}

	@Override
	protected List<CenRequestOut> getOpenJobs() {
		getLogger().debug("check open jobs for CenRequest type <{}>", CenRequestTypes.getValues(types));
		final Pageable poolSized = PageRequest.of(0, maxPoolSize * 10);
		return cenRequestOutRepository.getByNstatusAndNrequestTypeIsInOrderByNjobNrAsc(CenRequestStatus.OPEN.getValue(),
				CenRequestTypes.getValues(types), poolSized);
	}

	/**
	 * The status will be set to {@link CenRequestStatus#IN_PROGRESS}. A Trigger on
	 * CenRequest will delete all existing {@link CenRequestFlight} &
	 * {@link CenRequestPreorder}. For this reason this needs to be done in an own
	 * transaction beforehand
	 * 
	 * @param jobEntity
	 */

	// @Transactional(propagation = Propagation.NESTED)
	protected void startJob(final CenRequestOut jobEntity) {
		jobEntity.setNstatus(CenRequestStatus.IN_PROGRESS.getValue());
		jobEntity.setDsent(now());
		// cenRequestRepository.save(jobEntity);

//		try {
//			final Optional<CenRequest> job = cenRequestRepository.findById(jobEntity.getNjobNr());
//			if (job.isPresent()) {
//				final Date now = now();
//				job.get().setNstatus(CenRequestStatus.IN_PROGRESS.getValue());
//				jobEntity.setNstatus(CenRequestStatus.IN_PROGRESS.getValue());
//				job.get().setDsent(now);
//				jobEntity.setDsent(now);
//				cenRequestRepository.save(job.get());
//			}
//		} catch (final Exception e) {
//			getLogger().error("Unexpected error occurred", e);
//		}
	}

	protected void finishJob(final CenRequestOut jobEntity, final CenRequestStatus status) {
		try {
			// final Optional<CenRequest> job =
			// cenRequestRepository.findById(jobEntity.getNjobNr());
			// if (job.isPresent()) {
			final Date now = now();
			// job.get().setNstatus(status.getValue());
			jobEntity.setNstatus(status.getValue());
			// job.get().setCerrorText(jobEntity.getCerrorText());
			if (status.equals(CenRequestStatus.DONE)) {
				// job.get().setDreceived(now);
				jobEntity.setDconfirmed(now);
			}
			// cenRequestRepository.save(job.get());
			// }
		} catch (final Exception e) {
			getLogger().error("Unexpected error occurred", e);
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	@Override
	public CompletableFuture<Boolean> processJob(final CenRequestOut jobEntity) {
		return CompletableFuture.supplyAsync(() -> {
			// Since the Executor will only wait on Non Daemon Threads! its good to know ...
			getLogger().debug("Thread : {}; Is Daemon : {}", Thread.currentThread(), Thread.currentThread().isDaemon());

			try {
				// Set up additional logging properties for Graylog
				MDC.put("flight", jobEntity.getCflightKey());
				MDC.put("resultkey", String.valueOf(jobEntity.getNresultKey()));

				this.startJob(jobEntity);
				cenRequestOutRepository.save(jobEntity);
				final Boolean isSuccess = this.process(jobEntity);
				this.finishJob(jobEntity, isSuccess ? CenRequestStatus.DONE : CenRequestStatus.FAILED);
				cenRequestOutRepository.save(jobEntity);

				// Reset additional logging properties for Graylog
				MDC.clear();

				return isSuccess;
			} catch (final DataIntegrityViolationException err) {
				getLogger().error("DataIntegrityViolationException occurred", err);
				Thread.currentThread().interrupt();
				return false;
			}
		}, executorService).thenApply(isDone -> {
			return isDone;
		});
	}

	@Override
	protected void onJobStart(final CenRequestOut jobEntity) {
	}

	@Override
	protected void onJobSuccess(final CenRequestOut jobEntity) {
	}

	@Override
	protected void onJobFail(final CenRequestOut jobEntity) {
	}

	@Override
	protected void onJobDone(final CenRequestOut jobEntity) {
	}

}
