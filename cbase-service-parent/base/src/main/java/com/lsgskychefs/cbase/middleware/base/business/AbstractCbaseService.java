/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.TimeZone;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.concurrent.Future;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.ContextStoppedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Scheduled;

import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysServicesAlive;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysServicesAliveId;
import com.lsgskychefs.cbase.middleware.persistence.general.SysServicesAliveRepository;

/**
 * Abstraction for a CBASE service that is processing all "open" jobs in a loop
 *
 * @param <T> type of the job entity
 * @author Dirk Bunk - U200035
 */

public abstract class AbstractCbaseService<T extends DomainObject> {
	private String serviceName = "";

	@Value("${cbase.service.async.thread.max.pool.size:100}")
	protected int maxPoolSize;

	private final List<CbaseServiceJobProcess<T>> processPipelines = new ArrayList<>();

	private final List<T> openJobs = new ArrayList<>();

	protected boolean isShuttingDown = false;

	@Autowired
	protected Executor taskExecutor;

	@Autowired
	private SysServicesAliveRepository sysServicesAliveRepository;

	/**
	 * Gets the current time
	 *
	 * @return The current time as <code>Date</code>
	 */
	protected Date now() {
		return Calendar.getInstance(TimeZone.getDefault()).getTime();
	}

	/**
	 * Gets all the instance names to consider when updating the list of open jobs
	 *
	 * @return <code>List</code> of all relevant instance names
	 */
	protected List<String> getInstanceNames() {
		final List<String> instanceNames = new ArrayList<>();
		final List<SysServicesAlive> servicesAliveList = sysServicesAliveRepository
				.findByIdCserviceAndNmaster(serviceName, 2);

		for (final SysServicesAlive sysServicesAliveEntry : servicesAliveList) {
			instanceNames.add(sysServicesAliveEntry.getId().getCinstance());
		}

		return instanceNames;
	}

	/**
	 * Updates the alive entry timestamp for a specific instance
	 *
	 * @param instanceName the instance name to update the alive entry for
	 */
	protected void updateIsAliveEntry(final String instanceName) {
		final Optional<SysServicesAlive> servicesAliveEntry = sysServicesAliveRepository
				.findById(new SysServicesAliveId(serviceName, instanceName));

		if (servicesAliveEntry.isPresent()) {
			servicesAliveEntry.get().setDlifesign(now());
			sysServicesAliveRepository.save(servicesAliveEntry.get());
		}
	}

	/**
	 * Get serviceName
	 *
	 * @return the serviceName
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * Sets the name of the service. This is important in order to get/set the right
	 * data in the SysServicesAlive table
	 *
	 * @param serviceName the serviceName to set
	 */
	public void setServiceName(final String serviceName) {
		this.serviceName = serviceName;
	}

	/**
	 * Initializes the service. Call <code>initConfig</code> to set up a service
	 * specific settings.
	 */
	@PostConstruct
	protected abstract void init();

	/**
	 * Retrieves all open job entities and returns them in a <code>List</code>.
	 *
	 * @return A <code>List</code> of all open job entities.
	 */
	protected abstract List<T> getOpenJobs();

	/**
	 * Returns the id for the given job entity.
	 *
	 * @param jobEntity The job entity to get the id from.
	 * @return The job id.
	 */
	protected abstract Long getJobId(final T jobEntity);

	/**
	 * Starts the processing of the job and returns a <code>Future</code>.
	 *
	 * @param jobEntity The job entity to start the processing for.
	 * @return A <code>Future</code> of the processing job.
	 */
	protected abstract Future<Boolean> processJob(final T jobEntity);

	/**
	 * Callback that is called when a job is about to start.
	 *
	 * @param jobEntity The job entity for which the processing is about to start.
	 */
	protected abstract void onJobStart(final T jobEntity);

	/**
	 * Callback that is called when a job process is done (successful or not).
	 *
	 * @param jobEntity The job entity for which the processing is done.
	 */
	protected abstract void onJobDone(final T jobEntity);

	/**
	 * Callback that is called when a job process has succeeded.
	 *
	 * @param jobEntity The job entity for which the processing succeeded.
	 */
	protected abstract void onJobSuccess(final T jobEntity);

