/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChWarehouse;

/**
 * Repository class for {@link LocUnitChWarehouse} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitChWarehouseRepository extends PagingAndSortingRepository<LocUnitChWarehouse, Long> {

	/**
	 * Find warehouses by unit.
	 *
	 * @param cunit, the unit name
	 * @return List of {@link LocUnitChWarehouse}
	 */
	List<LocUnitChWarehouse> findBySysUnitsCunitOrderByCwarehouseAsc(final String cunit);

}
