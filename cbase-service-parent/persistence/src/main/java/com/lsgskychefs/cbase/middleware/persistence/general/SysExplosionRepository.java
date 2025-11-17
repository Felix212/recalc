/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysExplosion;

/**
 * Repository class for {@link SysExplosion} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface SysExplosionRepository extends PagingAndSortingRepository<SysExplosion, Long> {
	/**
	 * Find all explosion entries with a specific process status
	 * 
	 * @param nprocessStatus the process status to look for
	 * @return List of {@link SysExplosion}
	 */
	List<SysExplosion> findByNprocessStatus(final int nprocessStatus);

	/**
	 * Find all explosion entries with a specific result key
	 * 
	 * @param nresultKey the result key to look for
	 * @return List of {@link SysExplosion}
	 */
	List<SysExplosion> findByNresultKey(final long nresultKey);
}
