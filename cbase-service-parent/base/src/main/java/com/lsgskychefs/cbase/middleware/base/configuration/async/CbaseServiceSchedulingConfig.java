/*
 * Copyright (c) 2015-2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.async;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseService;

/**
 * @author Dirk Bunk - U200035
 */
@Configuration
@EnableScheduling
@ConditionalOnBean(AbstractCbaseService.class)
public class CbaseServiceSchedulingConfig implements SchedulingConfigurer {
	@Value("${cbase.service.scheduler.thread.pool.size:1}")
	private int poolSize;

	@Override
	public void configureTasks(final ScheduledTaskRegistrar taskRegistrar) {
		taskRegistrar.setScheduler(taskScheduler());
	}

	private TaskScheduler taskScheduler() {
		final ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();

		scheduler.setPoolSize(poolSize);
		scheduler.setAwaitTerminationSeconds(60);
		scheduler.setThreadNamePrefix("ScheduledTask-");
		scheduler.setWaitForTasksToCompleteOnShutdown(true);
		scheduler.initialize();

		return scheduler;
	}
}
