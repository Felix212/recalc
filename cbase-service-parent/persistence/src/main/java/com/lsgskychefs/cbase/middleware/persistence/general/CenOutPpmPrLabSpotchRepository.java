/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmPrLabSpotch;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmProdLabel;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutPpmPrLabSpotchRepository extends PagingAndSortingRepository<CenOutPpmPrLabSpotch, Long> {

	/**
	 * Get a List of SpotChecks
	 * 
	 * @param cenOutPpmProdLabel the ProdLabel to find
	 * @return List of {@link CenOutPpmPrLabSpotch}
	 */
	List<CenOutPpmPrLabSpotch> findByCenOutPpmProdLabel(CenOutPpmProdLabel cenOutPpmProdLabel);

	/**
	 * Get a List of SpotChecks for one Content of an Oven
	 * 
	 * @param nppmProdLabelKey the ovens prodLabelKey
	 * @param nplIndexKey the packinglist index key
	 * @param nclassNumber the packinglist class number
	 * @return List of {@link CenOutPpmPrLabSpotch}
	 */
	List<CenOutPpmPrLabSpotch> findByCenOutPpmProdLabelNppmProdLabelKeyAndNplIndexKeyAndNclassNumber(final Long nppmProdLabelKey,
			final Long nplIndexKey, final Long nclassNumber);

}
