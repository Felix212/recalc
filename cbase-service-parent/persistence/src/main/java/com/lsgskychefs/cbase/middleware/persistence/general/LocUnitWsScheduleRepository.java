/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPpmValidities;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitProdTimeFrame;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWsSchedule;

/**
 * Repository class for {@link LocUnitWsSchedule}
 *
 * @author Ingo Rietzschel - U125742
 */
public interface LocUnitWsScheduleRepository extends PagingAndSortingRepository<LocUnitWsSchedule, Long> {

	/**
	 * Filter {@link LocUnitWsSchedule} by unit, client ({@link LocUnitAreas}) and date ( {@link LocUnitProdTimeFrame}).
	 *
	 * @param cunit company of the region
	 * @param cclient client number(mandator)
	 * @param date limitation for workorder that are valid/available
	 * @return filtered {@link LocUnitWsSchedule} or empty List
	 */
	@Query("SELECT DISTINCT wsschedule FROM LocUnitWsSchedule wsschedule "
			+ "JOIN wsschedule.locPlTimeFrames tf "
			+ "WHERE "
			+ "wsschedule.locUnitWorkstation.locUnitAreas.cunit = :cunit "
			+ "AND wsschedule.locUnitWorkstation.locUnitAreas.cclient = :cclient "
			+ "AND :date BETWEEN tf.locUnitProdTimeFrame.locUnitPpmValidities.dvalidFrom AND tf.locUnitProdTimeFrame.locUnitPpmValidities.dvalidTo ")
	List<LocUnitWsSchedule> findByClientAndUnitAndDate(
			@Param("cunit") final String cunit,
			@Param("cclient") final String cclient,
			@Param("date") final Date date);

	/**
	 * Filter {@link LocUnitWsSchedule} by workstationKey, client ({@link LocUnitAreas}) and date ( {@link LocUnitProdTimeFrame}).
	 * 
	 * @param nworkstationKey the key of the workstation
	 * @param date limitation for workorder that are valid/available
	 * @return filtered {@link LocUnitWsSchedule} or empty List
	 */
	@Query("SELECT DISTINCT wsschedule FROM LocUnitWsSchedule wsschedule "
			+ "JOIN wsschedule.locUnitPpmValidities validity "
			+ "WHERE "
			+ "wsschedule.nworkstationKey = :nworkstationKey "
			+ "AND :date BETWEEN validity.dvalidFrom AND validity.dvalidTo ")
	List<LocUnitWsSchedule> findByNworkstationKeyAndDate(
			@Param("nworkstationKey") final Long nworkstationKey,
			@Param("date") final Date date);

	/**
	 * Filter {@link LocUnitWsSchedule} by workschedule index, client ({@link LocUnitAreas}) and date ( {@link LocUnitProdTimeFrame}).
	 * 
	 * @param nworkschedule_index the key of the schedule
	 * @param date limitation for workorder that are valid/available
	 * @return filtered {@link LocUnitWsSchedule} or empty List
	 */
	@Query("SELECT DISTINCT wsschedule FROM LocUnitWsSchedule wsschedule "
			+ "JOIN wsschedule.locUnitPpmValidities validity "
			+ "WHERE "
			+ "wsschedule.nworkscheduleIndex = :nworkscheduleIndex ")
	List<LocUnitWsSchedule> findByNscheduleKeyAndDate(
			@Param("nworkscheduleIndex") final Long nworkscheduleIndex);

	/**
	 * Find if an increase shift exists
	 * 
	 * @param nworkscheduleIndex the key of a schedule of a workstation
	 * @return the key of the increase shift
	 */
	@Query("SELECT wsscheduleIncrease.locUnitWsSchedule.nworkscheduleIndex FROM LocUnitWsSchedule wsschedule, LocUnitWsSchedIncrease wsscheduleIncrease "
			+ "WHERE wsschedule.nworkscheduleIndex = :nworkscheduleIndex "
			+ "AND wsscheduleIncrease.id.nworkstationKey = wsschedule.nworkstationKey "
			+ "AND wsscheduleIncrease.id.nvalidIndex =  wsschedule.nvalidIndex")
	Long findIncreaseShiftExists(
			@Param("nworkscheduleIndex") final Long nworkscheduleIndex);

	/**
	 * Select unit validities
	 * 
	 * @param cunit
	 * @return filtered {@link LocUnitPpmValidities} or empty List
	 */
	@Query("SELECT locUnitPpmValidities FROM LocUnitPpmValidities locUnitPpmValidities "
			+ "WHERE locUnitPpmValidities.cunit = :cunit ")
	List<LocUnitPpmValidities> findUnitValidities(
			@Param("cunit") final String cunit);

}
