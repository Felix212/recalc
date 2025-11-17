/*
 * LocUnitWorkstationsRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWorkstation;

/**
 * Workstation Repository class.
 *
 * @author Alex Schaab
 */
public interface LocUnitWorkstationRepository extends PagingAndSortingRepository<LocUnitWorkstation, Long> {

	/**
	 * Finds workstations by their area keys
	 *
	 * @param nareaKeys area key for filter
	 * @return filtered workstations
	 */
	@Query("SELECT ws FROM LocUnitWorkstation ws WHERE locUnitAreas.nareaKey IN :nareaKeys")
	List<LocUnitWorkstation> findByNareaKeyIn(@Param("nareaKeys") List<Long> nareaKeys);

	/**
	 * Finds PPM relevant workstations by their area key
	 * 
	 * @param nareaKey area key for filter
	 * @return filtered workstations
	 */
	@Query("SELECT DISTINCT ws FROM LocUnitWorkstation ws "
			+ "WHERE nareaKey = :nareaKey "
			+ "and nworkstationKey in (select nworkstationKey from LocUnitWsSchedule where nareaKey = :nareaKey)")
	List<LocUnitWorkstation> findByNareaKeywithPpmMasterdata(@Param("nareaKey") Long nareaKey);

	/**
	 * Finds PLO relevant workstations by their area key
	 * 
	 * @param nareaKey
	 * @return filtered workstations
	 */
	@Query("SELECT DISTINCT ws FROM LocUnitWorkstation ws "
			+ "WHERE nareaKey = :nareaKey "
			+ "and nworkstationKey in (select a.locUnitWorkstation.nworkstationKey from LocPloWsShift a where a.locUnitWorkstation.nareaKey = :nareaKey)")
	List<LocUnitWorkstation> findByNareaKeywithPloMasterdata(@Param("nareaKey") Long nareaKey);

	/**
	 * Find workstation by area, name and description
	 * 
	 * @param nareaKey, area key
	 * @param cworkstation, workstation name
	 * @param ctext, workstation description
	 * @return the found workstation
	 */
	LocUnitWorkstation findByLocUnitAreasNareaKeyAndCworkstationIgnoreCaseAndCtextIgnoreCase(long nareaKey, String cworkstation,
			String ctext);

	/**
	 * Find workstations by area key
	 * 
	 * @param nareaKey, area key
	 * @return List of {@link LocUnitWorkstation}
	 */
	List<LocUnitWorkstation> findByLocUnitAreasNareaKeyOrderByCworkstationAsc(final Long nareaKey);

}
