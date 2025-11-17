/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmChMovement;

/**
 * Repository class for {@link CenOutPpmChMovement} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenOutPpmChMovementRepository extends PagingAndSortingRepository<CenOutPpmChMovement, Long> {

	/**
	 * Find history for warehouse
	 * 
	 * @param nwarehouseKey, warehouse key
	 * @return List of {@link CenOutPpmChMovement}
	 */
	List<CenOutPpmChMovement> findByNwarehouseKeyAndCreasonNotNullOrderByDtimestampDesc(long nwarehouseKey);

	/**
	 * Find by trolley key and movement type
	 * 
	 * @param nppmTrolleyKey, trolley key
	 * @param nstockMovementTypeKey, movement type key
	 * @return List of {@link CenOutPpmChMovement}
	 */
	List<CenOutPpmChMovement> findByNppmTrolleyKeyAndNstockMovementTypeKey(final Long nppmTrolleyKey, final Long nstockMovementTypeKey);
}
