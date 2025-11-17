/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioAttribute;
import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioItem;
import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioValue;

/**
 * Repository class for Portfolio Items.
 *
 * @author Alex Schaab - U524036
 */
public interface PortfolioAttributeRepository extends PagingAndSortingRepository<PortfolioAttribute, Long> {

	/**
	 * Finds the {@link PortfolioAttribute} for a give PortfolioValue nid
	 * 
	 * @param nid the id of {@link PortfolioValue} that sould be part of the Attribute
	 * @return list of {@link PortfolioItem}
	 */
	PortfolioAttribute findByportfolioValuesNid(final Long nid);

}
