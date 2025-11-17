/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRouting;

/**
 * Repository class for {@link CenRouting} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface CenRoutingRepository extends PagingAndSortingRepository<CenRouting, Long> {

	/**
	 * Get all routings for a given client.
	 *
	 * @param cclient the client.
	 * @return the found {@link CenRouting}
	 */
	List<CenRouting> findByCclient(String cclient);
	
	/**
	 * Gets all routings by client, order by nroutingId
	 * 
	 * @param cclient the client
	 * @return List of {@link CenRouting}
	 */
	List<CenRouting> findByCclientOrderByNroutingIdAsc(String cclient);
	
}
