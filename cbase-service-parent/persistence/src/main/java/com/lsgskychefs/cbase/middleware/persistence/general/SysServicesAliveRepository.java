/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysServicesAlive;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysServicesAliveId;

/**
 * Repository class for {@link SysServicesAlive} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface SysServicesAliveRepository extends PagingAndSortingRepository<SysServicesAlive, SysServicesAliveId> {
	/**
	 * Find all service alive entries for a specific service and master id
	 * 
	 * @param cservice
	 * @param nmaster
	 * @return List of {@link SysServicesAlive}
	 */
	List<SysServicesAlive> findByIdCserviceAndNmaster(final String cservice, final int nmaster);
}
