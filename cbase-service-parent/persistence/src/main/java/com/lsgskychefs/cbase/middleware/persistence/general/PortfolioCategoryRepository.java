/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioCategory;

/**
 * Repository class for Portfolio Categories.
 *
 * @author Paola Lera - U116198
 */
public interface PortfolioCategoryRepository extends PagingAndSortingRepository<PortfolioCategory, Long> {

	/**
	 * Find all Portfolio Categories as a tree
	 * 
	 * @return list of {@link PortfolioCategory}
	 */
	List<PortfolioCategory> findByPortfolioCategoryIsNull();

	/**
	 * Find all Portfolio Categories for a specific category as a tree
	 * 
	 * @param categoryId the id of the category
	 * @return list of {@link PortfolioCategory}
	 */
	List<PortfolioCategory> findByNid(final long categoryId);

}
