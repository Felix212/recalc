/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPlReserve;

/**
 * Repository class for {@link LocUnitPlReserve} object/table
 *
 * @author Dirk Bunk - U200035
 */
public interface LocUnitPlReserveRepository extends PagingAndSortingRepository<LocUnitPlReserve, Long> {

	/**
	 * Find a LocUnitPlReserve for a given plAreaKey, time and date
	 * 
	 * @param plAreaKey
	 * @param refTime
	 * @param refDate
	 * @return
	 */
	@Query("SELECT reserve FROM LocUnitPlReserve reserve "
			+ "WHERE reserve.locUnitPlAreas.nplAreaKey = :plAreaKey "
			+ "AND :refTime BETWEEN reserve.ctimeFrom AND reserve.ctimeTo "
			+ "AND :refDate BETWEEN reserve.dvalidFrom AND reserve.dvalidTo")
	LocUnitPlReserve findByPlAreaKeyAndRefTimeAndRefDate(
			@Param("plAreaKey") final Long plAreaKey,
			@Param("refTime") final String refTime,
			@Param("refDate") final Date refDate);

}
