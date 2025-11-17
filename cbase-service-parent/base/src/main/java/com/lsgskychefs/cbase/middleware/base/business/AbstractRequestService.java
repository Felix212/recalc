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
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;

import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestStatus;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPreorder;
import com.lsgskychefs.cbase.middleware.persistence.general.CenOutRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestFlightRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestRepository;

/**
 * Abstraction for a CBASE service based on CenRequest logic Extending from this
 * class will fire up your service based on jobs arriving in CenRequest. tbd.
 *
 * @param <T> target CenRequestXXX
 * @author Alex Schaab - U524036
 */
public abstract class AbstractRequestService extends AbstractCbaseService<CenRequest> {

	protected CenRequestTypes[] types;

	@Autowired
	protected CenRequestRepository cenRequestRepository;

	@Autowired
	protected CenRequestFlightRepository cenRequestFlightRepository;

	@Autowired
	protected CenOutRepository cenOutRepository;

	// @Qualifier("CenRequestThreadPool")
	// @Autowired
	// private ExecutorService executorService;

	@Qualifier("cenRequestInThreadPool")
	@Autowired
	private Executor executorService;

	@Autowired
	private Environment environment;

	@Autowired
	private PlatformTransactionManager transactionManager;

	@Autowired
	public AbstractRequestService() {
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
	public abstract Boolean process(final CenRequest jobEntity);

	@Override
	protected Long getJobId(final CenRequest jobEntity) {
		return jobEntity.getNjobNr();
	}

	@Override
	protected List<CenRequest> getOpenJobs() {
		getLogger().debug("check open jobs for CenRequest type <{}>", CenRequestTypes.getValues(types));
		final Pageable poolSized = PageRequest.of(0, maxPoolSize * 10);
		return cenRequestRepository.findByCenRequestTypesNrequestTypeIsInAndNstatus(CenRequestTypes.getValues(types),
				CenRequestStatus.OPEN.getValue(), poolSized);
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
	protected void startJob(final CenRequest jobEntity) {
		jobEntity.setNstatus(CenRequestStatus.IN_PROGRESS.getValue());
		jobEntity.setDsent(now());
		jobEntity.setCerrorText(null);
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

	protected void finishJob(final CenRequest jobEntity, final CenRequestStatus status) {
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
				jobEntity.setDreceived(now);
			}
			// cenRequestRepository.save(job.get());
			// }
		} catch (final Exception e) {
			getLogger().error("Unexpected error occurred", e);
		}
	}

	@Override
	public CompletableFuture<Boolean> processJob(final CenRequest jobEntity) {
		return CompletableFuture.supplyAsync(() -> {
			// Since the Executor will only wait on Non Daemon Threads! its good to know ...
			getLogger().debug("Thread : {}; Is Daemon : {}", Thread.currentThread(), Thread.currentThread().isDaemon());
			getLogger().info("starting job (CenRequest njobNr: {} flightKey: {})", getJobId(jobEntity),
					jobEntity.getCflightKey());

			final TransactionTemplate transaction = new TransactionTemplate(transactionManager);

			try {
				// Set up additional logging properties for Graylog
				MDC.put("flight", jobEntity.getCflightKey());
				MDC.put("resultkey", String.valueOf(jobEntity.getNresultKey()));

				// First Transaction
				transaction.executeWithoutResult(status -> {
					this.startJob(jobEntity);
					cenRequestRepository.save(jobEntity);
				});

				// Second Transaction
				final Boolean isProcessSuccess = transaction.execute(status -> {
					final Boolean isSuccess = this.process(jobEntity);
					this.finishJob(jobEntity, isSuccess ? CenRequestStatus.DONE : CenRequestStatus.FAILED);
					cenRequestRepository.save(jobEntity);
					return isSuccess;
				});

				// Reset additional logging properties for Graylog
				MDC.clear();

				if (isProcessSuccess) {
					getLogger().info("job succeeded (CenRequest njobNr: {} flightKey: {})", getJobId(jobEntity),
							jobEntity.getCflightKey());
				} else {
					getLogger().warn("job failed! (CenRequest njobNr: {} flightKey: {})", getJobId(jobEntity),
							jobEntity.getCflightKey());
				}

				return isProcessSuccess;
			} catch (final DataIntegrityViolationException err) {
				getLogger().error(
						"job failed (CenRequest njobNr: {} flightKey: {}) due to DataIntegrityViolationException occurred",
						getJobId(jobEntity), jobEntity.getCflightKey(), err);
				Thread.currentThread().interrupt();
				return false;
			}
		}, executorService).thenApply(isDone -> {
			return isDone;
		});
	}

	@Override
	protected void onJobStart(final CenRequest jobEntity) {
	}

	@Override
	protected void onJobSuccess(final CenRequest jobEntity) {
	}

	@Override
	protected void onJobFail(final CenRequest jobEntity) {
	}

	@Override
	protected void onJobDone(final CenRequest jobEntity) {
	}

}
