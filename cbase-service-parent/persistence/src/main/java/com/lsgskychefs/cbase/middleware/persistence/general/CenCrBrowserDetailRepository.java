/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenCrBrowserDetail;

/**
 * Repository class for {@link CenCrBrowserDetail} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenCrBrowserDetailRepository extends PagingAndSortingRepository<CenCrBrowserDetail, Long> {

	/**
	 * Get all parameter details for given report.
	 *
	 * @param nreportKey report id
	 * @return parameter detail information for given report
	 */
	List<CenCrBrowserDetail> findByNreportKey(long nreportKey);
}
