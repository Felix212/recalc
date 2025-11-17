/*
 * CbaseMiddlewareStartConfigurationLogger.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.logging;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.PropertiesPropertySource;
import org.springframework.core.env.PropertySource;

/**
 * This <code>ApplicationListener</code> implementation logs all system properties and Spring environment properties to the log right before
 * the application services are made public. Thus it listens on Spring Boot's <code>ApplicationReadyEvent</code>.
 *
 * @author U200025
 */
public class CbaseMiddlewareStartConfigurationLogger implements ApplicationListener<ApplicationEvent> {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareStartConfigurationLogger.class);

	@Override
	public void onApplicationEvent(final ApplicationEvent event) {
		if (event instanceof ApplicationReadyEvent) {
			// display the values
			logConfigurationProperties((ApplicationReadyEvent) event);
		}
	}

	/**
	 * Print the system properties and the spring environment properties to the logger
	 *
	 * @param event the <code>ApplicationReadyEvent</code> thrown by Spring on the end of the startup phase
	 */
	private void logConfigurationProperties(final ApplicationReadyEvent event) {
		if (LOGGER.isDebugEnabled()) {
			// log all system properties
			final Properties properties = System.getProperties();
			@SuppressWarnings({ "rawtypes", "unchecked" })
			final List<String> keyList = new ArrayList(properties.keySet());
			Collections.sort(keyList);
			for (final String key : keyList) {
				final String value = (String) properties.get(key);
				LOGGER.debug("System Property - {}: {}", key, value);
			}

			// log all spring environment properties
			for (final Iterator<PropertySource<?>> it = event.getApplicationContext().getEnvironment().getPropertySources().iterator(); it
					.hasNext();) {
				final PropertySource<?> propertySource = it.next();
				if (propertySource instanceof PropertiesPropertySource) {
					final PropertiesPropertySource p = (PropertiesPropertySource) propertySource;
					final List<String> names = Arrays.asList(p.getPropertyNames());
					Collections.sort(names);
					for (final String name : names) {
						LOGGER.debug("Spring Environment Property - {}: {}", name, p.getProperty(name));
					}
				}
			}
		}
	}

}
