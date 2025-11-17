/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChStorageBin;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChWarehouse;

/**
 * Repository class for {@link LocUnitChWarehouse} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitChStorageBinRepository extends PagingAndSortingRepository<LocUnitChStorageBin, Long> {

	/**
	 * Find storage location for capacity and type
	 * 
	 * @param ncapacityKey, capacity key
	 * @param nequipmentKey, equipment type key
	 * @return List of {@link LocUnitChStorageBin}
	 */
	List<LocUnitChStorageBin> findByLocUnitChCapacityNcapacityKeyAndNequipmentKey(final Long ncapacityKey,
			final Long nequipmentKey);

	/**
	 * Find storage bins for warehouse
	 * 
	 * @param nwarehouseKey, warehouse key
	 * @return List of {@link LocUnitChStorageBin}
	 */
	List<LocUnitChStorageBin> findByLocUnitChCapacityLocUnitChWarehouseNwarehouseKey(final Long nwarehouseKey);

}
