/*
 * AbstractCbaseMiddlewareApplication.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.lsgskychefs.cbase.middleware.base.configuration.logging.CbaseMiddlewareStartConfigurationLogger;

/**
 * Central abstract class for the CBASE Middleware application components containing both general application and web configuration as well
 * as a <code>startApplication</code> method that has to be called by the main methods of classes inheriting this class to bootstrap the
 * application component using Spring Boot.
 *
 * @see SpringApplication
 * @author Andreas Morgenstern
 * @author Dirk Bunk
 */
@SpringBootApplication
@EnableTransactionManagement(proxyTargetClass = true)
@EnableAsync
@EnableScheduling
@PropertySource("classpath:base.properties")
public abstract class AbstractCbaseMiddlewareApplication extends SpringBootServletInitializer {
	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(AbstractCbaseMiddlewareApplication.class);

	/** SECURITY */
	private static final String SECURITY = "security";

	/**
	 * Bootstraps the application, when started in standalone mode
	 *
	 * @param args The arguments passed to the application
	 */
	public static void startApplication(final String... args) {
		startApplication(true, args);
	}

	/**
	 * Bootstraps the application, when started in standalone mode
	 * 
	 * @param isWebEnvironment Indicates if the application should start in an web environment or not
	 * @param args The arguments passed to the application
	 */
	public static void startApplication(final boolean isWebEnvironment, final String... args) {
		final SpringApplication springApp = new SpringApplication(AbstractCbaseMiddlewareApplication.class);

		if (isWebEnvironment) {
			LOGGER.info("STARTED AS WEB APPLICATION");
			springApp.addListeners(new CbaseMiddlewareStartConfigurationLogger());
			springApp.setAdditionalProfiles(AbstractCbaseMiddlewareApplication.SECURITY);
			springApp.setWebApplicationType(WebApplicationType.SERVLET);
		} else {
			LOGGER.info("STARTED AS SERVICE");
			springApp.setWebApplicationType(WebApplicationType.NONE);
		}

		springApp.run(args);
	}

	/**
	 * Configure the application when started from within a Servlet 3 container
	 *
	 * @see "org.springframework.boot.context.web.SpringBootServletInitializer#configure(org.springframework.boot.builder.SpringApplicationBuilder"
	 */
	@Override
	protected SpringApplicationBuilder configure(final SpringApplicationBuilder builder) {
		return builder.profiles(AbstractCbaseMiddlewareApplication.SECURITY)
				.sources(AbstractCbaseMiddlewareApplication.class);
	}
}
