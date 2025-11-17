/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlines;

/**
 * Repository class for {@link CenAirlines} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenAirlinesRepository extends PagingAndSortingRepository<CenAirlines, Long> {

	/**
	 * Find airline by cairline name.
	 *
	 * @param cairline the airline name
	 * @return the airline
	 */
	CenAirlines findByCairline(String cairline);

	/**
	 * Find active airlines
	 * 
	 * @return list of active {@link CenAirlines}
	 */
	@Query("SELECT DISTINCT ca.nairlineKey  FROM CenAirlines ca "
			+ "JOIN ca.cenAirlineUnits cau "
			+ "WHERE ca.nuse4web = 1")
	List<Long> findActiveAirlines();

	/**
	 * Find active airlines for a specific unit
	 * 
	 * @param cunit the unit for which to get the airlines
	 * @return list of active {@link CenAirlines} by unit
	 */
	@Query("SELECT DISTINCT ca.nairlineKey  FROM CenAirlines ca "
			+ "JOIN ca.cenAirlineUnits cau "
			+ "WHERE cau.sysUnits.cunit = :cunit "
			+ "AND ca.nuse4web = 1")
	List<Long> findActiveAirlinesByUnit(
			@Param("cunit") final String cunit);

	/**
	 * Get local airlines for units
	 * 
	 * @param cclient, the client
	 * @param cunit, unit
	 * @return List of {@link CenAirlines}
	 */
	@Query("SELECT ca FROM CenAirlines ca "
			+ "JOIN ca.cenAirlineUnits cau "
			+ "WHERE cau.sysUnits.cunit = :cunit "
			+ "AND ca.cclient = :cclient "
			+ "ORDER BY ca.cairline ASC")
	List<CenAirlines> findLocalAirlinesForUnits(
			@Param("cunit") final String cunit, @Param("cclient") final String cclient);

}
