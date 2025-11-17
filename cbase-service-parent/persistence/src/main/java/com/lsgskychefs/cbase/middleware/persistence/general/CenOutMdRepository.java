/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMd;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMdId;

/**
 * Repository class for {@link CenOutMd} object/table
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutMdRepository extends PagingAndSortingRepository<CenOutMd, CenOutMdId> {

	/**
	 * Delete {@link CenOutMd} by given flight.
	 *
	 * @param nresultKey flight key
	 */
	void deleteByIdNresultKey(long nresultKey);
}
