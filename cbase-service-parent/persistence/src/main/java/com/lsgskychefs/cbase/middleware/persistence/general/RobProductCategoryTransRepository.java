/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobProductCategoryTrans;

/**
 * Repository class for {@link RobProductCategoryTrans} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobProductCategoryTransRepository extends PagingAndSortingRepository<RobProductCategoryTrans, Long> {
	/**
	 * Find first translation.
	 * 
	 * @param nlanguage
	 * @param nproductCategoryKey
	 * @return the entity of {@link RobProductCategoryTrans}
	 */
	RobProductCategoryTrans findFirstByRobLanguageNlanguageAndRobProductCategoryNproductCategoryKey(Integer nlanguage,
			long nproductCategoryKey);
}
