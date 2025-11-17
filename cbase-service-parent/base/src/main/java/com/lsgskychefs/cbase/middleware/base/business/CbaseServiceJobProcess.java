/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.concurrent.Future;

import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;

/**
 * Represents one asynchronously called CBASE Service Job Process
 * 
 * @author Dirk Bunk - U200035
 */
public class CbaseServiceJobProcess<T extends DomainObject> {
	private final Future<Boolean> jobFuture;

	private final T jobEntity;

	/**
	 * Constructor
	 * 
	 * @param jobFuture
	 * @param jobEntity
	 */
	public CbaseServiceJobProcess(final Future<Boolean> jobFuture, final T jobEntity) {
		this.jobFuture = jobFuture;
		this.jobEntity = jobEntity;
	}

	/**
	 * The job future
	 * 
	 * @return
	 */
	public Future<Boolean> getJobFuture() {
		return jobFuture;
	}

	/**
	 * The jobEntity
	 * 
	 * @return
	 */
	public T getJobEntity() {
		return jobEntity;
	}
}
