/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloBreak;

/**
 * Repository class for {@link LocPloBreak} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocPloBreakRepository extends PagingAndSortingRepository<LocPloBreak, Long> {

	/**
	 * Find all breaks for a specific unit and client
	 * 
	 * @param cunit, the unit which is needed to find the breaks for
	 * @param cclient, the client which is needed to find the breaks for
	 * @return list of {@link LocPloBreak}
	 */
	List<LocPloBreak> findBySysUnitsCunitAndCclient(final String cunit, final String cclient);

	/**
	 * Find all breaks for specific workstation and shift
	 * 
	 * @param nworkstationKey, the id of the workstation
	 * @param nshiftKey, Shift key
	 * @return List of {@link LocPloBreak}
	 */
	List<LocPloBreak> findByLocPloWsShiftBreaksIdNworkstationKeyAndLocPloWsShiftBreaksIdNshiftKey(final long nworkstationKey,
			final long nshiftKey);

}
