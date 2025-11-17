package com.lsgskychefs.cbase.middleware.citp.config;

import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.aop.target.CommonsPool2TargetSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.lsgskychefs.cbase.middleware.citp.services.amadeus.AmadeusService;

@Configuration
public class CustomPoolConfig {

	@Value("${cbase.service.async.thread.max.pool.size:10}")
	protected int maxPoolSize;

	// The targetBeanName is mandatory for CommonsPool2TargetSource. Rather use a
	// constant to avoid mistakes.
	private static final String TARGET_NAME = "amadeusServiceTarget";

	@Bean
	public CommonsPool2TargetSource AmadeusPooledTargetSource() {
		final CommonsPool2TargetSource poolingConfig = new CommonsPool2TargetSource();
		poolingConfig.setTargetBeanName(TARGET_NAME);
		poolingConfig.setTargetClass(AmadeusService.class);
		poolingConfig.setMaxSize(maxPoolSize);
		poolingConfig.setMaxIdle(maxPoolSize);
		return poolingConfig;
	}

	@Bean
	@Autowired
	public ProxyFactoryBean AmadeusProxyFactoryBean(final CommonsPool2TargetSource amadeusPooledTargetSource) {
		final ProxyFactoryBean proxyFactoryBean = new ProxyFactoryBean();
		proxyFactoryBean.setTargetSource(amadeusPooledTargetSource);
		return proxyFactoryBean;
	}

	@Bean
	@Autowired
	public AmadeusService amadeusService(final ProxyFactoryBean amadeusProxyFactoryBean) {
		return (AmadeusService) amadeusProxyFactoryBean.getObject();
	}

}
