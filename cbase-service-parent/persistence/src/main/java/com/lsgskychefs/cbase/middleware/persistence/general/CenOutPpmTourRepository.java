/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
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

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTour;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenOutPpmTourRepository extends PagingAndSortingRepository<CenOutPpmTour, Long> {
	/**
	 * Returns the Max Trolly to be produced for the whole Batch
	 *
	 * @param ddate the proddate
	 * @param cunit unit
	 * @return the last ntourId of the day
	 */

	@Query("SELECT MAX(p.ntourId) FROM CenOutPpmTour p WHERE p.dprodDate = :ddate and p.cunit = :cunit ")
	Long getMaxNtourIdByDdateAndCunit(@Param("ddate") Date ddate, @Param("cunit") String cunit);

	/**
	 * Returns all tours of the day for a unit
	 *
	 * @param ddate the proddate
	 * @param cunit the unit
	 * @param cgate the gate
	 * @return the last ntourId of the day
	 */
	List<CenOutPpmTour> findByDprodDateAndCunitAndCgateOrderByNtourId(Date ddate, String cunit, String cgate);

	/**
	 * Returns all tours between interval dates for a unit
	 *
	 * @param ddate the proddate
	 * @param cunit the unit
	 * @param cgate the gate
	 * @param ddateFrom the firstDate
	 * @param ddateTo the secondDate
	 * @return the last ntourId of the day
	 */
	List<CenOutPpmTour> findByDprodDateBetweenAndCunitAndCgateOrderByNtourId(Date ddateFrom, Date ddateTo, String cunit, String cgate);

	/**
	 * Get the tour by pk. Trolleys -> and TrolleyConts will be loaded directly!
	 * 
	 * @param nppmTourKey pk
	 * @return {@link CenOutPpmTour}
	 */
	@EntityGraph(value = "CenOutPpmTour.allTrolleys", type = EntityGraphType.LOAD)
	CenOutPpmTour findByNppmTourKey(Long nppmTourKey);
}
