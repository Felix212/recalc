/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.lsgskychefs.cbase.middleware.base.error.exception.LoginStatus;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;

/**
 * Extended User class for CbaseMiddlerware data.
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */
public class CbaseMiddlewareUser extends User {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** the detached login entity of current user. */
	private final SysLogin login;

	/** The login Status of current user. */
	private LoginStatus loginStatus;

	/** The Agent of current user. */
	private final String userAgent;

	/** The IP of current user */
	private final String userIp;

	/** The RemoteHost of current user */
	private final String remoteHost;

	/** The SAP Odata Login (if user is a SAP user) */
	private transient SapOdataLogin sapLogin;

	/**
	 * Create a user
	 *
	 * @param authorities the GrantedAuthorities
	 * @param login the detached {@link SysLogin} of current user
	 * @param password user password
	 * @param loginStatus current user login status
	 * @param userAgent current user agent
	 * @param userIp current user IP
	 * @param remoteHost current user remote host
	 */
	public CbaseMiddlewareUser(final Collection<? extends GrantedAuthority> authorities, final SysLogin login, final String password,
			final LoginStatus loginStatus, final String userAgent, final String userIp, final String remoteHost) {
		super(login.getCusername(), password, authorities);
		this.login = login;
		this.loginStatus = loginStatus;
		this.userAgent = userAgent;
		this.userIp = userIp;
		this.remoteHost = remoteHost;
	}

	/**
	 * Get the detached {@link SysLogin} of current user
	 *
	 * @return the detached {@link SysLogin}
	 */
	public SysLogin getLogin() {
		return login;
	}

	/**
	 * Get loginStatus
	 *
	 * @return the loginStatus
	 */
	public LoginStatus getLoginStatus() {
		return loginStatus;
	}

	/**
	 * set loginStatus
	 *
	 * @param loginStatus the loginStatus to set
	 */
	public void setLoginStatus(final LoginStatus loginStatus) {
		this.loginStatus = loginStatus;
	}

	/**
	 * Get userAgent
	 *
	 * @return the userAgent
	 */
	public String getUserAgent() {
		return this.userAgent;
	}

	/**
	 * Get userIp
	 *
	 * @return the userIp
	 */
	public String getUserIp() {
		return this.userIp;
	}

	/**
	 * Get remoteHost
	 *
	 * @return the remoteHost
	 */
	public String getRemoteHost() {
		return this.remoteHost;
	}

	/**
	 * Get sapLogin
	 *
	 * @return the sapLogin
	 */
	public SapOdataLogin getSapLogin() {
		return sapLogin;
	}

	/**
	 * set sapLogin
	 *
	 * @param sapLogin the sapLogin to set
	 */
	public void setSapLogin(final SapOdataLogin sapLogin) {
		this.sapLogin = sapLogin;
	}

	/**
	 * Returns a boolean indicating whether the authenticated user is included in the specified logical "role". If the user has not been
	 * authenticated, the method returns false.
	 *
	 * @param role the role to check
	 * @return {@code true} if the user has the given role
	 * @see prefered method is HttpServletRequest#isUserInRole(String)
	 */
	public boolean hasRole(final String role) {
		final String roleWithPrefix = CbaseRole.roleWithPrefix(role);
		for (final GrantedAuthority authority : getAuthorities()) {
			if (authority.getAuthority().equals(roleWithPrefix)) {
				return true;
			}
		}
		return false;
	}

}
