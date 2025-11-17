/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUserSetting;

/**
 * Repository class.
 *
 * @author Alex Schaab - U524036
 */
public interface SysAppUserSettingRepository extends PagingAndSortingRepository<SysAppUserSetting, Long> {

	/**
	 * Provides the setting for an APP and USER
	 * 
	 * @param nuserId the user id
	 * @param nroleId the role id for an app
	 * @return {@link SysAppUserSetting}
	 */
	SysAppUserSetting findBySysLoginNuserIdAndSysRolesNroleId(final long nuserId, final int nroleId);
}
