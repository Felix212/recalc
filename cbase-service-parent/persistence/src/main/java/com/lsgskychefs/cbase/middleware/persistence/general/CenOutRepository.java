/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.constant.sysexplosion.SysExplosionProcessState;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysExplosion;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;

/**
 * Repository class for CenOut the flight event object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutRepository extends PagingAndSortingRepository<CenOut, Long> {

	/**
	 * Gets the day flight list by unit.
	 *
	 * @param ddeparture departure date
	 * @param nrouting routing number
	 * @param nlegNumber leg - flight section number
	 * @param cunit company of the region
	 * @return the day flight list
	 */
	@EntityGraph(value = "CenOut.cenOutPaxes", type = EntityGraphType.LOAD, attributePaths = { "cenOutPaxes", "cenOutComment" })
	@Query("SELECT DISTINCT cenOut FROM CenOut cenOut "
			+ "WHERE cenOut.cunit = :cunit "
			+ "AND cenOut.ddeparture = :ddeparture "
			+ "AND ( :nlegNumber IS NULL OR cenOut.nlegNumber = :nlegNumber ) "
			+ "AND ( :nrouting IS NULL OR cenOut.nroutingId = :nrouting ) "
			+ "ORDER BY cenOut.cdepartureTime ASC")
	List<CenOut> findFlightsByUnit(
			@Param("ddeparture") final Date ddeparture,
			@Param("nrouting") final Long nrouting,
			@Param("nlegNumber") final Integer nlegNumber,
			@Param("cunit") final String cunit);

	/**
	 * Gets the day flight list by unit and airline.
	 * 
	 * @param ddeparture departure date
	 * @param nrouting routing number
	 * @param nairlineKey airline key
	 * @param cunit company of the region
	 * @return the day flight list
	 */
	@EntityGraph(value = "CenOut.cenOutPaxes", type = EntityGraphType.LOAD, attributePaths = { "cenOutPaxes", "cenOutComment" })
	@Query("SELECT DISTINCT cenOut FROM CenOut cenOut "
			+ "WHERE cenOut.cunit = :cunit "
			+ "AND cenOut.ddeparture = :ddeparture "
			+ "AND ( cenOut.nairlineKey = :nairlineKey ) "
			+ "AND ( :nrouting IS NULL OR cenOut.nroutingId = :nrouting ) "
			+ "ORDER BY cenOut.cdepartureTime ASC")
	List<CenOut> findFlightsByUnitAirline(
			@Param("ddeparture") final Date ddeparture,
			@Param("nrouting") final Long nrouting,
			@Param("nairlineKey") final Long nairlineKey,
			@Param("cunit") final String cunit);

	/**
	 * Get the flight. Set a LOCK
	 *
	 * @param nresultKey the primary key
	 * @return the flight
	 */
	@Lock(LockModeType.PESSIMISTIC_WRITE)
	@QueryHints({ @QueryHint(name = "javax.persistence.lock.timeout", value = "5000") })
	CenOut findByNresultKey(long nresultKey);

	/**
	 * Get all flights for given ID's.
	 *
	 * @param nresultKeys the ID's
	 * @return the flights
	 */
	List<CenOut> findByNresultKeyIn(List<Long> nresultKeys);

	/**
	 * Gets all flights by given parameter without ongoing {@link SysExplosion} job {@link SysExplosionProcessState#UNPROCESSED}
	 *
	 * @param dvalidFrom from date for flights
	 * @param dvalidTo to date for flights
	 * @param cunit unit number as string
	 * @param cclient mandant
	 * @param npackinglistIndexKey packinglist index key
	 * @return flight list
	 */
	@Query("SELECT DISTINCT cenOut FROM CenOut cenOut, CenOutMaster cenOutMaster "
			+ "WHERE cenOut.cunit = :cunit "
			+ "AND cenOut.cclient = :cclient "
			+ "AND cenOut.ddeparture BETWEEN :dvalidFrom AND :dvalidTo "
			+ "AND cenOut.nresultKey = cenOutMaster.nresultKey "
			+ "AND cenOutMaster.nplIndexKey = :npackinglistIndexKey "
			+ "AND cenOutMaster.nplType = 1 "
			+ "AND cenOut.nresultKey not in (SELECT nresultKey FROM SysExplosion WHERE nprocessStatus = 0)")
	List<CenOut> findFlightsWithoutSysExplosion(
			@Param("dvalidFrom") final Date dvalidFrom,
			@Param("dvalidTo") final Date dvalidTo,
			@Param("cunit") final String cunit,
			@Param("cclient") final String cclient,
			@Param("npackinglistIndexKey") final Long npackinglistIndexKey);

	/**
	 * Get the flights.
	 *
	 * @param cairline airline owner
	 * @param nflightNumber flight number
	 * @param csuffix flight suffix(a suffix or a blank)
	 * @param ddeparture departure date
	 * @param nlegNumber the flight leg number
	 * @return the flights
	 */
	List<CenOut> findByCairlineAndNflightNumberAndDdepartureAndCsuffixAndNlegNumber(String cairline, int nflightNumber,
			Date ddeparture, String csuffix, int nlegNumber);

	/**
	 * Get the flights.
	 *
	 * @param cairline airline owner
	 * @param nflightNumber flight number
	 * @param csuffix flight suffix(a suffix or a blank)
	 * @param ddeparture departure date
	 * @return the flights
	 */
	List<CenOut> findByCairlineAndNflightNumberAndDdepartureAndCsuffix(String cairline, int nflightNumber,
			Date ddeparture, String csuffix);

	/**
	 * Get the favorite flights for a day and user
	 * 
	 * @param ddeparture
	 * @param sysLogin
	 * @return the flights
	 */
	List<CenOut> findByDdepartureAndSysLogins(Date ddeparture, SysLogin sysLogin);

	/**
	 * Gets the flights by departure date and unit
	 * 
	 * @param ddeparture the departure date
	 * @param cunit the unit
	 * @return the day flight list
	 */
	@Query("SELECT cenOut FROM CenOut cenOut "
			+ "WHERE cenOut.ddeparture = :ddeparture "
			+ "AND cenOut.cunit = :cunit")
	List<CenOut> findByDdepartureAndCunit(
			@Param("ddeparture") final Date ddeparture,
			@Param("cunit") final String cunit);
}
