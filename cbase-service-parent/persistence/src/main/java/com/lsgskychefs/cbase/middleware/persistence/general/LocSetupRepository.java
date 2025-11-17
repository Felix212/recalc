/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;

/**
 * Repository class for {@link LocSetup} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface LocSetupRepository extends PagingAndSortingRepository<LocSetup, LocSetupId> {

	/**
	 * Get user settings for given section.
	 * 
	 * @param login current user
	 * @param csection relevant section
	 * @return user settings for given section
	 */
	List<LocSetup> findBySysLoginAndIdCsection(SysLogin login, String csection);
}
