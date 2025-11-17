/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysEuRegions;

/**
 * Repository class for {@link SysEuRegions} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysEuRegionsRepository extends PagingAndSortingRepository<SysEuRegions, Long> {

	/**
	 * Find the region by cregion or {@code null}.
	 *
	 * @param cregion the cregion
	 * @return the {@link SysEuRegions} or {@code null}
	 */
	SysEuRegions findByCregion(String cregion);
}
