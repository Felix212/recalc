/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobProductTrans;

/**
 * Repository class for {@link RobProductTrans} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobProductTransRepository extends PagingAndSortingRepository<RobProductTrans, Long> {
	/**
	 * Find first translation.
	 * 
	 * @param nlanguage
	 * @param nproductKey
	 * @return the list of {@link RobProductTrans}
	 */
	RobProductTrans findFirstByRobLanguageNlanguageAndRobProductNproductKey(Integer nlanguage,
			long nproductKey);
}
