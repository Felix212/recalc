/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutChStock;

/**
 * Repository class for {@link CenOutChStock} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenOutChStockRepository extends PagingAndSortingRepository<CenOutChStock, Long> {

	/**
	 * Find stock by warehouse
	 * 
	 * @param plSearchText, packinglist search text
	 * @param descSearchText, description search text
	 * @param nppmProdLabelKey, prod label key
	 * @param nppmTrolleyKey, trolley key
	 * @param nwarehouseKey, warehouse key
	 * @return List of {@link CenOutChStock}
	 */
	List<CenOutChStock>
			findByCpackinglistIgnoreCaseContainingOrCtextIgnoreCaseContainingOrNppmProdLabelKeyOrNppmTrolleyKeyAndLocUnitChWarehouseNwarehouseKey(
					final String plSearchText, final String descSearchText, final Long nppmProdLabelKey, final Long nppmTrolleyKey,
					final Long nwarehouseKey);

	/**
	 * Find stock for prod label key
	 * 
	 * @param nwarehouseKey, warehouse key
	 * @param nppmProdLabelKey, prod label key
	 * @return {@link CenOutChStock}
	 */
	CenOutChStock findByNppmProdLabelKey(final Long nppmProdLabelKey);

	/**
	 * Remove stock for prod label key
	 * 
	 * @param nppmProdLabelKey, prod label key
	 */
	void deleteByNppmProdLabelKey(final Long nppmProdLabelKey);

	/**
	 * Find Stock for storage bin
	 * 
	 * @param storageBinKey, storage bin key
	 * @return List of {@link CenOutChStock}
	 */
	List<CenOutChStock> findByLocUnitChStorageBinNstorageBinKey(final Long storageBinKey);

	/**
	 * Find stock by trolley key
	 * 
	 * @param nppmTrolleyKey, trolley key
	 * @return List of {@link CenOutChStock}
	 */
	List<CenOutChStock> findByNppmTrolleyKey(final Long nppmTrolleyKey);

	/**
	 * Remove stock for trolley key
	 * 
	 * @param nppmTrolleyKey, trolley key
	 */
	void deleteByNppmTrolleyKey(final Long nppmTrolleyKey);

}
