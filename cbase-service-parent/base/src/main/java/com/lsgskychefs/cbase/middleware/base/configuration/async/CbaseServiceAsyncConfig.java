/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.async;

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseService;

/**
 * @author Dirk Bunk - U200035
 */
@Configuration
@EnableAsync
@ConditionalOnBean(AbstractCbaseService.class)
public class CbaseServiceAsyncConfig implements AsyncConfigurer {
	@Value("${cbase.service.async.thread.core.pool.size:1}")
	private int corePoolSize;

	@Value("${cbase.service.async.thread.max.pool.size:100}")
	private int maxPoolSize;

	@Override
	public Executor getAsyncExecutor() {
		final ThreadPoolTaskExecutor asyncExecutor = new ThreadPoolTaskExecutor();

		// queue is set to 0, because otherwise the queue would be filled first before
		// increasing the thread count above the core pool size
		asyncExecutor.setQueueCapacity(0);
		asyncExecutor.setCorePoolSize(corePoolSize);
		asyncExecutor.setMaxPoolSize(maxPoolSize);
		asyncExecutor.setAwaitTerminationSeconds(60);
		asyncExecutor.setThreadNamePrefix("AsyncTask-");
		asyncExecutor.setWaitForTasksToCompleteOnShutdown(true);
		asyncExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
		asyncExecutor.initialize();

		return asyncExecutor;
	}

	@Primary
	@Bean("defaultAsyncExecutor")
	public Executor defaultAsyncExecutor() {
		return getAsyncExecutor();
	}

	@Bean("cenRequestInThreadPool")
	public Executor cenRequestInThreadPool() {
		final ThreadPoolTaskExecutor asyncExecutor = (ThreadPoolTaskExecutor) getAsyncExecutor();
		if (asyncExecutor != null) {
			asyncExecutor.setThreadNamePrefix("AsyncReqIn-");
		}
		return asyncExecutor;
	}

	@Bean("cenRequestOutThreadPool")
	public Executor cenRequestOutThreadPool() {
		final ThreadPoolTaskExecutor asyncExecutor = (ThreadPoolTaskExecutor) getAsyncExecutor();
		if (asyncExecutor != null) {
			asyncExecutor.setThreadNamePrefix("AsyncReqOut-");
		}
		return asyncExecutor;
	}

	@Override
	public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
		return null;
	}
}
