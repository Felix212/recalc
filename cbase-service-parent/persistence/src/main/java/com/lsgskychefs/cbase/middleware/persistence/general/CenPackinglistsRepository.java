/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId;

/**
 * Repository class for {@link CenPackinglists} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenPackinglistsRepository extends PagingAndSortingRepository<CenPackinglists, CenPackinglistsId> {

	/**
	 * Get the packinglists for given workstation id
	 *
	 * @param nworkstationKey id of workstation
	 * @param date filter date for validFrom <-> validTo
	 * @return packinglists
	 */
	@EntityGraph(value = "CenPackinglists.index", type = EntityGraphType.FETCH, attributePaths = { "cenPackinglistIndex" })
	@Query("SELECT list FROM CenPackinglists list "
			+ "JOIN list.cenPackinglistIndex index "
			+ "JOIN index.locUnitPlAreases plAreas  "
			+ "WHERE plAreas.nworkstationKey = :nworkstationKey "
			+ "AND plAreas.dvalidFrom <= :date "
			+ "AND plAreas.dvalidTo >= :date "
			+ "AND list.dvalidFrom <= :date "
			+ "AND list.dvalidTo >= :date ")
	List<CenPackinglists> findPackinglistByWorkstation(
			@Param("nworkstationKey") final long nworkstationKey,
			@Param("date") final Date date);

	/**
	 * Get the CenPackinglists for given index key
	 *
	 * @param npackinglistIndexKey the index key
	 * @return the list of CenPackinglists
	 */
	List<CenPackinglists> findByIdNpackinglistIndexKey(long npackinglistIndexKey);

	/**
	 * Get the CenPackinglists for given index key and date
	 * 
	 * @param npackinglistIndexKey
	 * @param date
	 * @return CenPackinglists
	 */
	@Query("SELECT list FROM CenPackinglists list "
			+ "JOIN list.cenPackinglistIndex cenPackinglistIndex  "
			+ "WHERE cenPackinglistIndex.npackinglistIndexKey = :npackinglistIndexKey "
			+ "AND list.dvalidFrom <= :date "
			+ "AND list.dvalidTo >= :date ")
	CenPackinglists findPackinglistByNpackinglistIndexKeyAndDdate(
			@Param("npackinglistIndexKey") final long npackinglistIndexKey,
			@Param("date") final Date date);

	/**
	 * Get the CenPackinglists for given packinglist and date
	 * 
	 * @param cpackinglist
	 * @param date
	 * @return CenPackinglists
	 */
	@Query("SELECT list FROM CenPackinglists list "
			+ "JOIN list.cenPackinglistIndex cenPackinglistIndex  "
			+ "WHERE cenPackinglistIndex.cpackinglist = :cpackinglist "
			+ "AND list.dvalidFrom <= :date "
			+ "AND list.dvalidTo >= :date ")
	CenPackinglists findPackinglistByCpackinglistAndDdate(
			@Param("cpackinglist") final String cpackinglist,
			@Param("date") final Date date);
	
	/**
	 * Get Packing lists by customerPL code, airline and validity
	 * 
	 * @param ccustomerPl customerPL code for packinglist
	 * @param nairlineKey airline key
	 * @param date reference date for validity
	 * @return CenPackinglists
	 */
	@EntityGraph(value = "CenPackinglists.index", type = EntityGraphType.FETCH, attributePaths = { "cenPackinglistIndex" })
	@Query("SELECT cp FROM CenPackinglists cp "
			+ "WHERE cp.ccustomerPl = :ccustomerPl "
			+ "AND cp.nairlineKey = :nairlineKey "
			+ "AND cp.dvalidFrom <= :date "
			+ "AND cp.dvalidTo >= :date ")
	CenPackinglists findAirlineSpecificByCcustomerPl(
			@Param("ccustomerPl") final String ccustomerPl,
			@Param("nairlineKey") final long nairlineKey,
			@Param("date") final Date date);
	
	/**
	 * Get Packing lists by customerPL code and validity for non airline!
	 * 
	 * @param ccustomerPl customerPL code for packinglist
	 * @param date reference date for validity
	 * @return CenPackinglists
	 */
	@EntityGraph(value = "CenPackinglists.index", type = EntityGraphType.FETCH, attributePaths = { "cenPackinglistIndex" })
	@Query("SELECT cp FROM CenPackinglists cp "
			+ "WHERE cp.ccustomerPl = :ccustomerPl "
			+ "AND cp.nairlineKey is null "
			+ "AND cp.dvalidFrom <= :date "
			+ "AND cp.dvalidTo >= :date ")
	CenPackinglists findNoneAirlineSpecificByCcustomerPl(
			@Param("ccustomerPl") final String ccustomerPl,
			@Param("date") final Date date);
}
