/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTimesFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTimesFlightId;

/**
 * Repository class for {@link LocUnitTimesFlight} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitTimesFlightRepository extends PagingAndSortingRepository<LocUnitTimesFlight, LocUnitTimesFlightId> {

	/**
	 * Get local times flight
	 * 
	 * @param nairlineKey, airline key
	 * @param cunit, unit
	 * @return List of {@link LocUnitTimesFlight}
	 */
	List<LocUnitTimesFlight> findByIdNairlineKeyAndIdCunit(final Long nairlineKey, final String cunit);

}
