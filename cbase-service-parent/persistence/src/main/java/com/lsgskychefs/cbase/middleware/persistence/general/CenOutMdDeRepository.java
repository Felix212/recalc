/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdCo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdDe;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdDeId;

/**
 * Repository class for {@link CenOutMdDe} object/table
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdDeRepository extends PagingAndSortingRepository<CenOutMdDe, CenOutMdDeId> {
	/**
	 * Delete {@link CenOutMdDe} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);

	/**
	 * Get the item list on distribution errors
	 *
	 * @param nresultKey of respective result key
	 * @param ntransaction of respective transaction
	 * @param cpackinglist packinglist
	 * @param cmealControlCode meal control code
	 * @param ctext packinglist type
	 * @param cclass class
	 * @return the {@link CenOutMdCo} - part list on stowage
	 */
	CenOutMdDe findByIdNresultKeyAndIdNtransactionAndCpackinglistAndCmealControlCodeAndCtextAndCclass(long nresultKey,
			long ntransaction, String cpackinglist, String cmealControlCode, String ctext, String cclass);

	/**
	 * Get the max nrecordCount for given values.
	 *
	 * @param nresultKey of respective result key
	 * @param ntransaction of respective transaction
	 * @return the max nrecordCount for given values.
	 */
	@Query("SELECT MAX(de.id.nrecordCount) "
			+ "FROM CenOutMdDe de "
			+ "WHERE de.id.nresultKey = :nresultKey "
			+ "AND de.id.ntransaction = :ntransaction")
	Long findMaxNrecordCount(@Param("nresultKey") long nresultKey, @Param("ntransaction") long ntransaction);

	/**
	 * Gets the item list.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @return the item list
	 */
	List<CenOutMdDe> findByIdNresultKeyAndIdNtransaction(final long nresultKey, final long ntransaction);
}
