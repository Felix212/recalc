/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChZone;

/**
 * Repository class for {@link LocUnitChZone} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitChZoneRepository extends PagingAndSortingRepository<LocUnitChZone, Long> {

	/**
	 * Find zone by warehouse key
	 * 
	 * @param nwarehouseKey, the chosen warehouse
	 * @return {@link LocUnitChZone}
	 * @throws CbaseMiddlewareBusinessException
	 */
	List<LocUnitChZone> findByLocUnitChWarehouseNwarehouseKey(final Long nwarehouseKey);

}
