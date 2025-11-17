/*
 * Copyright (c) 2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.base.configuration.async;

import java.util.concurrent.Executor;

import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * Configuration classes for CbaseMiddleware application JMX Monitoring.
 *
 * @author Alex Schaab - U524036
 */
@Configuration
@ConditionalOnWebApplication
@EnableAsync
public class CbaseMiddlewareAsyncConfig {

	/**
	 * @return
	 */
	@Bean(name = "fdrTaskExecutor")
	public Executor threadPoolTaskExecutor() {
		final ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
		threadPoolTaskExecutor.setCorePoolSize(5);
		threadPoolTaskExecutor.setMaxPoolSize(10);
		return threadPoolTaskExecutor;
	}

}
