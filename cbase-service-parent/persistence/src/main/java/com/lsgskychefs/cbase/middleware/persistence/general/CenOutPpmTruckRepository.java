/*
 * Copyright (c) 2018-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTruck;

/**
 * Repository class for {@link CenOutPpmTruck} object/table.
 *
 * @author Heiko Rothenbach
 */
public interface CenOutPpmTruckRepository extends PagingAndSortingRepository<CenOutPpmTruck, Long> {

	/**
	 * Get all Trucks of a flight
	 * 
	 * @param nresultKey
	 * @return List<CenOutPpmTruck>
	 */
	List<CenOutPpmTruck> getTrucksByNresultKey(long nresultKey);

}
