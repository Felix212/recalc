/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error.exception;

/**
 * The Login status for user account.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum LoginStatus {
	/** Username/Password is unknown. (PowerBuilder: -1, -4) */
	USER_PASSWORD_UNKNOWN,
	/** Account is locked (PowerBuilder: -2) */
	ACCOUNT_LOCKED,
	/** User has role "Disallow WEB Login" */
	DISALLOW_WEB_LOGIN,
	/** Password expired (PowerBuilder: 2) */
	PASSWORD_EXPIRED,
	/** user is authorized (PowerBuilder 1) */
	USER_AUTHORIZED,
	/** user is logged out */
	LOGGED_OUT,
	/** user role missing */
	MISSING_ROLE
}
