/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChRule;

/**
 * Repository class for {@link LocUnitChRule} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitChRuleRepository extends PagingAndSortingRepository<LocUnitChRule, Long> {

	/**
	 * Find rules for packinglist
	 * 
	 * @param npackinglistIndexKey, packinglist key
	 * @return List of {@link LocUnitChRule}
	 */
	List<LocUnitChRule> findByNpackinglistIndexKey(final Long npackinglistIndexKey);
}
