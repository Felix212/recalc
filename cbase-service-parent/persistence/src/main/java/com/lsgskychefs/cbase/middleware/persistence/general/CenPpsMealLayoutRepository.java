/*
 * CenPpsMealLayoutRepository.java
 *
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenPpsContainer;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPpsMealLayout;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface CenPpsMealLayoutRepository extends PagingAndSortingRepository<CenPpsMealLayout, Long> {

	/**
	 * Finds all <code>CenPpsMealLayout</code> by its CenPpsContainer attribute.
	 *
	 * @param cenPpsContainer The cenPpsContainer attribute.
	 * @return The matching <code>CenPpsMealLayout</code> or null.
	 */
	List<CenPpsMealLayout> findByCenPpsContainer(CenPpsContainer cenPpsContainer);

}
