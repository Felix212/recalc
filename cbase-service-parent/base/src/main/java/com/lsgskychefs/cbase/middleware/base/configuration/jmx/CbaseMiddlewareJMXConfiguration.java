/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.jmx;

import javax.management.MalformedObjectNameException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Profile;
import org.springframework.jmx.support.ConnectorServerFactoryBean;
import org.springframework.remoting.rmi.RmiRegistryFactoryBean;

/**
 * The Class CbaseMiddlewareJMXConfiguration.
 */
@Configuration
@Profile("jmx")
public class CbaseMiddlewareJMXConfiguration {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareJMXConfiguration.class);

	/** The rmi host. */
	@Value("${jmx.rmi.host:localhost}")
	private String rmiHost;

	/** The rmi port. */
	@Value("${jmx.rmi.port:8483}")
	private Integer rmiPort;

	/**
	 * Rmi registry.
	 *
	 * @return the rmi registry factory bean
	 */
	@Bean
	public RmiRegistryFactoryBean rmiRegistry() {
		final RmiRegistryFactoryBean rmiRegistryFactoryBean = new RmiRegistryFactoryBean();
		rmiRegistryFactoryBean.setPort(rmiPort);
		rmiRegistryFactoryBean.setAlwaysCreate(true);
		LOGGER.info("JMX remote support enabled on - {}: {}", rmiHost, rmiPort);
		return rmiRegistryFactoryBean;
	}

	/**
	 * Connector server factory bean.
	 *
	 * @return the connector server factory bean
	 * @throws MalformedObjectNameException
	 * @throws Exception the exception
	 */
	@Bean
	@DependsOn("rmiRegistry")
	public ConnectorServerFactoryBean connectorServerFactoryBean() throws MalformedObjectNameException {
		final ConnectorServerFactoryBean connectorServerFactoryBean = new ConnectorServerFactoryBean();
		connectorServerFactoryBean.setObjectName("connector:name=rmi");
		connectorServerFactoryBean
				.setServiceUrl(String.format("service:jmx:rmi://%s:%s/jndi/rmi://%s:%s/jmxrmi", rmiHost, rmiPort, rmiHost, rmiPort));
		return connectorServerFactoryBean;
	}

}
