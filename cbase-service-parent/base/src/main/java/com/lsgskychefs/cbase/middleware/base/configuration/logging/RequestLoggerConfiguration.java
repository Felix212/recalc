/*
 * RequestLoggerConfiguration.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.logging;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.lsgskychefs.cbase.middleware.base.error.CbaseMiddlewareErrorAttributes;
import com.lsgskychefs.cbase.middleware.base.rest.RequestLoggerHandlerInterceptorAdapter;

/**
 * This <code>WebMvcConfigurerAdapter</code> configuration adds a {@link RequestLoggerHandlerInterceptorAdapter} to the interceptor registry
 * for all requests but error path requests.
 *
 * @author Andreas Morgenstern
 */
@Configuration
@ConditionalOnWebApplication
public class RequestLoggerConfiguration extends WebMvcConfigurerAdapter {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(RequestLoggerConfiguration.class);

	/**
	 * The error path url.
	 */
	@Value("${error.path:/error}")
	private String errorPath;

	/** for counter */
	@Autowired
	private RequestLoggerHandlerInterceptorAdapter requestLoggerHandlerInterceptorAdapter;

	/** log info */
	public RequestLoggerConfiguration() {
		super();
		RequestLoggerConfiguration.LOGGER.info("RequestLoggerConfiguration is initialized.");
	}

	@Override
	public void addInterceptors(final InterceptorRegistry registry) {
		registry.addInterceptor(requestLoggerHandlerInterceptorAdapter).excludePathPatterns(errorPath + "/**");
	}

	/**
	 * Configure the default CbaseMiddleware exception handler.
	 *
	 * @return the default CbaseMiddleware exception handler.
	 */
	@Bean
	public CbaseMiddlewareErrorAttributes createExceptionHandlerExceptionResolver() {
		return new CbaseMiddlewareErrorAttributes();
	}
}
