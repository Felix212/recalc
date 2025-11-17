/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;

/**
 * Repository class for {@link CenOutSpml} entity/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutSpmlRepository extends PagingAndSortingRepository<CenOutSpml, Long> {

	/**
	 * Gets the flight spml(special meal) data.
	 *
	 * @param nresultKey id for {@link CenOut} flight event
	 * @return the flight spml data
	 */
	List<CenOutSpml> findByNresultKeyOrderByNclassNumberAscNprioAsc(long nresultKey);

	/**
	 * Gets the flight spml(special meal) data by class filter.
	 *
	 * @param nresultKey id for {@link CenOut} flight event
	 * @param cclass the class to filter
	 * @return the flight spml data
	 */
	List<CenOutSpml> findByNresultKeyAndCclassOrderByNprioAsc(long nresultKey, String cclass);
}