	/**
	 * Callback that is called when a job process has failed.
	 *
	 * @param jobEntity The job entity for which the processing failed
	 */
	protected abstract void onJobFail(final T jobEntity);

	/**
	 * Gets the logger of the concrete service
	 *
	 * @return The logger
	 */
	protected abstract Logger getLogger();

	@EventListener(ApplicationReadyEvent.class)
	public void onStartup() {
		getLogger().info("Service starting up...");
	}

	@EventListener(ContextStoppedEvent.class)
	@PreDestroy
	public void onShutdown() {
		getLogger().info("Service shutting down...");
		isShuttingDown = true;
	}

	/**
	 * Regularly updates the list of open jobs.
	 */
	@Scheduled(initialDelay = 1000, fixedDelayString = "${cbase.service.scheduler.jobListUpdateDelayMilliseconds:10000}")
	private synchronized void updateJobList() {
		if (!isShuttingDown) {
			getLogger().info("Updating job list");

			// Get all "open" jobs
			openJobs.clear();
			openJobs.addAll(getOpenJobs());
			openJobs.removeAll(getProcessingJobs());

			if (!openJobs.isEmpty()) {
				getLogger().info("Found {} new open job(s)", openJobs.size());
			}
		}
	}

	/**
	 * Regularly checks the jobs to process and the status of the running processes
	 * in the process pipelines. If process pipelines are available and open jobs
	 * are left it creates batches of jobs and starts a new process that will occupy
	 * one process pipeline until the process is done.
	 *
	 * @throws InterruptedException, ExecutionException
	 */
	@Scheduled(initialDelay = 5000, fixedDelayString = "${cbase.service.scheduler.jobProcessingDelayMilliseconds:1000}")
	private synchronized void processingJobs() throws InterruptedException, ExecutionException {
		if (!openJobs.isEmpty()) {
			getLogger().debug("Processing {} open jobs", openJobs.size());
			getLogger().debug("{} of {} process pipelines left", maxPoolSize - processPipelines.size(), maxPoolSize);
		}

		while (!openJobs.isEmpty() && processPipelines.size() < maxPoolSize && !isShuttingDown) {
			final T jobEntity = openJobs.remove(0);
			getLogger().debug("process job (CenRequest njobNr: {})", getJobId(jobEntity));
			onJobStart(jobEntity);
			final Future<Boolean> process = processJob(jobEntity);

			if (process != null) {
				processPipelines.add(new CbaseServiceJobProcess<>(process, jobEntity));
			} else {
				getLogger().error("Failed to start job {}!", getJobId(jobEntity));
			}
		}

		// Check the status of running processes
		checkProcesses();
	}

	/**
	 * Checks the status of the running processes in the list of process pipelines.
	 * If a process is done it is removed from the list.
	 *
	 * @throws InterruptedException, ExecutionException
	 */
	private synchronized void checkProcesses() throws InterruptedException, ExecutionException {
		final Iterator<CbaseServiceJobProcess<T>> processPipelinesIterator = processPipelines.iterator();

		while (processPipelinesIterator.hasNext() && !isShuttingDown) {
			final CbaseServiceJobProcess<T> process = processPipelinesIterator.next();

			if (process.getJobFuture().isDone()) {
				final CompletableFuture<Boolean> jobFuture = (CompletableFuture<Boolean>) process.getJobFuture();
				final boolean isJobSuccess = !jobFuture.isCompletedExceptionally() && jobFuture.get();

				if (isJobSuccess) {
					getLogger().debug("Job {} succeeded!", getJobId(process.getJobEntity()));
					onJobSuccess(process.getJobEntity());
				} else {
					getLogger().error("Job {} failed!", getJobId(process.getJobEntity()));
					onJobFail(process.getJobEntity());
				}

				onJobDone(process.getJobEntity());
				processPipelinesIterator.remove();
			}
		}
	}

	/**
	 * Gets a <code>List</code> of all processing jobs
	 *
	 * @return <code>List</code> of all processing jobs
	 */
	private List<T> getProcessingJobs() {
		final List<T> processingJobs = new ArrayList<>();

		for (CbaseServiceJobProcess<T> process : processPipelines) {
			processingJobs.add(process.getJobEntity());
		}

		return processingJobs;
	}
}