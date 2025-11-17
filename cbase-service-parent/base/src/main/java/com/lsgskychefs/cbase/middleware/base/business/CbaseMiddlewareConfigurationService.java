/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * Service for CBASE-Middleware configuration properties. This class encapsulate the configuration properties, so the injected properties
 * not scattered over the complete project. Variation of this rule are special properties. Only used on one/special place like native
 * queries, tomcat properties, session properties, report properties.
 *
 * @author Ingo Rietzschel - U125742
 */
@Service
public class CbaseMiddlewareConfigurationService {

	/** current mandant/client */
	@Value("${cbase.middleware.client}")
	private String client;

	/** relevant supplier */
	@Value("${cbase.middleware.supplier}")
	private Long supplier;

	/** Version number/information for CbaseMiddleware */
	@Value("${application.version}")
	private String version;

	/** name of current application */
	@Value("${application.name}")
	private String applicationName;

	/** Tomcat jvmRoute property value for use of sticky session */
	@Value("${server.tomcat.jvmroute}")
	private String jvmRoute;

	/** configuration for spring jdbc session */
	@Value("${spring.session.store-type:none}")
	private String storeType;

	/** configuration for spring session cookie name */
	@Value("${server.session.cookie.name}")
	private String sessionCookieName;

	/**
	 * Get client
	 *
	 * @return the client
	 */
	public String getClient() {
		return client;
	}

	/**
	 * Get supplier
	 *
	 * @return the supplier
	 */
	public Long getSupplier() {
		return supplier;
	}

	/**
	 * Get version
	 *
	 * @return the version
	 */
	public String getVersion() {
		return version;
	}

	/**
	 * Get jvmRoute
	 *
	 * @return the jvmRoute
	 */
	public String getJvmRoute() {
		return jvmRoute;
	}

	/**
	 * Get applicationName
	 *
	 * @return the applicationName
	 */
	public String getApplicationName() {
		return applicationName;
	}

	/**
	 * Is JdbcSession activated
	 *
	 * @return {@code true} is JdbcSession activated, otherwise {@code false}
	 */
	public boolean isActivatedJdbcSession() {
		return "JDBC".equalsIgnoreCase(storeType);
	}

	/**
	 * Get sessionCookieName
	 *
	 * @return the sessionCookieName
	 */
	public String getSessionCookieName() {
		return sessionCookieName;
	}

}
