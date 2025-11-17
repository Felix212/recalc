/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistory;

/**
 * Repository class for {@link SysLoginHistory}.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysLoginHistoryRepository extends PagingAndSortingRepository<SysLoginHistory, Long> {

	/**
	 * Search history entities for change password in given date range.
	 *
	 * @param nuserId searched user
	 * @param dchangeStart kind of SysLoginHistory
	 * @param dchangeEnd date of
	 * @return the filtered {@link SysLoginHistory} entities
	 */
	@Query("SELECT hist from SysLoginHistory hist "
			+ "JOIN hist.sysLogin login "
			+ "WHERE hist.sysLoginHistkind.nloginHistkindKey = 1 "
			+ "AND login.nuserId = :nuserId "
			+ "AND hist.dchange BETWEEN :dchangeStart AND :dchangeEnd")
	List<SysLoginHistory> findSysLoginHistory(
			@Param("nuserId") long nuserId,
			@Param("dchangeStart") Date dchangeStart,
			@Param("dchangeEnd") Date dchangeEnd);

}
