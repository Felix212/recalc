/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCoBatchcode;

/**
 * @author Dirk Bunk - U200035
 */
public interface CenOutPpmCoBatchcodeRepository extends PagingAndSortingRepository<CenOutPpmCoBatchcode, Long> {

	/**
	 * Find CenOutPpmCoWeight by CenOutPpm-Object.
	 *
	 * @param cenOutPpmCo the CenOutPpm-Object
	 * @return List of CenOutPpmCoWeight Entries
	 */
	List<CenOutPpmCoBatchcode> findByCenOutPpmCo(CenOutPpmCo cenOutPpmCo);

}
