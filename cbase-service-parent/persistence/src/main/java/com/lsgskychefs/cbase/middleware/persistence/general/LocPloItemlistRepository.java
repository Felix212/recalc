/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloItemlist;

/**
 * Repository class for {@link LocPloItemlist} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocPloItemlistRepository extends PagingAndSortingRepository<LocPloItemlist, Long> {

	/**
	 * Find all itemlists for a specific unit and client
	 * 
	 * @param cunit, the unit which is needed to find the itemlists for
	 * @param cclient, the client which is needed to find the itemlists for
	 * @return list of {@link LocPloItemlist}
	 */
	List<LocPloItemlist> findBySysUnitsCunitAndCclient(final String cunit, final String cclient);

}
