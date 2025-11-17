/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.interceptor.CustomizableTraceInterceptor;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

import com.lsgskychefs.cbase.middleware.base.logging.CbaseMiddlewareMethodeInterceptor;

/**
 * Configuration class for AOP
 *
 * @author Ingo Rietzschel - U125742
 */
@Configuration
@EnableAspectJAutoProxy
@Aspect
@ConditionalOnWebApplication
public class CbaseMiddlewareAopConfiguration {

	/** Pointcut for execution of methods on {@link Service} annotation */
	@Pointcut("execution(public * (@org.springframework.web.bind.annotation.RestController com.lsgskychefs.cbase.middleware..*).*(..))")
	public void controllerAnnotation() {
		// the pointcut signature
	}

	/** Pointcut for execution of methods on {@link Service} annotation */
	@Pointcut("execution(public * (@org.springframework.stereotype.Service com.lsgskychefs.cbase.middleware..*).*(..))")
	public void serviceAnnotation() {
		// the pointcut signature
	}

	/** Pointcut for execution of methods on {@link Repository} annotation */
	@Pointcut("execution(public * (@org.springframework.stereotype.Repository com.lsgskychefs.cbase.middleware..*).*(..))")
	public void repositoryAnnotation() {
		// the pointcut signature
	}

	/** aggregated pointcut */
	@Pointcut("serviceAnnotation() || repositoryAnnotation() || controllerAnnotation()")
	public void advancedLogging() {
		// aggregated pointcut signature
	}

	/**
	 * Initalize the {@link CustomizableTraceInterceptor}
	 *
	 * @return Interceptor
	 */
	@Bean
	public CustomizableTraceInterceptor customizableTraceInterceptor() {
		final CustomizableTraceInterceptor customizableTraceInterceptor = new CustomizableTraceInterceptor();
		customizableTraceInterceptor.setUseDynamicLogger(true);
		customizableTraceInterceptor.setEnterMessage("Entering $[methodName]($[arguments])");
		customizableTraceInterceptor.setExitMessage("Leaving  $[methodName](), returned $[returnValue], time $[invocationTime]");
		return customizableTraceInterceptor;
	}

	/**
	 * Initalize the CustomizableTraceInterceptor advisor.
	 *
	 * @return customize logger advisor
	 */
	@Bean
	public Advisor customizableTraceAdvisor() {
		final AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
		pointcut.setExpression("com.lsgskychefs.cbase.middleware.base.configuration.CbaseMiddlewareAopConfiguration.advancedLogging()");
		return new DefaultPointcutAdvisor(pointcut, customizableTraceInterceptor());
	}

	/**
	 * Initalize the {@link CbaseMiddlewareMethodeInterceptor}
	 *
	 * @return Interceptor
	 */
	@Bean
	public CbaseMiddlewareMethodeInterceptor cbaseMiddlewareInterceptor() {
		return new CbaseMiddlewareMethodeInterceptor();
	}

	/**
	 * Initalize the CbaseMiddlewareMethodeInterceptor advisor.
	 *
	 * @return customize logger advisor
	 */
	@Bean
	public Advisor cbaseMiddlewareInterceptorAdvisor() {
		final AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
		pointcut.setExpression(
				"com.lsgskychefs.cbase.middleware.base.configuration.CbaseMiddlewareAopConfiguration.controllerAnnotation()");
		return new DefaultPointcutAdvisor(pointcut, cbaseMiddlewareInterceptor());
	}

}
