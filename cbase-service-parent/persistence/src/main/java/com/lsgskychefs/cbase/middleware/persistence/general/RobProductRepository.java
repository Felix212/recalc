/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobProduct;

/**
 * Repository class for {@link RobProduct} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobProductRepository extends PagingAndSortingRepository<RobProduct, Long> {
	/**
	 * Find all.
	 *
	 * @return the list of {@link RobProduct}
	 */
	List<RobProduct> findAll();

	/**
	 * Finds all products for a specific event.
	 * 
	 * @param neventKey the event key to search for
	 * @return the list of {@link RobProduct}
	 */
	List<RobProduct> findAllByRobEventProductsRobEventNeventKeyOrderByRobEventProductsNsortAsc(long neventKey);
}
