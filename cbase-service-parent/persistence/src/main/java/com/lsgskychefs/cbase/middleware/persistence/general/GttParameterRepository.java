/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.GttParameter;

/**
 * Repository class for {@link GttParameter} object/table.
 * 
 * @author Ingo Rietzschel - U125742
 */
public interface GttParameterRepository extends PagingAndSortingRepository<GttParameter, Long> {
	/**
	 * Retrieves a list of <code>GttParameter</code> elements that match the given parameter name
	 *
	 * @param cparmName the parameter name to search for
	 * @return the list of {@link GttParameter}
	 */
	List<GttParameter> findByCparmName(String cparmName);

	/**
	 * Retrieves a list of distinct <code>GttParameter</code> elements that match the given parameter name
	 *
	 * @param cparmName the parameter name to search for
	 * @return the list of distinct {@link GttParameter}
	 */
	@Query("SELECT DISTINCT gtt.nparmNumber FROM GttParameter gtt WHERE gtt.cparmName = :cparmName")
	List<Long> findDistinctNparmNumberByCparmName(@Param("cparmName") String cparmName);

	/**
	 * Retrieve a list of distinct <code>GttParameter</code> elements with its type that match the given parameter name where nparmNumber3:
	 * -- 1=Flightlabel -- 2=Prodlabel1 -- 22=Prodlabel2 -- 3=CartDiagram
	 * 
	 * @param cparmName
	 * @return
	 */
	@Query("SELECT gtt FROM GttParameter gtt WHERE gtt.nparmKey in "
			+ "(SELECT MIN(gtt.nparmKey) FROM GttParameter gtt WHERE gtt.cparmName = :cparmName GROUP BY gtt.nparmNumber, gtt.nparmNumber3)")
	List<GttParameter> findDistinctNparmNumberAndNparmNumber3ByCparmName(@Param("cparmName") String cparmName);
}
