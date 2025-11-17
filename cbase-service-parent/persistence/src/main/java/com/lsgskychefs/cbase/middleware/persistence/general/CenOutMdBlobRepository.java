/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdBlob;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdBlobId;

/**
 * Repository class for {@link CenOutMdBlob} object/table
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdBlobRepository extends PagingAndSortingRepository<CenOutMdBlob, CenOutMdBlobId> {

	/**
	 * Delete {@link CenOutMdBlob} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);

	/**
	 * Delete {@link CenOutMdBlob} by given flight.
	 *
	 * @param nresultKey flight key
	 * @param ntransaction transaction
	 */
	void deleteByIdNresultKeyAndIdNtransaction(long nresultKey, long ntransaction);
}
