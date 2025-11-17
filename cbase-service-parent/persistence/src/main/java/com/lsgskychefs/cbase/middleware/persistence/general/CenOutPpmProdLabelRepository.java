/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmProdLabel;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTrolley;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenOutPpmProdLabelRepository extends PagingAndSortingRepository<CenOutPpmProdLabel, Long> {

	/**
	 * Liste der Prod-Labels für eine BatchSeq
	 * 
	 * @param nbatchSeq the batch seq
	 * @return list of {@link CenOutPpmProdLabel}
	 */
	List<CenOutPpmProdLabel> findByNbatchSeqOrderByNlabelCount(Long nbatchSeq);

	/**
	 * Liste der Prod-Labels für einen TrolleyKey
	 * 
	 * @param nppmTrolleyKey
	 * @return
	 */
	List<CenOutPpmProdLabel> findByCenOutPpmTrolleyNppmTrolleyKeyOrderByNlabelCount(Long nppmTrolleyKey);

	/**
	 * All Prod Labels inside a Trolley
	 * 
	 * @param trolleys list of trolleys
	 * @return list of {@link CenOutPpmProdLabel}
	 */
	List<CenOutPpmProdLabel> findByCenOutPpmTrolleyIn(List<CenOutPpmTrolley> trolleys);

	/**
	 * If you want to find all OVEN FlightLabels that belong together.
	 * 
	 * @param nppmProdLabelKeyMaster each record knows its master prodLabelKey
	 * @return list of {@link CenOutPpmProdLabel}
	 */
	List<CenOutPpmProdLabel> findByNppmProdLabelKeyMasterOrderByNlabelCount(Long nppmProdLabelKeyMaster);

}
