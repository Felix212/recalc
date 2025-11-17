/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenDiagramLayout;

/**
 * Repository class for {@link CenDiagramLayout} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenDiagramLayoutRepository extends PagingAndSortingRepository<CenDiagramLayout, Long> {

	/**
	 * Find diagram layouts by nairlineKey and nweblayout
	 * 
	 * @param nairlineKey, airline key
	 * @param nweblayout, web layout
	 * @return List of {@link CenDiagramLayout}
	 */
	List<CenDiagramLayout> findByCenAirlinesNairlineKeyAndNweblayoutOrderByClayoutNameAsc(final Long nairlineKey, final int nweblayout);
}
