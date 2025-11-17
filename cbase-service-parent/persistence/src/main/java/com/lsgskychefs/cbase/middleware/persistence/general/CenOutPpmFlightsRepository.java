/*
 * CenOutPpmFlightsRepository.java
 *
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface CenOutPpmFlightsRepository extends PagingAndSortingRepository<CenOutPpmFlights, Long> {

	/**
	 * Alle Flüge in einem Trolley
	 * 
	 * @param ntrolleyKey
	 * @return List<CenOutPpmFlights>
	 */
	@Query("SELECT DISTINCT p FROM CenOutPpmFlights p "
			+ "WHERE p.id.nresultKey in (select pld.nresultKey from CenOutPpmPrLabDetail pld where"
			+ " pld.cenOutPpmProdLabel.cenOutPpmTrolley.nppmTrolleyKey = :ntrolleyKey)"
			+ " order by p.cairline, p.nflightNumber, p.csuffix, p.ddeparture")
	List<CenOutPpmFlights> getFlightsByNppmTrolleyKey(@Param("ntrolleyKey") long ntrolleyKey);

	/**
	 * Alle Flüge für einen Resultkey
	 * 
	 * @param nresult_key
	 * @return List<CenOutPpmFlights>
	 */
	List<CenOutPpmFlights> getFlightsByIdNresultKey(long nresult_key);

	/**
	 * All Flights for a Batch
	 * 
	 * @param nbatchSeq the id
	 * @return list of {@link CenOutPpmFlights}
	 */
	List<CenOutPpmFlights> findDistinctByCenOutPpmsNbatchSeq(long nbatchSeq);

	/**
	 * Get all Flights for a Date and Unit who has Trucks
	 * 
	 * @param cunit
	 * @param ddeparture
	 * @return List<CenOutPpmFlights>
	 */
	@Query("SELECT DISTINCT p FROM CenOutPpmFlights p "
			+ "WHERE p.id.nresultKey in (select pt.nresultKey from CenOutPpmTruck pt)"
			+ " and p.cunit = :cunit"
			+ " and p.ddeparture = :ddeparture"
			+ " order by p.cairline, p.nflightNumber, p.csuffix, p.ddeparture")

	List<CenOutPpmFlights> getFlightsWithTruckByCunitAndDdeparture(@Param("cunit") String cunit, @Param("ddeparture") Date ddeparture);

}
