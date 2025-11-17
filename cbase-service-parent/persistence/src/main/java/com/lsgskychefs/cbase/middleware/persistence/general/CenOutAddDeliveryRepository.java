/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutAddDelivery;

/**
 * Repository class.
 *
 * @author Dirk Bunk - U200035
 */
public interface CenOutAddDeliveryRepository extends PagingAndSortingRepository<CenOutAddDelivery, Long> {
	/**
	 * List of additional deliveries for a flight.
	 * 
	 * @param nresultKey the flight key
	 * @return list of additional deliveries
	 */
	List<CenOutAddDelivery> findByCenOutNresultKey(long nresultKey);
}
