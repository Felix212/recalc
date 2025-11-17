/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloWoDef;

/**
 * Repository class for {@link LocPloWoDef} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocPloWoDefRepository extends PagingAndSortingRepository<LocPloWoDef, Long> {

	/**
	 * Find all workorders for a specific unit and client
	 * 
	 * @param cunit, the unit which is needed to find the workorders for
	 * @param cclient, the client which is needed to find the workorders for
	 * @return list of {@link LocPloWoDef}
	 */
	List<LocPloWoDef> findBySysUnitsCunitAndCclient(final String cunit, final String cclient);
}
