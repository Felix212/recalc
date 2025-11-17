/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUnitSetting;

/**
 * Repository class.
 * 
 * @author Dirk Bunk - U200035
 */
public interface SysAppUnitSettingRepository extends PagingAndSortingRepository<SysAppUnitSetting, Long> {
	/**
	 * Provides the setting for an APP and UNIT
	 * 
	 * @param cunit the unit
	 * @param nroleId the role id for an app
	 * @return {@link SysAppUnitSetting}
	 */
	SysAppUnitSetting findBySysUnitsCunitAndSysRolesNroleId(final String cunit, final int nroleId);
}
