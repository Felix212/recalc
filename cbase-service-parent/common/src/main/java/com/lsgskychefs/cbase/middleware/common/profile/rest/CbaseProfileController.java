/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.profile.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.rest.AbstractCbaseMiddlewareController;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseCollection;
import com.lsgskychefs.cbase.middleware.common.profile.business.ProfileService;
import com.lsgskychefs.cbase.middleware.common.rest.CommonInterfaceRoot;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAppSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppGridConfig;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppGridConfig_;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUnitSetting;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppUserSetting;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * This class provides a REST interface for interacting with the {@link ProfileService}.
 *
 * @author Ingo Rietzschel - U125742
 */
@RestController
@RequestMapping(CommonInterfaceRoot.COMMON_API_ROOT)
public class CbaseProfileController extends AbstractCbaseMiddlewareController {

	/** The {@link ProfileService} that interacts with the underlying database repositories */
	@Autowired
	private ProfileService profileService;

	/**
	 * Get the value for current user profile and given section and key.
	 *
	 * @param csection section of user profile
	 * @param ckey key to get the value
	 * @param defaultValue the default value, is returned if no value is found - is optional
	 * @return the value for current user profile and given section and key or default value
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.PROFILE_VALUE)
	public String getProfileValue(
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam(required = false) final String defaultValue) {
		final String profileValue = profileService.getProfileValue(csection, ckey);
		return StringUtils.isBlank(profileValue) ? defaultValue : profileValue;
	}

	/**
	 * Set the value for current user profile and given section and key.
	 *
	 * @param csection section of user profile
	 * @param ckey key to set the value
	 * @param cvalue the value to set
	 */
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.PROFILE_VALUE)
	public void setProfileValue(
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam final String cvalue) {
		profileService.setProfileValue(csection, ckey, cvalue);
	}

	/**
	 * Get the value for given unit profile and given section and key.
	 *
	 * @param cunit company for which the value is to be read.
	 * @param csection section of unit profile
	 * @param ckey key to get the value
	 * @param defaultValue the default value, is returned if no value is found - is optional
	 * @return the value for given unit profile and given section and key or default value
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.UNIT_PROFILE_VALUE)
	public String getUnitProfileValue(
			@PathVariable final String cunit,
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam(required = false) final String defaultValue) {
		final String profileValue = profileService.getUnitProfileValue(cunit, csection, ckey);
		return StringUtils.isBlank(profileValue) ? defaultValue : profileValue;
	}

	/**
	 * Set the value for given unit profile and given section and key.
	 *
	 * @param cunit company for which the value is to be write
	 * @param csection section of unit profile
	 * @param ckey key to set the value
	 * @param cvalue the value to set
	 */
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.UNIT_PROFILE_VALUE)
	public void setUnitProfileValue(
			@PathVariable final String cunit,
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam final String cvalue) {
		profileService.setUnitProfileValue(cunit, csection, ckey, cvalue);
	}

	/**
	 * Get the value for current client profile and given section and key.
	 *
	 * @param csection section of client profile
	 * @param ckey key to get the value
	 * @param defaultValue the default value, is returned if no value is found - is optional
	 * @return the value for current client profile and given section and key or default value
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.CLIENT_PROFILE_VALUE)
	public String getClientProfileValue(
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam(required = false) final String defaultValue) {
		final String profileValue = profileService.getClientProfileValue(csection, ckey);
		return StringUtils.isBlank(profileValue) ? defaultValue : profileValue;
	}

	/**
	 * Set the value for current client profile and given section and key.
	 *
	 * @param csection section of client profile
	 * @param ckey key to set the value
	 * @param cvalue the value to set
	 */
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.CLIENT_PROFILE_VALUE)
	public void setClientProfileValue(
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam final String cvalue) {
		profileService.setClientProfileValue(csection, ckey, cvalue);
	}

	/**
	 * Get the value for an app and given section and key.
	 * 
	 * @param capp the app name
	 * @param csection section of client profile
	 * @param ckey key to get the value
	 * @param defaultValue the default value, is returned if no value is found - is optional
	 * @return the value for current client profile and given section and key or default value
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_PROFILE_VALUE)
	public String getAppProfileValue(
			@PathVariable final String capp,
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam(required = false) final String defaultValue) {
		final CenAppSetup profileValue = profileService.getAppProfileValue(capp, csection, ckey);
		if (profileValue == null) {
			return defaultValue;
		} else {
			return StringUtils.isBlank(profileValue.getCvalue()) ? defaultValue : profileValue.getCvalue();
		}
	}

	/**
	 * Set the value for an app and given section and key.
	 * 
	 * @param capp the app name
	 * @param csection section of client profile
	 * @param ckey to set the value
	 * @param cvalue the value to set
	 */
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.APP_PROFILE_VALUE)
	public void setAppProfileValue(
			@PathVariable final String capp,
			@RequestParam final String csection,
			@RequestParam final String ckey,
			@RequestParam final String cvalue) {
		profileService.setAppProfileValue(capp, csection, ckey, cvalue);
	}

	/**
	 * Get the config for a specific app and grid and profile name
	 * 
	 * @param capp
	 * @param cgrid
	 * @param cprofile
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType.NOT_FOUND - Profile not found!
	 *             </ul>
	 * @return
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_GRID_SETUP_CONFIG)
	public Map<String, Object> getAppGridSetupConfig(
			@RequestParam final String capp,
			@RequestParam final String cgrid,
			@PathVariable final String cprofile) throws CbaseMiddlewareBusinessException {
		final JacksonJsonParser jacksonJsonParser = new JacksonJsonParser();
		final String setupConfig = profileService.getAppGridSetupConfig(capp, cgrid, cprofile);

		if (setupConfig == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.NOT_FOUND, "Profile not found!");
		} else {
			return jacksonJsonParser.parseMap(setupConfig);
		}
	}

	/**
	 * Get the Profiles of a given App and Grid.
	 *
	 * @param capp the app name
	 * @param cgrid the grid name
	 * @return the json of the app, grid, profiles and configs
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_GRID_SETUP)
	public ResponseCollection getAppGridSetup(
			@RequestParam final String capp,
			@RequestParam final String cgrid) {
		final List<SysAppGridConfig> sysAppGridConfigs = profileService.getAppGridSetup(capp, cgrid);
		final ResponseCollection result = new ResponseCollection();

		for (final SysAppGridConfig sysAppGridConfig : sysAppGridConfigs) {
			result.creatAndAdd().put(sysAppGridConfig,
					SysAppGridConfig_.ngridKey,
					SysAppGridConfig_.capp,
					SysAppGridConfig_.cgrid,
					SysAppGridConfig_.cprofile);
		}

		return result;
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
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.APP_GRID_SETUP)
	public Long setAppGridSetup(@RequestParam final String capp,
			@RequestParam final String cgrid,
			@RequestParam final String cprofile,
			@RequestParam final String bconfig) throws CbaseMiddlewareBusinessException {

		return profileService.setAppGridSetup(capp, cgrid, cprofile, bconfig);
	}

	/**
	 * Load App settings like localstorage key values for the current user.
	 * 
	 * @param appRole each app has its own setting
	 * @return {@link SysAppUserSetting}
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             </ul>
	 */
	@ApiOperation(value = "load app setting", notes = "Load App settings like localstorage key values for the current user", code = 200)
	@ApiResponses(value = {
			@ApiResponse(code = 409, message = "if the app role is not registered!")
	})
	@JsonView(View.Simple.class)
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_USER_SETTING)
	public SysAppUserSetting getAppUserSetting(@RequestParam final String appRole) throws CbaseMiddlewareBusinessException {

		return profileService.getAppUserSetting(appRole);
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
	@ApiOperation(value = "save app settings for a user", notes = "App settings like localstorage key values can be stored here for a list of users", code = 200)
	@ApiResponses(value = {
			@ApiResponse(code = 409, message = "if the app role is not registered!"),
			@ApiResponse(code = 404, message = "if the app role could not be found on DB!"),
			@ApiResponse(code = 404, message = "if one of the provided users could not be found!")
	})
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.APP_USER_SETTING)
	public void setAppUserSetting(
			@RequestParam final String appRole,
			@RequestParam final String csetting,
			@RequestParam final Long... nuserIds) throws CbaseMiddlewareBusinessException {

		profileService.setAppUserSetting(appRole, csetting, nuserIds);
	}

	/**
	 * Load app settings like active features for a given unit.
	 * 
	 * @param appRole each app has its own setting
	 * @param cunit unit to retrieve the settings for
	 * @return {@link SysAppUnitSetting}
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             </ul>
	 */
	@ApiOperation(value = "load app settings", notes = "Load app settings like active features for a given unit", code = 200)
	@ApiResponses(value = {
			@ApiResponse(code = 409, message = "if the app role is not registered!"),
			@ApiResponse(code = 404, message = "if the provided unit could not be found!")
	})
	@JsonView(View.Simple.class)
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_UNIT_SETTING)
	public SysAppUnitSetting getAppUnitSetting(
			@ApiParam(value = "app role to identify the correct app settings") @RequestParam final String appRole,
			@ApiParam(value = "unit to retrieve the settings for") @RequestParam final String cunit)
			throws CbaseMiddlewareBusinessException {

		return profileService.getAppUnitSetting(appRole, cunit);
	}

	/**
	 * Save app settings like active features for a given unit.
	 * 
	 * @param appRole each app has its own setting
	 * @param cunit unit to set the settings for
	 * @param csetting settings object in JSON format
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             <li>CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID - if the app role could not be found.
	 *             <li>CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID - if one of the provided users could not be found.
	 *             </ul>
	 */
	@ApiOperation(value = "save app settings", notes = "Save app settings like active features for a given unit", code = 200)
	@ApiResponses(value = {
			@ApiResponse(code = 409, message = "if the app role is not registered!"),
			@ApiResponse(code = 404, message = "if the app role could not be found on DB!"),
			@ApiResponse(code = 404, message = "if the provided unit could not be found!")
	})
	@RequestMapping(method = RequestMethod.POST, path = CommonInterfaceRoot.APP_UNIT_SETTING)
	public void setAppUnitSetting(
			@ApiParam(value = "app role to identify the correct app settings") @RequestParam final String appRole,
			@ApiParam(value = "unit to set the settings for") @RequestParam final String cunit,
			@ApiParam(value = "settings object in JSON format") @RequestParam final String csetting)
			throws CbaseMiddlewareBusinessException {

		profileService.setAppUnitSetting(appRole, csetting, cunit);
	}

	/**
	 * Get all setup values for one specific app and section
	 * 
	 * @param capp the app name to get the setup values for
	 * @param csection the section to look for
	 * @return
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.APP_SETUP_VALUES)
	public Map<String, String> getAppSetupValues(
			@PathVariable final String capp,
			@RequestParam final String csection) {
		final Map<String, String> setupValues = new HashMap<>();

		for (final CenAppSetup appSetupValue : profileService.getAppSetupValues(capp, csection)) {
			setupValues.put(appSetupValue.getId().getCkey(), appSetupValue.getCvalue());
		}

		return setupValues;
	}
}
