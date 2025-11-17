/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitThermometer;

/**
 * Repository class for {@link LocUnitThermometer}
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitThermometerRepository extends PagingAndSortingRepository<LocUnitThermometer, Long> {

	/**
	 * Get a list of {@link LocUnitThermometer} for specific unit
	 * 
	 * @param cunit the unit
	 * @return list of {@link LocUnitThermometer}
	 */
	List<LocUnitThermometer> findBySysUnitsCunit(final String cunit);
}
