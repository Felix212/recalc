/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTrolley;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenOutPpmTrolleyRepository extends PagingAndSortingRepository<CenOutPpmTrolley, Long> {
	/**
	 * Returns the Max TrollyID for a Day
	 *
	 * @param ddate the day
	 * @param cunit
	 * @return last ntrolleyId of the day
	 */
	@Query("SELECT MAX(p.ntrolleyId) FROM CenOutPpmTrolley p WHERE p.ddate = :ddate and p.cunit = :cunit")
	Long getMaxNtrolleyIDByDdateAndCunit(@Param("ddate") Date ddate, @Param("cunit") String cunit);

	/**
	 * Returns all trolleys for a day
	 *
	 * @param ddate the day
	 * @param cunit
	 * @param cgate the gate
	 * @return List of trolleys
	 */
	List<CenOutPpmTrolley> findByDdateAndCunitAndCgate(Date ddate, String cunit, String cgate);

	/**
	 * Returns all trolleys with no tour for a day
	 *
	 * @param ddate the day
	 * @param cunit
	 * @param cgate the gate
	 * @return List of trolleys
	 */
	@Query("SELECT p FROM CenOutPpmTrolley p WHERE p.ddate = :ddate and p.cunit = :cunit and p.cenOutPpmTour IS NULL and p.cgate = :cgate ")
	List<CenOutPpmTrolley> getNotAsignedTrolleys(@Param("ddate") Date ddate, @Param("cunit") String cunit, @Param("cgate") String cgate);
}
