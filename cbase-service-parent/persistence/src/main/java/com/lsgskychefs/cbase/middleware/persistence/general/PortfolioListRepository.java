/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioList;

/**
 * Repository class for Portfolio List.
 *
 * @author Paola Lera - U116198
 */
public interface PortfolioListRepository extends PagingAndSortingRepository<PortfolioList, Long> {

	/**
	 * 
	 * @param userId, the id of the user to filter Lists, makes sense for the Auth user
	 * @return list of {@link PortfolioList}
	 */
	List<PortfolioList> findByPortfolioUserNidOrderByCname(final Long userId);

}
