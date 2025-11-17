/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitReportSchedule;

/**
 * Repository class for {@link LocUnitReportSchedule}
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitReportScheduleRepository extends PagingAndSortingRepository<LocUnitReportSchedule, Long> {

	/**
	 * Get one {@link LocUnitReportSchedule} for specific unit
	 * 
	 * @param nscheduleKey pk
	 * @param cunit the unit
	 * @return {@link LocUnitReportSchedule}
	 */
	LocUnitReportSchedule findByNscheduleKeyAndSysUnitsCunit(final Long nscheduleKey, final String cunit);

	/**
	 * Get a list of {@link LocUnitReportSchedule} for specific unit
	 * 
	 * @param cunit the unit
	 * @return list of {@link LocUnitReportSchedule}
	 */
	List<LocUnitReportSchedule> findBySysUnitsCunit(final String cunit);
}
