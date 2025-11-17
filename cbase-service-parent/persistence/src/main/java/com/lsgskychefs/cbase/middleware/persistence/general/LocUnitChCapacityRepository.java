/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChCapacity;

/**
 * Repository class for {@link LocUnitChCapacity} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitChCapacityRepository extends PagingAndSortingRepository<LocUnitChCapacity, Long> {

	/**
	 * Find storage bins for warehouse
	 * 
	 * @param nwarehouseKey, the chosen warehouse key
	 * @return List of {@link LocUnitChCapacity}
	 */
	List<LocUnitChCapacity> findByLocUnitChWarehouseNwarehouseKey(final Long nwarehouseKey);
}
