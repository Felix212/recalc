/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPlAreas;

/**
 * Repository class for {@link LocUnitPlAreas} object/table
 *
 * @author Ingo Rietzschel - U125742
 */
public interface LocUnitPlAreasRepository extends PagingAndSortingRepository<LocUnitPlAreas, Long> {

	/**
	 * Load all {@link LocUnitPlAreas} for given ids
	 *
	 * @param cunit unit
	 * @param npackinglistIndexKeys packinglist index keys
	 * @return the {@link LocUnitPlAreas} list
	 */
	List<LocUnitPlAreas> findByCunitAndCenPackinglistIndexNpackinglistIndexKeyIn(String cunit,
			List<Long> npackinglistIndexKeys);

	/**
	 * Find a LocUnitPlAreas for a given id, unit and date
	 * 
	 * @param npackinglistIndexKey
	 * @param date
	 * @param cunit
	 * @return LocUnitPlAreas
	 */
	@Query("SELECT list FROM LocUnitPlAreas list "
			+ "WHERE list.cenPackinglistIndex.npackinglistIndexKey = :npackinglistIndexKey "
			+ "AND list.dvalidFrom <= :date "
			+ "AND list.dvalidTo >= :date "
			+ "AND list.cunit = :cunit ")
	LocUnitPlAreas findByCunitAndNpackinglistIndexKeyAndDate(
			@Param("npackinglistIndexKey") final long npackinglistIndexKey,
			@Param("date") final Date date,
			@Param("cunit") final String cunit);

}
