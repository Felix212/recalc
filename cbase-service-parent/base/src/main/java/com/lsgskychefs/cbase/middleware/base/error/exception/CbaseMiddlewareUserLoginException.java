/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error.exception;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Exception class for the reason why the user login failed. The ResponseStatus is HttpStatus.UNAUTHORIZED(401).
 *
 * @author Ingo Rietzschel - U125742
 */
@ResponseStatus(code = HttpStatus.UNAUTHORIZED)
public class CbaseMiddlewareUserLoginException extends UsernameNotFoundException {

	/** serial version uid */
	private static final long serialVersionUID = 1L;

	/** Login status for user account */
	private final LoginStatus loginStatus;

	/**
	 * Constructs a {@code CBaseMiddlewareUsernameNotFoundException} with the specified {@link LoginStatus}
	 *
	 * @param loginStatus the login status information
	 */
	public CbaseMiddlewareUserLoginException(final LoginStatus loginStatus) {
		super(loginStatus.name());
		this.loginStatus = loginStatus;
	}

	/**
	 * Constructs a {@code CBaseMiddlewareUsernameNotFoundException} with the specified {@link LoginStatus} and message
	 *
	 * @param loginStatus the login status information
	 * @param msg the detail message.
	 */
	public CbaseMiddlewareUserLoginException(final LoginStatus loginStatus, final String msg) {
		super(loginStatus.name() + " - " + msg);
		this.loginStatus = loginStatus;
	}

	/**
	 * Constructs a {@code CBaseMiddlewareUsernameNotFoundException} with the specified {@link LoginStatus} and root cause
	 *
	 * @param loginStatus the login status information
	 * @param cause root cause
	 */
	public CbaseMiddlewareUserLoginException(final LoginStatus loginStatus, final Throwable cause) {
		super(loginStatus.name(), cause);
		this.loginStatus = loginStatus;
	}

	/**
	 * Constructs a {@code CBaseMiddlewareUsernameNotFoundException} with the specified {@link LoginStatus} and message and root cause
	 *
	 * @param loginStatus the login status information
	 * @param msg the detail message
	 * @param cause root cause
	 */
	public CbaseMiddlewareUserLoginException(final LoginStatus loginStatus, final String msg, final Throwable cause) {
		super(loginStatus.name() + " - " + msg, cause);
		this.loginStatus = loginStatus;
	}

	/**
	 * Get the Login status information.
	 *
	 * @return the login status information
	 */
	public LoginStatus getLoginStatus() {
		return loginStatus;
	}
}
