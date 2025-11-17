/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmGroup;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmGroupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmRules;

/**
 * Repository class for Workorder Rules.
 *
 * @author Alex Schaab - U524036
 */
public interface SysPpmGroupRepository extends PagingAndSortingRepository<SysPpmGroup, SysPpmGroupId> {

	/**
	 * Finds all <code>SysPpmGroup</code> with nested {@link SysPpmRules} that belongs together
	 * 
	 * @param ngroupKey The group key.
	 * @return List of <code>SysPpmGroup</code>.
	 */
	List<SysPpmGroup> findByIdNgroupKey(int ngroupKey);

	/**
	 * Finds all <code>SysPpmGroup</code> with nested {@link SysPpmRules} that are from the given topic
	 * 
	 * @param ctopic topic usually to get start, stop or continuous rules
	 * @return List of <code>SysPpmGroup</code>.
	 */
	List<SysPpmGroup> findBySysPpmRulesCtopic(String ctopic);
}
