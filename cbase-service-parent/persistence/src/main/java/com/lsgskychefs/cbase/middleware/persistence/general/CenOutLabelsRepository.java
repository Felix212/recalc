/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutLabels;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutLabelsId;

/**
 * Repository class for {@link CenOutLabels} object/table
 * 
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutLabelsRepository extends PagingAndSortingRepository<CenOutLabels, CenOutLabelsId> {

	/**
	 * Delete {@link CenOutLabels} by given flight and transaction.
	 *
	 * @param nresultKey flight key
	 * @param ntransaction transaction key
	 */
	void deleteByIdNresultKeyAndIdNtransaction(long nresultKey, long ntransaction);

	/**
	 * Find Document Browser Cen Out Labels
	 * 
	 * @param resultKeys, list of result keys
	 * @param user, user
	 * @return {@link CenOutLabels}
	 */
	@Query("SELECT lab FROM CenOutLabels lab "
			+ "JOIN lab.cenOut co WHERE "
			+ "co.ntransaction = lab.id.ntransaction AND "
			+ "co.nresultKey IN (:resultKeys) AND "
			+ "lab.id.cuser = :user")
	List<CenOutLabels> findByResultKeysAndUser(@Param("resultKeys") final List<Long> resultKeys, @Param("user") final String user);

}
