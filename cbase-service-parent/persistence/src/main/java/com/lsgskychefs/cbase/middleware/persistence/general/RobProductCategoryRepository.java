/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobProductCategory;

/**
 * Repository class for {@link RobProductCategory} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobProductCategoryRepository extends PagingAndSortingRepository<RobProductCategory, Long> {
	/**
	 * Find all order by nsort asc.
	 *
	 * @return the list of {@link RobProductCategory}
	 */
	List<RobProductCategory> findAllByOrderByNsortAsc();
}
