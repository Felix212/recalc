/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitLabelGroups;

/**
 * Repository class for {@link LocUnitLabelGroups}
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitLabelGroupsRepository extends PagingAndSortingRepository<LocUnitLabelGroups, Long> {

	/**
	 * Get a list of {@link LocUnitLabelGroups} for a specific unit
	 * 
	 * @param cunit the unit
	 * @param cclient the client
	 * @return list of {@link LocUnitLabelGroups}
	 */
	List<LocUnitLabelGroups> findByCunitAndCclientOrderByCtext(final String cunit, final String cclient);
	
    /**
	* Find all LocUnitLabelGroups by unit, client and bulk
	* 
	* @param cunit, the unit
	* @param cclient, the client
	* @param nbulk, the bulk
	* @return  {@link LocUnitLabelGroups}
	*/
	List<LocUnitLabelGroups> findByCunitAndCclientAndNbulkOrderByCtext(final String cunit, final String cclient, final Integer nbulk );

}
