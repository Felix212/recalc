/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPaxId;

/**
 * Repository class for {@link CenOutPax} object/table.
 * 
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutPaxRepository extends PagingAndSortingRepository<CenOutPax, CenOutPaxId> {

	/**
	 * Get the PAX(person approximately) informations for a flight.
	 *
	 * @param nresultKey the flight key
	 * @return pax information for a flight.
	 */
	List<CenOutPax> findByIdNresultKey(long nresultKey);
}
