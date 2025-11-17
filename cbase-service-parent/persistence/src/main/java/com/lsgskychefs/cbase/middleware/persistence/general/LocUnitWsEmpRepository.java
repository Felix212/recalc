/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWsEmp;

/**
 * Repository class for {@link LocUnitWsEmp} object/table
 *
 * @author Ingo Rietzschel - U125742
 */
public interface LocUnitWsEmpRepository extends PagingAndSortingRepository<LocUnitWsEmp, Long> {

	/**
	 * Load {@link LocUnitWsEmp} filtered by nworkscheduleIndex(schedule/shift)
	 *
	 * @param nday day of week 1-7 (Monday-Sunday)
	 * @param nworkscheduleIndex work shift ids
	 * @return the {@link LocUnitWsEmp} list
	 */
	List<LocUnitWsEmp> findByNdayAndNworkscheduleIndexIn(int nday, Long... nworkscheduleIndex);
}
