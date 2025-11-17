/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenJasperReport;

/**
 * Repository class for {@link CenJasperReport} object/table.
 * 
 * @author Dirk Bunk - U200035
 */
public interface CenJasperReportRepository extends PagingAndSortingRepository<CenJasperReport, Long> {

	/**
	 * Gets all {@link CenJasperReport} entities with blbJasper = null, meaning all uncompiled Jasper Reports.
	 * 
	 * @param maxrows maxium number of rows to retrieve
	 * @return all uncompiled Jasper Reports
	 */
	@Query("SELECT jr FROM CenJasperReport jr WHERE jr.blbJasper is null and rownum <= :maxrows")
	List<CenJasperReport> findAllUncompiled(@Param("maxrows") final Long maxrows);
}
