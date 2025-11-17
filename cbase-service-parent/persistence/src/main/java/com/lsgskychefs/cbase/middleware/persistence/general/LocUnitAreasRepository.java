/*
 * LocUnitAreasRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;

/**
 * Repository class.
 *
 * @author Andreas Morgenstern
 */
public interface LocUnitAreasRepository extends PagingAndSortingRepository<LocUnitAreas, Long> {

	/**
	 * Find by cunit order by carea asc ctext asc.
	 *
	 * @param cunit the cunit
	 * @return the list
	 */
	List<LocUnitAreas> findByCunitOrderByCareaAscCtextAsc(String cunit);

	/**
	 * Find by cunit and cclient.
	 *
	 * @param cunit the cunit
	 * @param cclient the mandant
	 * @return the list
	 */
	List<LocUnitAreas> findByCunitAndCclient(String cunit, String cclient);

	/**
	 * Find by cunit and cclient, ordered by carea.
	 *
	 * @param cunit the cunit
	 * @param cclient the mandant
	 * @return the list
	 */
	List<LocUnitAreas> findByCunitAndCclientOrderByCareaAsc(String cunit, String cclient);

	/**
	 * Find all areas with ppm masterdata by cunit
	 * 
	 * @param cunit
	 * @return the list
	 */
	@Query("SELECT DISTINCT p FROM LocUnitAreas p, LocUnitWsSchedule h WHERE "
			+ "p.cunit = :cunit "
			+ "AND p.nareaKey = h.nareaKey "
			+ " order by p.carea, p.ctext ")
	List<LocUnitAreas> findCunitwithPpmMasterdata(@Param("cunit") String cunit);

	/**
	 * Find all areas with plo masterdata by cunit
	 * 
	 * @param cunit
	 * @return the list
	 */
	@Query("SELECT DISTINCT p FROM LocUnitAreas p, LocPloShift h WHERE "
			+ "p.cunit = :cunit "
			+ "AND p.cunit = h.sysUnits.cunit "
			+ " order by p.carea, p.ctext ")
	List<LocUnitAreas> findCunitwithPloMasterdata(@Param("cunit") String cunit);

	/**
	 * Find area by unit, client, name and description
	 * 
	 * @param cunit, unit key
	 * @param cclient, client key
	 * @param carea, area name
	 * @param ctext, area description
	 * @return the area found
	 */
	LocUnitAreas findByCunitAndCclientAndCareaIgnoreCaseAndCtextIgnoreCase(String cunit, String cclient, String carea, String ctext);

}
