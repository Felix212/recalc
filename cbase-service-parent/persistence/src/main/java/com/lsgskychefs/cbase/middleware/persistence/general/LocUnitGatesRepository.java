/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitGates;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface LocUnitGatesRepository extends PagingAndSortingRepository<LocUnitGates, Long> {

	/**
	 * Ermittelt alle Gates eines Betriebes
	 * 
	 * @param cunit
	 * @return List<LocUnitGates>
	 */
	List<LocUnitGates> findByCunitOrderByCgate(String cunit);

	/**
	 * Ermitteln eines Gates eines Betriebes
	 * 
	 * @param cunit
	 * @param cgate
	 * @return LocUnitGates
	 */
	LocUnitGates findByCunitAndCgate(String cunit, String cgate);

}
