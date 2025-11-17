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

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmSched;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutPpmSchedRepository extends PagingAndSortingRepository<CenOutPpmSched, Long> {

	/**
	 * Find CenOutPpmSched by Mandant, Unit, Proddate. *
	 * 
	 * @param cclient the Client
	 * @param cunit The Unit
	 * @param dprodDate The Production date
	 * @return List of CenOutPpmSched Entries
	 */
	List<CenOutPpmSched> findByCclientAndCunitAndDprodDate(String cclient, String cunit, Date dprodDate);

	/**
	 * Find CenOutPpmSched by Unit, Proddate.
	 * 
	 * @param nworkscheduleIndex
	 * @param dprodDate
	 * @return List of CenOutPpmSched Entries
	 */
	List<CenOutPpmSched> findByNworkscheduleIndexAndDprodDate(long nworkscheduleIndex, Date dprodDate);

	/**
	 * Find CenOutPpmSched by Mandant, Unit, Proddate, Workstation
	 * 
	 * @param cclient
	 * @param cunit
	 * @param dprodDate
	 * @param nworkstationKey
	 * @return
	 */
	@Query("SELECT DISTINCT cops FROM CenOutPpmSched cops "
			+ "JOIN cops.cenOutPpms cop  "
			+ "WHERE cop.nworkstationKey = :nworkstationKey "
			+ "AND cops.cclient = :cclient "
			+ "AND cops.cunit = :cunit "
			+ "AND cops.dprodDate = :dprodDate ")
	List<CenOutPpmSched> findByCclientAndCunitAndDprodDateAndCenOutPpmsNworkstationKey(@Param("cclient") String cclient,
			@Param("cunit") String cunit, @Param("dprodDate") Date dprodDate,
			@Param("nworkstationKey") Long nworkstationKey);

	/**
	 * Find CenOutPpmSched by Workstationkey and Last Shift End Time
	 * 
	 * @param nworkstationKey
	 * @param dtimeab
	 * @return
	 */
	@Query("SELECT DISTINCT cops FROM CenOutPpmSched cops "
			+ "WHERE cops.nworkstationKey = :nworkstationKey "
			+ "AND cops.dtimefrom > :dtimeab "
			+ "ORDER BY cops.dtimefrom")
	List<CenOutPpmSched> findNextShifts(@Param("nworkstationKey") Long nworkstationKey, @Param("dtimeab") Date dtimeab);

}
