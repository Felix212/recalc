/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioCategory;
import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioItem;

/**
 * Repository class for Portfolio Items.
 *
 * @author Paola Lera - U116198
 */
public interface PortfolioItemRepository extends PagingAndSortingRepository<PortfolioItem, Long> {

	/**
	 * Find all Portfolio Items for a specific category
	 * 
	 * @param portfolioCategory the category where the items are part of
	 * @return list of {@link PortfolioItem}
	 */
	List<PortfolioItem> findByPortfolioCategory(final PortfolioCategory portfolioCategory);

	/**
	 * Find all Portfolio Items for a specific category filtered by a list of portfolioValues
	 * 
	 * @param portfolioCategory the category where the items are part of
	 * @param portfolioValues the values that the items are going to be filtered
	 * @return list of {@link PortfolioItem}
	 */
	List<PortfolioItem> findDistinctByPortfolioCategoryAndPortfolioValuesNidIn(final PortfolioCategory portfolioCategory,
			final List<Long> portfolioValues);

}
