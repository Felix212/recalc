/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloShift;

/**
 * Repository class for {@link LocPloShift} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocPloShiftRepository extends PagingAndSortingRepository<LocPloShift, Long> {

	/**
	 * Find all shifts for a specific unit and client
	 * 
	 * @param cunit, the unit which is needed to find the shifts for
	 * @param cclient, the client which is needed to find the shifts for
	 * @return list of {@link LocPloShift}
	 */
	List<LocPloShift> findBySysUnitsCunitAndCclient(final String cunit, final String cclient);

}
