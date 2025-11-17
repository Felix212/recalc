/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCoWeight;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutPpmCoWeightRepository extends PagingAndSortingRepository<CenOutPpmCoWeight, Long> {

	/**
	 * Find CenOutPpmCoWeight by CenOutPpm-Object.
	 *
	 * @param cenOutPpmCo the CenOutPpm-Object
	 * @return List of CenOutPpmCoWeight Entries
	 */
	List<CenOutPpmCoWeight> findByCenOutPpmCo(CenOutPpmCo cenOutPpmCo);

}
