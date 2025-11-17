/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import org.springframework.stereotype.Service;

/**
 * For management functionality.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class ManagementService extends AbstractCbaseMiddlewareService {

	/**
	 * Get the count of spring jdbc session.
	 *
	 * @return the count of spring jdbc session.
	 */
	public int getActiveJdbcSessions() {
		return cbaseMiddlewareRepository.getActiveJdbcSessions();
	}
}
