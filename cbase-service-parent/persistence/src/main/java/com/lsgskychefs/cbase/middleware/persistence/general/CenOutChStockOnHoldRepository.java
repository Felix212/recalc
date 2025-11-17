/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutChStockOnHold;

/**
 * Repository class for {@link CenOutChStockOnHold} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenOutChStockOnHoldRepository extends PagingAndSortingRepository<CenOutChStockOnHold, Long> {

	/**
	 * Find stock on hold for the logged in user and its session id
	 * 
	 * @param username, username of the logged in user
	 * @param csessionid, session id
	 * @return List of {@link CenOutChStockOnHold}
	 */
	List<CenOutChStockOnHold> findByCuserAndCsessionidNot(final String username, final String csessionid);

	/**
	 * Delete by username and its session id
	 * 
	 * @param username, username of the logged in user
	 * @param csessionid, session id
	 */
	void deleteByCuserAndCsessionidNot(final String username, final String csessionid);

}
