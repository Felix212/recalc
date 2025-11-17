/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.savedrequest.NullRequestCache;

import com.lsgskychefs.cbase.middleware.base.business.CbaseMiddlewareConfigurationService;
import com.lsgskychefs.cbase.middleware.base.business.CbaseRole;

/**
 * Configuration class for Spring Security.
 * <ul>
 * <li>set own UserDetailsService to load user from database for authentication
 * <li>authentication rules
 * <li>session Management
 * <li>enable global method security (you can use @PreAuthorize)
 * </ul>
 *
 * @author Ingo Rietzschel - U125742
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Profile("security")
public class CbaseMiddlewareSecurityConfiguration extends WebSecurityConfigurerAdapter {

	/** REST_COMMON_SECURITY */
	private static final String REST_COMMON_SECURITY = "/rest/common/security";

	/** STRING */
	private static final String SECURITY_INVALID_SESSION = REST_COMMON_SECURITY + "/invalid-session";

	/** SECURITY_LOGIN */
	private static final String SECURITY_LOGIN = REST_COMMON_SECURITY + "/login";

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareSecurityConfiguration.class);

	/** CBASE-Middleware configuration property service */
	@Autowired
	private CbaseMiddlewareConfigurationService configService;

	/** log info */
	public CbaseMiddlewareSecurityConfiguration() {
		super();
		LOGGER.info("CbaseMiddlewareSecurityConfiguration is initialized.");
	}

	/** The service to load user by username for BasicAuthentication. */
	@Autowired
	private UserDetailsService userDetailsService;

	@Override
	protected void configure(final AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService);
	}

	@Override
	public void configure(final WebSecurity web) throws Exception {
		web
				.ignoring()
				.antMatchers(SECURITY_INVALID_SESSION);
	}

	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		http.authorizeRequests()
				.antMatchers(REST_COMMON_SECURITY + "/change-password").authenticated()
				.antMatchers(CbaseMiddlewareSecurityConfiguration.SECURITY_LOGIN, REST_COMMON_SECURITY + "/logged-out").permitAll()
				.antMatchers("/**/version").permitAll()
				.antMatchers("/**/sapuid").permitAll()
				// Swagger permission, only relevant if swagger profile activated
				.antMatchers("/v2/api-docs/**").permitAll()
				.antMatchers("/**").hasRole(CbaseRole.ROLE_PWD_NOT_EXPIRED)
				.anyRequest().authenticated()
				// do not create a session if user was not able to authenticate
				.and()
				.requestCache()
				.requestCache(new NullRequestCache());

		// logout configuration -> delete cookie and invalidate session
		http
				.logout()
				.logoutUrl(REST_COMMON_SECURITY + "/logout")
				.invalidateHttpSession(true)
				.deleteCookies(configService.getSessionCookieName())
				.logoutSuccessUrl(REST_COMMON_SECURITY + "/logged-out");

		// no csrf token needed for check-password/login
		http.csrf().ignoringAntMatchers(CbaseMiddlewareSecurityConfiguration.SECURITY_LOGIN);
		// Swagger permission, only relevant if swagger profile activated
		http.csrf().ignoringAntMatchers("/v2/api-docs/**");

		http.sessionManagement()
				.invalidSessionUrl(SECURITY_INVALID_SESSION)
				.sessionFixation()
				.migrateSession();
	}

}
