/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmProdLabelPdf;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmProdLabelPdfId;

/**
 * Repository class.
 *
 * @author Alex Schaab - U524036
 */
public interface CenOutPpmProdLabelPdfRepository extends PagingAndSortingRepository<CenOutPpmProdLabelPdf, CenOutPpmProdLabelPdfId> {

	/**
	 * Get all existing prodLabel2
	 * 
	 * @param nbatchSeq the batch seq
	 * @return list of {@link CenOutPpmProdLabelPdf}
	 */
	List<CenOutPpmProdLabelPdf> findByIdNbatchSeq(Long nbatchSeq);

}
