/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdBlob;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdPs;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdPsId;

/**
 * Repository class for {@link CenOutMdPs} object/table
 * 
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdPsRepository extends PagingAndSortingRepository<CenOutMdPs, CenOutMdPsId> {

	/**
	 * Delete {@link CenOutMdBlob} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);
}
