/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobEventProduct;
import com.lsgskychefs.cbase.middleware.persistence.domain.RobEventProductId;

/**
 * Repository class for {@link RobEventProduct} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobEventProductRepository extends PagingAndSortingRepository<RobEventProduct, RobEventProductId> {
	/**
	 * Find all by event key.
	 * 
	 * @param neventKey
	 * @return the list of {@link RobEventProduct}
	 */
	List<RobEventProduct> findAllByRobEventNeventKey(long neventKey);

	/**
	 * Deletes all entries for a specific event key.
	 * 
	 * @param neventKey
	 */
	void deleteByRobEventNeventKey(long neventKey);
}
