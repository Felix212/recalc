/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.profile.business;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.business.CbaseRole;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAppSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAppSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppGridConfig;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUnitSetting;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUserSetting;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRoles;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.general.CenAppSetupRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysAppGridConfigRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysAppUnitSettingRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysAppUserSettingRepository;

/**
 * Service class to get settings .
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class ProfileService extends AbstractCbaseMiddlewareService {
	/** The repository for {@link SysAppGridConfig} entity. */
	@Autowired
	private SysAppGridConfigRepository sysAppGridConfigRepository;

	/** The repository for {@link SysAppUserSetting} entity. */
	@Autowired
	private SysAppUserSettingRepository sysAppUserSettingRepository;

	/** The repository for {@link SysAppUnitSettingRepository} entity. */
	@Autowired
	private SysAppUnitSettingRepository sysAppUnitSettingRepository;

	@Autowired
	private CenAppSetupRepository cenAppSetupRepository;

	/**
	 * Get the value for current user profile and given section and key.
	 *
	 * @param csection section of user profile
	 * @param ckey key to get the value
	 * @return the value for current user profile and given section and key or null if no value exist
	 */
	public String getProfileValue(final String csection, final String ckey) {
		final long nuserId = getLoginUser().getLogin().getNuserId();
		final LocSetup locSetup = cbaseMiddlewareRepository.findOne(LocSetup.class, new LocSetupId(nuserId, csection, ckey));
		if (locSetup != null) {
			return locSetup.getCvalue();
		}
		return null;
	}

	/**
	 * Set the value for current user profile and given section and key.
	 *
	 * @param csection section of user profile
	 * @param ckey key to get the value
	 * @param cvalue the value for current user profile and given section and key
	 */
	public void setProfileValue(final String csection, final String ckey, final String cvalue) {
		SysLogin sysLogin = getLoginUser().getLogin();
		final long nuserId = sysLogin.getNuserId();
		final LocSetupId pk = new LocSetupId(nuserId, csection, ckey);
		LocSetup locSetup = cbaseMiddlewareRepository.findOne(LocSetup.class, pk);
		// not exist -> create new entry
		if (locSetup == null) {
			locSetup = new LocSetup();
			locSetup.setId(pk);
			// syslogin on context is detached
			sysLogin = cbaseMiddlewareRepository.findOne(SysLogin.class, sysLogin.getNuserId());
			locSetup.setSysLogin(sysLogin);
		}
		// update value
		locSetup.setCvalue(cvalue);
		save(locSetup);
	}

	/**
	 * Get the value for given unit profile and given section and key.
	 *
	 * @param cunit company for which the value is to be read.
	 * @param csection section of unit profile
	 * @param ckey key to get the value
	 * @return the value for given unit profile and given section and key or null if no value exist
	 */
	public String getUnitProfileValue(final String cunit, final String csection, final String ckey) {
		final LocUnitSetup locUnitSetup = cbaseMiddlewareRepository.findOne(LocUnitSetup.class, new LocUnitSetupId(cunit, csection, ckey));
		if (locUnitSetup != null) {
			return locUnitSetup.getCvalue();
		}
		return null;
	}

	/**
	 * Get the value for given unit profile and given section and key, Returns cdefault, if section/key is not set.
	 * 
	 * @param cunit
	 * @param csection
	 * @param ckey
	 * @param cdefault
	 * @return
	 */
	public String getUnitProfileValue(final String cunit, final String csection, final String ckey, final String cdefault) {
		final LocUnitSetup locUnitSetup = cbaseMiddlewareRepository.findOne(LocUnitSetup.class, new LocUnitSetupId(cunit, csection, ckey));
		if (locUnitSetup != null) {
			return locUnitSetup.getCvalue();
		}
		return cdefault;
	}

	/**
	 * Set the value for given unit profile and given section and key.
	 *
	 * @param cunit company for which the value is to be write
	 * @param csection section of unit profile
	 * @param ckey key to set the value
	 * @param cvalue the value to set
	 */
	public void setUnitProfileValue(final String cunit, final String csection, final String ckey, final String cvalue) {
		final LocUnitSetupId pk = new LocUnitSetupId(cunit, csection, ckey);
		LocUnitSetup locUnitSetup = cbaseMiddlewareRepository.findOne(LocUnitSetup.class, pk);
		// not exist -> create new entry
		if (locUnitSetup == null) {
			locUnitSetup = new LocUnitSetup();
			locUnitSetup.setId(pk);
		}
		// update value
		locUnitSetup.setCvalue(cvalue);
		save(locUnitSetup);
	}

	/**
	 * Get the value for current client profile and given section and key.
	 *
	 * @param csection section of client profile
	 * @param ckey key to get the value
	 * @return the value for current client profile and given section and key or null if no value exist
	 */
	public String getClientProfileValue(final String csection, final String ckey) {
		final CenSetup cenSetup = cbaseMiddlewareRepository.findOne(CenSetup.class, new CenSetupId(getClient(), csection, ckey));
		if (cenSetup != null) {
			return cenSetup.getCvalue();
		}
		return null;
	}

	/**
	 * Set the value for current client profile and given section and key.
	 *
	 * @param csection section of client profile
	 * @param ckey key to set the value
	 * @param cvalue the value to set
	 */
	public void setClientProfileValue(final String csection, final String ckey, final String cvalue) {
		final CenSetupId pk = new CenSetupId(getClient(), csection, ckey);
		CenSetup cenSetup = cbaseMiddlewareRepository.findOne(CenSetup.class, pk);

		// not exist -> create new entry
		if (cenSetup == null) {
			cenSetup = new CenSetup();
			cenSetup.setId(pk);
		}
		// update value
		cenSetup.setCvalue(cvalue);
		save(cenSetup);
	}

	/**
	 * Get the Profiles and Configs of a given App and Grid.
	 *
	 * @param capp the app name
	 * @param cgrid the grid name
	 * @return the list of SysAppGridConfig
	 */
	public List<SysAppGridConfig> getAppGridSetup(final String capp, final String cgrid) {
		return sysAppGridConfigRepository.findByCappAndCgridOrderByCprofileAsc(capp, cgrid);
	}

	/**
	 * Get the config for a specific app and grid and profile name
	 * 
	 * @param capp
	 * @param cgrid
	 * @param cprofile
	 * @return
	 */
	public String getAppGridSetupConfig(final String capp, final String cgrid, final String cprofile) {
		final List<SysAppGridConfig> sysAppGridConfigs = sysAppGridConfigRepository.findByCappAndCgridAndCprofile(capp, cgrid, cprofile);

		for (final SysAppGridConfig sysAppGridConfig : sysAppGridConfigs) {
			return new String(sysAppGridConfig.getBconfig(), StandardCharsets.UTF_8);
		}

		return null;
	}

	/**
	 * Save the Config of a Grid in an app.
	 *
	 * @param capp the app name
	 * @param cgrid the grid name
	 * @param cprofile the profile name
	 * @param bconfig the parameter of the grid
	 * @return the key of the entry
	 */
	public Long setAppGridSetup(final String capp, final String cgrid, final String cprofile, final String bconfig)
			throws CbaseMiddlewareBusinessException {
		SysAppGridConfig sysAppGridConfig;

		final List<SysAppGridConfig> sysAppGridConfigs = sysAppGridConfigRepository.findByCappAndCgridAndCprofile(capp, cgrid, cprofile);

		if (sysAppGridConfigs.isEmpty()) {
			sysAppGridConfig = new SysAppGridConfig();
		} else {
			sysAppGridConfig = sysAppGridConfigs.get(0);
		}

		sysAppGridConfig.setCapp(capp);
		sysAppGridConfig.setCgrid(cgrid);
		sysAppGridConfig.setCprofile(cprofile);
		sysAppGridConfig.setBconfig(bconfig.getBytes(StandardCharsets.UTF_8));

		save(sysAppGridConfig);
		return sysAppGridConfig.getNgridKey();
	}

	/**
	 * App setting like localstorage key values can be loaded here for the current user.
	 * 
	 * @param appRole each app has its own setting
	 * @return {@link SysAppUserSetting}
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             </ul>
	 */
	public SysAppUserSetting getAppUserSetting(final String appRole) throws CbaseMiddlewareBusinessException {
		final SysLogin sysLogin = getLoginUser().getLogin();
		final int roleId = getRoleIdFromAppRole(appRole);

		return sysAppUserSettingRepository.findBySysLoginNuserIdAndSysRolesNroleId(sysLogin.getNuserId(), roleId);
	}

	/**
	 * App settings like localstorage key values can be stored here for a list of users.
	 * 
	 * @param appRole each app has its own setting
	 * @param csetting the setting value, usually a JSON String
	 * @param nuserIds list of userIds
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             <li>CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID - if the app role could not be found.
	 *             <li>CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID - if one of the provided users could not be found.
	 *             </ul>
	 */
	public void setAppUserSetting(final String appRole, final String csetting, final Long... nuserIds)
			throws CbaseMiddlewareBusinessException {
		final int roleId = getRoleIdFromAppRole(appRole);
		final SysRoles sysRole = findOne(SysRoles.class, roleId);

		for (final Long nuserId : nuserIds) {

			final SysLogin sysLogin = findOne(SysLogin.class, nuserId);

			SysAppUserSetting appUserSetting =
					sysAppUserSettingRepository.findBySysLoginNuserIdAndSysRolesNroleId(nuserId, roleId);

			if (appUserSetting == null) {
				appUserSetting = new SysAppUserSetting();
			}

			appUserSetting.setSysRoles(sysRole);
			appUserSetting.setSysLogin(sysLogin);
			appUserSetting.setCsetting(csetting);

			save(appUserSetting);
		}
	}

	/**
	 * App setting like feature selection can be loaded here for a specific unit.
	 * 
	 * @param appRole each app has its own setting
	 * @param cunit the unit to load the settings for
	 * @return {@link SysAppUnitSetting} entity
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             </ul>
	 */
	public SysAppUnitSetting getAppUnitSetting(final String appRole, final String cunit) throws CbaseMiddlewareBusinessException {
		final int roleId = getRoleIdFromAppRole(appRole);
		return sysAppUnitSettingRepository.findBySysUnitsCunitAndSysRolesNroleId(cunit, roleId);
	}

	/**
	 * App settings like feature selection can be stored here for a specific unit.
	 * 
	 * @param appRole each app has its own setting
	 * @param csetting the setting value, usually a JSON String
	 * @param cunit the unit to store the settings for
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             <li>CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID - if the app role could not be found.
	 *             </ul>
	 */
	public void setAppUnitSetting(final String appRole, final String csetting, final String cunit)
			throws CbaseMiddlewareBusinessException {
		final int roleId = getRoleIdFromAppRole(appRole);
		final SysRoles sysRole = findOne(SysRoles.class, roleId);
		final SysUnits sysUnit = findOne(SysUnits.class, cunit);

		SysAppUnitSetting appUnitSetting =
				sysAppUnitSettingRepository.findBySysUnitsCunitAndSysRolesNroleId(cunit, roleId);

		if (appUnitSetting == null) {
			appUnitSetting = new SysAppUnitSetting();
		}

		appUnitSetting.setSysRoles(sysRole);
		appUnitSetting.setSysUnits(sysUnit);
		appUnitSetting.setCsetting(csetting);

		save(appUnitSetting);
	}

	/**
	 * Gets the ID for one specific app role name
	 * 
	 * @param appRole
	 * @return
	 * @throws CbaseMiddlewareBusinessException
	 */
	private int getRoleIdFromAppRole(final String appRole) throws CbaseMiddlewareBusinessException {
		final CbaseRole cbaseRole = CbaseRole.getByStringOrId(appRole);
		if (cbaseRole == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"The specified role is unknown");
		}

		return cbaseRole.getRoleId();
	}

	/**
	 * Gets a config value for one app and section
	 * 
	 * @param capp
	 * @param csection
	 * @param ckey
	 * @return
	 */
	public CenAppSetup getAppProfileValue(final String capp, final String csection, final String ckey) {
		return cenAppSetupRepository.findById(new CenAppSetupId(capp, csection, ckey));
	}

	/**
	 * Sets a config value for one app and section
	 * 
	 * @param capp
	 * @param csection
	 * @param ckey
	 * @param cvalue
	 */
	public void setAppProfileValue(final String capp, final String csection, final String ckey, final String cvalue) {
		final CenAppSetupId pk = new CenAppSetupId(capp, csection, ckey);
		CenAppSetup cenAppSetup = cbaseMiddlewareRepository.findOne(CenAppSetup.class, pk);
		// not exist -> create new entry
		if (cenAppSetup == null) {
			cenAppSetup = new CenAppSetup();
			cenAppSetup.setId(pk);
		}
		// update value
		cenAppSetup.setCvalue(cvalue);
		save(cenAppSetup);
	}

	/**
	 * Get all setup values for one specific app and section
	 * 
	 * @param capp the app name to get the setup values for
	 * @param csection the section to look for
	 * @return
	 */
	public List<CenAppSetup> getAppSetupValues(final String capp, final String csection) {
		return cenAppSetupRepository.findAllByIdCappAndIdCsection(capp, csection);
	}
}
