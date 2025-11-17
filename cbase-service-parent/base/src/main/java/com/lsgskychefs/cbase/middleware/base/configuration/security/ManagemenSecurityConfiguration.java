/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;

/**
 * Configuration class for Spring Security - for management services (like Spring Actuator).
 *
 * @author Andreas Morgenstern
 */
@Configuration
@Profile("security")
@Order(1)
public class ManagemenSecurityConfiguration extends WebSecurityConfigurerAdapter {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(ManagemenSecurityConfiguration.class);

	/** the context path for management services */
	@Value("${management.context-path:/management}")
	private String managementContextPath;

	/** the context path for management services */
	@Value("${cbase-middleware.management.user.name:nagios}")
	private String user;

	/** the context path for management services */
	@Value("${cbase-middleware.management.user.password:Xtra4LSG}")
	private String pwd;

	/** log info */
	public ManagemenSecurityConfiguration() {
		super();
		LOGGER.info("ManagemenSecurityConfiguration is initialized.");
	}

	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		// use http basic authentication for management services (username and password is defined in base.properties)
		http.antMatcher("/**" + managementContextPath + "/**").authorizeRequests().anyRequest().authenticated()
				.and().httpBasic().realmName("Management");

		// no csrf token needed
		http.csrf().disable();
		// no http session needed
		http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
	}

	@Override
	protected void configure(final AuthenticationManagerBuilder auth) throws Exception {
		auth.inMemoryAuthentication().withUser(user).password(pwd).roles("USER");
	}

}
