/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPlTimeFrameFlight;

/**
 * Repository class for {@link LocPlTimeFrameFlight} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface LocPlTimeFrameFlightRepository extends PagingAndSortingRepository<LocPlTimeFrameFlight, Long> {

	/**
	 * Gets a LocPlTimeFrameFlight entity for a specific packinglist and flight
	 * 
	 * @param nplIndexKey
	 * @param cunit
	 * @param cairline
	 * @param nflightNumber
	 * @param csuffix
	 * @param ctlcFrom
	 * @param ctlcTo
	 * @param nfreq
	 * @return found {@link LocPlTimeFrameFlight} entity or null
	 */
	@Query("SELECT pltff FROM LocPlTimeFrameFlight pltff "
			+ "WHERE :nplIndexKey = pltff.npackinglistIndexKey "
			+ "AND :cunit = pltff.sysUnitsByCunit.cunit "
			+ "AND :cairline = pltff.cairline "
			+ "AND :nflightNumber = pltff.nflightNumber "
			+ "AND :csuffix = pltff.csuffix "
			+ "AND :ctlcFrom = pltff.ctlcFrom "
			+ "AND :ctlcTo = pltff.ctlcTo "
			+ "AND :nfreq = pltff.nfreq ")
	List<LocPlTimeFrameFlight> findByPlIndexKeyAndFlightInfo(
			@Param("nplIndexKey") final Long nplIndexKey,
			@Param("cunit") final String cunit,
			@Param("cairline") final String cairline,
			@Param("nflightNumber") final Integer nflightNumber,
			@Param("csuffix") final String csuffix,
			@Param("ctlcFrom") final String ctlcFrom,
			@Param("ctlcTo") final String ctlcTo,
			@Param("nfreq") final Integer nfreq);
}
