/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

/**
 * @author Dirk Bunk - U200035
 */
public class SapOdataLogin {
	private final String username;

	private final String cookie;

	private final String token;

	/**
	 * Constructor
	 * 
	 * @param username
	 * @param cookie
	 * @param token
	 */
	public SapOdataLogin(final String username, final String cookie, final String token) {
		this.username = username;
		this.cookie = cookie;
		this.token = token;
	}

	/**
	 * Get username
	 *
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * Get cookie
	 *
	 * @return the cookie
	 */
	public String getCookie() {
		return cookie;
	}

	/**
	 * Get token
	 *
	 * @return the token
	 */
	public String getToken() {
		return token;
	}
}
