/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmPrLabDetail;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenOutPpmPrLabDetailRepository extends PagingAndSortingRepository<CenOutPpmPrLabDetail, Long> {
	/**
	 * Returns the Quantity to be produced for the whole Batch
	 *
	 * @param nbatchSeq Batch sequence number
	 * @return Quantity to be produced
	 */
	@Query("SELECT SUM(p.nquantity) FROM CenOutPpmPrLabDetail p WHERE p.cenOutPpmProdLabel.nbatchSeq = :batchSeq")
	BigDecimal getLabelQuantityByNbatchSeq(@Param("batchSeq") Long nbatchSeq);

	/**
	 * Returns the Quantity to be produced for on prod label
	 *
	 * @param nppmProdLabelKey the key of the prod label
	 * @return Quantity to be produced
	 */
	@Query("SELECT SUM(p.nquantity) FROM CenOutPpmPrLabDetail p WHERE p.cenOutPpmProdLabel.nppmProdLabelKey = :nppmProdLabelKey")
	BigDecimal getLabelQuantityByNppmProdLabelKey(@Param("nppmProdLabelKey") Long nppmProdLabelKey);

	/**
	 * Find prod label detail by nppmProdLabelKey
	 * 
	 * @param nppmProdLabelKey, label key
	 * @return {@link CenOutPpmPrLabDetail}
	 */
	List<CenOutPpmPrLabDetail> findByCenOutPpmProdLabelNppmProdLabelKey(final Long nppmProdLabelKey);

}
