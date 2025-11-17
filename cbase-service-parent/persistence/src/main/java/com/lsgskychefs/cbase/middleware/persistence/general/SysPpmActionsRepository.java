/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmActions;

/**
 * Repository class.
 * 
 * @author Ingo Rietzschel - U125742
 */
public interface SysPpmActionsRepository extends PagingAndSortingRepository<SysPpmActions, Integer> {

	/**
	 * Get all actions order by ninternal and nalertLevel.
	 *
	 * @return all actions
	 */
	List<SysPpmActions> findAllByOrderByNinternalAscNalertLevelAsc();
}
