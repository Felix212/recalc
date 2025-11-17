/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenQueue;

/**
 * Repository class for {@link CenDocGenQueue} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenDocGenQueueRepository extends PagingAndSortingRepository<CenDocGenQueue, Long> {

	/**
	 * Get jobs by resultKey and genStatus.
	 *
	 * @param nresultKey flight id
	 * @param ngenStatus generation status
	 * @return the found jobs
	 */
	List<CenDocGenQueue> findByNresultKeyAndNgenStatus(long nresultKey, Integer ngenStatus);
}
