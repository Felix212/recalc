/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysCustomerReports;

/**
 * Repository class for {@link SysCustomerReports} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysCustomerReportsRepository extends PagingAndSortingRepository<SysCustomerReports, Long> {

	/**
	 * Get the report definitions for given section.
	 * 
	 * @param csection the section to get relevant reports
	 * @return the searched reports
	 */
	List<SysCustomerReports> findByCsectionOrderByCdescriptionAsc(String csection);

	/**
	 * Get the report definitions for given section and description.
	 * 
	 * @param csection the section to get relevant reports
	 * @param cdescription the description to get relevant reports
	 * @return the searched reports
	 */
	List<SysCustomerReports> findByCsectionAndCdescription(String csection, String cdescription);

	/**
	 * Get the report definition for given PK and section.
	 * 
	 * @param ncusReportKey the pk
	 * @param csection the section to get relevant reports
	 * @return {@link SysCustomerReports}
	 */
	SysCustomerReports findByNcusReportKeyAndCsectionOrderByCdescriptionAsc(Long ncusReportKey, String csection);

}
