/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitReportSchedule;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;

/**
 * Repository class for {@link SysUnits}
 *
 * @author Alex Schaab - U524036
 */
public interface SysUnitsJpaRepository extends PagingAndSortingRepository<SysUnits, String> {

	/**
	 * Get units that have a {@link LocUnitReportSchedule} assigned.
	 * 
	 * @return List of {@link SysUnits}
	 */
	public List<SysUnits> findDistinctByLocUnitReportSchedulesNotNull();
}
