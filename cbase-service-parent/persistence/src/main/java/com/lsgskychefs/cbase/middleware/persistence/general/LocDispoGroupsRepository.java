/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocDispoGroups;

/**
 * Repository class for {@link LocDispoGroups} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocDispoGroupsRepository extends PagingAndSortingRepository<LocDispoGroups, Long> {

	/**
	 * Find material groups by cunit and cclient
	 * 
	 * @param cclient, the cclient
	 * @param cunit, the chosen unit
	 * @return list of {@link LocDispoGroups}
	 */
	List<LocDispoGroups> findByCclientAndSysUnitsCunitOrderByCtextAsc(final String cclient, final String cunit);

}
