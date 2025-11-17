/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdLo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdLoId;

/**
 * Repository class for {@link CenOutMdLo} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdLoRepository extends PagingAndSortingRepository<CenOutMdLo, CenOutMdLoId> {

	/**
	 * Gets the flight loading data.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @param nstowageKey stowage id
	 * @return the flight loading data
	 */
	List<CenOutMdLo> findByIdNresultKeyAndIdNtransactionAndNstowageKey(final long nresultKey, final long ntransaction,
			final Long nstowageKey);
	
	/**
	 * Gets the flight loading data.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @return the flight loading data
	 */
	List<CenOutMdLo> findByIdNresultKey(final long nresultKey);

	/**
	 * Gets the flight loading data.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @return the flight loading data
	 */
	List<CenOutMdLo> findByIdNresultKeyAndIdNtransaction(final long nresultKey, final long ntransaction);

	/**
	 * Gets the flight loading data.
	 *
	 * @param nresultKey id for flight {@link CenOut}
	 * @param ntransaction transaction id
	 * @param nstowageKey stowage id
	 * @param nbellyContainer flight belly
	 * @return the flight loading data
	 */
	List<CenOutMdLo> findByIdNresultKeyAndIdNtransactionAndNstowageKeyAndNbellyContainer(final long nresultKey, final long ntransaction,
			final Long nstowageKey, int nbellyContainer);

	/**
	 * Delete {@link CenOutMdLo} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);
}
