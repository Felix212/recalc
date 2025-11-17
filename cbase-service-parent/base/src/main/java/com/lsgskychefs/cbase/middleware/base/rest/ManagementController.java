/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.business.ManagementService;

/**
 * Management controller for special CBASE methods.
 *
 * @author Ingo Rietzschel - U125742
 */
@RestController
@RequestMapping("/management")
public class ManagementController {

	/** service for managemenet functionality */
	@Autowired
	private ManagementService managementService;

	/** CBASE-Middleware configuration property service */
	@Autowired
	private CbaseMiddlewareConfigurationService configService;

	/**
	 * Get the count of spring jdbc session or -1 if spring jdbc session not active.
	 *
	 * @return the count of spring jdbc session or -1 if spring jdbc session not active.
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/active-jdbc-sessions")
	public int getActiveJdbcSessions() {
		if (configService.isActivatedJdbcSession()) {
			return managementService.getActiveJdbcSessions();
		}
		return -1;
	}

}
