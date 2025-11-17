/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitProdRanges;

/**
 * Repository class for Production Ranges.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitProdRangesRepository extends PagingAndSortingRepository<LocUnitProdRanges, Long> {

	/**
	 * Find all Production Ranges for a specific unit and a client
	 * 
	 * @param cclient the id of the client
	 * @param cunit the id of the unit
	 * @return list of {@link LocUnitProdRanges}
	 */
	List<LocUnitProdRanges> findByCclientAndCunit(final String cclient, final String cunit);

	/**
	 * Find prod ranges for a specific unit and a client
	 * 
	 * @param cclient the id of the client
	 * @param cunit the id of the unit
	 * @return list of {@link LocUnitProdRanges}
	 */
	List<LocUnitProdRanges> findByCclientAndCunitOrderByNsortAsc(final String cclient, final String cunit);

}
