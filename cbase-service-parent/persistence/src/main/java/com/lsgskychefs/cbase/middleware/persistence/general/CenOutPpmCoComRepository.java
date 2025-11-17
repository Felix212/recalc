/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCo;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCoCom;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface CenOutPpmCoComRepository extends PagingAndSortingRepository<CenOutPpmCoCom, Long> {

	/**
	 * Find <link>CenOutPpmCoCom</link> by <link>CenOutPpmCo</link> object.
	 *
	 * @param cenOutPpmCo the <link>CenOutPpmCo</link> object
	 * @return List of <link>CenOutPpmCoCom</link> Entries
	 */
	List<CenOutPpmCoCom> findByCenOutPpmCo(CenOutPpmCo cenOutPpmCo);

}
