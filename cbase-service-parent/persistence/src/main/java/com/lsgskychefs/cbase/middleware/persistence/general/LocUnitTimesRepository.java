/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTimes;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTimesId;

/**
 * Repository class for {@link LocUnitTimes} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitTimesRepository extends PagingAndSortingRepository<LocUnitTimes, LocUnitTimesId> {

	/**
	 * Find local times
	 * 
	 * @param airlineKey, airline key
	 * @param unit, cunit
	 * @return List of {@link LocUnitTimes}
	 */
	@Query("SELECT locUnitTimes FROM LocUnitTimes locUnitTimes "
			+ "JOIN locUnitTimes.cenRouting cr "
			+ "WHERE locUnitTimes.id.nairlineKey = :airline "
			+ "AND locUnitTimes.id.cunit = :unit "
			+ "ORDER BY locUnitTimes.id.nroutingId ASC")
	List<LocUnitTimes> findLocalTimes(
			@Param("airline") final Long airlineKey, @Param("unit") final String unit);

}
