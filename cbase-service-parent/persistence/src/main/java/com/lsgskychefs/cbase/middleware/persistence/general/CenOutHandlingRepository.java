/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandling;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandlingId;

/**
 * Repository class for Flight Handlings.
 *
 * @author Alex Schaab - U524036
 */
public interface CenOutHandlingRepository extends PagingAndSortingRepository<CenOutHandling, CenOutHandlingId> {

	/**
	 * Find all handlings for a certain flight
	 * 
	 * @param nresultKey the primary key for a flight
	 * @return list of {@link CenOutHandling}
	 */
	List<CenOutHandling> findByIdNresultKeyOrderByIdNhandlingId(final Long nresultKey);

	/**
	 * Find a specific handling for a certain flight
	 * 
	 * @param nresultKey the primary key for a flight
	 * @param cloadinglist the loadinglist to look for
	 * @return entity of {@link CenOutHandling}
	 */
	CenOutHandling findByIdNresultKeyAndCloadinglist(final Long nresultKey, final String cloadinglist);
}
