/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitBeacon;

/**
 * Repository class for {@link LocUnitBeacon}
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitBeaconRepository extends PagingAndSortingRepository<LocUnitBeacon, Long> {

	/**
	 * Get a list of {@link LocUnitBeacon} for specific unit
	 * 
	 * @param cunit the unit
	 * @return list of {@link LocUnitBeacon}
	 */
	List<LocUnitBeacon> findBySysUnitsCunit(final String cunit);
}
