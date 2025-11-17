package com.lsgskychefs.cbase.middleware.citp.config;

//@Configuration
//@EnableAsync
public class AsyncConfiguration {

//	private static final Logger LOGGER = LoggerFactory.getLogger(AsyncConfiguration.class);
//
//	private AppVariablesCustomProperties appVariablesCustomProperties;
//
//	@Autowired
//	public void setAppVariablesCustomProperties(final AppVariablesCustomProperties appVariablesCustomProperties) {
//		this.appVariablesCustomProperties = appVariablesCustomProperties;
//	}
//
//	@Bean
//	@Qualifier("customThreadPoolTaskExecutor")
//	public TaskExecutor threadPoolTaskExecutor() {
//
//		final ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
//		executor.setCorePoolSize(appVariablesCustomProperties.getCorePoolSize());
//		executor.setMaxPoolSize(appVariablesCustomProperties.getMaxPoolSize());
//		executor.setQueueCapacity(appVariablesCustomProperties.getQueueCapacity());
//		executor.setThreadNamePrefix("citp_thread");
//		executor.initialize();
////        executor.setAwaitTerminationSeconds(Integer.MAX_VALUE);
////        executor.setWaitForTasksToCompleteOnShutdown(true);
//		return executor;
//	}
}
