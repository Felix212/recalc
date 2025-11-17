/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Repository class for {@link SysQueueFlightCalc} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface SysQueueFlightCalcRepository extends PagingAndSortingRepository<SysQueueFlightCalc, Long> {
	/**
	 * Find all explosion entries with a specific process status
	 * 
	 * @param nprocessStatus the process status to look for
	 * @return List of {@link SysQueueFlightCalc}
	 */
	List<SysQueueFlightCalc> findByNprocessStatus(final int nprocessStatus);

	/**
	 * Find all explosion entries with a specific result key
	 * 
	 * @param nresultKey the result key to look for
	 * @return List of {@link SysQueueFlightCalc}
	 */
	List<SysQueueFlightCalc> findByNresultKey(final long nresultKey);
}
