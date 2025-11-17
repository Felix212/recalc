/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdCo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdCoId;

/**
 * Repository class for {@link CenOutMdCo} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdCoRepository extends PagingAndSortingRepository<CenOutMdCo, CenOutMdCoId> {

	/**
	 * Get last meal destribution ntransaction number.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the last/current ntransaction number
	 */
	@Query("SELECT MAX(co.id.ntransaction) FROM CenOutMdCo co WHERE co.id.nresultKey = :nresultKey ")
	Long findCurrentFlightNtransaction(@Param("nresultKey") long nresultKey);

	/**
	 * Delete {@link CenOutMdCo} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);

	/**
	 * Get the item list on storage area (stowage)
	 *
	 * @param nresultKey of respective result key
	 * @param ntransaction of respective transaction
	 * @param narrayCount arrayCount-Value of selected storage area (stowage)
	 * @param cpackinglist packinglist
	 * @param cmealControlCode meal control code
	 * @param cplType packinglist type
	 * @param cclass class
	 * @return the {@link CenOutMdCo} - part list on stowage
	 */
	CenOutMdCo findByIdNresultKeyAndIdNtransactionAndIdNarrayCountAndCpackinglistAndCmealControlCodeAndCplTypeAndCclass(
			long nresultKey,
			long ntransaction,
			long narrayCount,
			String cpackinglist,
			String cmealControlCode,
			String cplType,
			String cclass);

	/**
	 * Get the max nrecordCount for given values.
	 *
	 * @param nresultKey of respective result key
	 * @param ntransaction of respective transaction
	 * @param narrayCount arrayCount-Value of selected storage area (stowage)
	 * @return the max nrecordCount for given values.
	 */
	@Query("SELECT MAX(co.id.nrecordCount) "
			+ "FROM CenOutMdCo co "
			+ "WHERE co.id.nresultKey = :nresultKey "
			+ "AND co.id.ntransaction = :ntransaction "
			+ "AND co.id.narrayCount = :narrayCount")
	Long findMaxNrecordCount(
			@Param("nresultKey") long nresultKey,
			@Param("ntransaction") long ntransaction,
			@Param("narrayCount") long narrayCount);

	/**
	 * Get the meal distribution content for given values.
	 *
	 * @param nresultKey of respective result key
	 * @param ntransaction of respective transaction
	 * @param narrayCount arrayCount-Value of selected storage area (stowage)
	 * @return the meal distribution content for given values.
	 */
	List<CenOutMdCo> findByIdNresultKeyAndIdNtransactionAndIdNarrayCount(
			@Param("nresultKey") long nresultKey,
			@Param("ntransaction") long ntransaction,
			@Param("narrayCount") long narrayCount);
}
