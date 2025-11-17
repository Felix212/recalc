/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenReportParameters;

/**
 * Repository class for {@link CenReportParameters} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenReportParametersRepository extends PagingAndSortingRepository<CenReportParameters, Long> {

	/**
	 * Delete all report parameters with date before given point of time.
	 * 
	 * @param dtimestamp the point of time
	 */
	void deleteByDtimestampBefore(Date dtimestamp);

	/**
	 * Delete all related parameters by their parameter group
	 * 
	 * @param nparameterGroup the group key
	 */
	void deleteByNparameterGroup(Long nparameterGroup);
}
