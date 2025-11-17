/*
 * LocUnitAreasRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysSlsKeywordGroup;

/**
 * Repository class.
 *
 * @author Andreas Morgenstern
 */
public interface SysSlsKeywordGroupRepository extends PagingAndSortingRepository<SysSlsKeywordGroup, Long> {

	/**
	 * Find all SysSlsKeywordGroup.
	 *
	 * @return List of SysSlsKeywordGroup Entries
	 */
	List<SysSlsKeywordGroup> findAllByOrderByNgroupsortAsc();

}
