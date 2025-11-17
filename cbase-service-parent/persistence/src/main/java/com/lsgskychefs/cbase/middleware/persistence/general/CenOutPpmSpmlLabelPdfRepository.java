/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmSpmlLabelPdf;

/**
 * @author Xhon Vrushi - U185182
 */
public interface CenOutPpmSpmlLabelPdfRepository extends PagingAndSortingRepository<CenOutPpmSpmlLabelPdf, Long> {

	CenOutPpmSpmlLabelPdf findFirstByNbatchSeq(Long nbatchSeq);

	List<CenOutPpmSpmlLabelPdf> findByNbatchSeq(Long nbatchSeq);
}
