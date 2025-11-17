/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.logging;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.aop.interceptor.CustomizableTraceInterceptor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseCollection;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement;

/**
 * Interceptor to log special Parameter and return values. Is supplement the {@link CustomizableTraceInterceptor}.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareMethodeInterceptor implements MethodInterceptor {

	@Override
	public Object invoke(final MethodInvocation invocation) throws Throwable {
		final String name = invocation.getMethod().getDeclaringClass().getName() + "." + invocation.getMethod().getName();
		final Log log = getLoggerForInvocation(invocation);

		debugLogParameter(invocation, name, log);

		final Object returnValue = invocation.proceed();

		traceLogReturnValue(name, log, returnValue);

		return returnValue;
	}

	/**
	 * Log the Parameter on info-Level.
	 *
	 * @param invocation the method invocation
	 * @param name the method name
	 * @param log current logger
	 */
	private void debugLogParameter(final MethodInvocation invocation, final String name, final Log log) {
		if (log.isDebugEnabled()) {
			final Method method = invocation.getMethod();
			final Object[] arguments = invocation.getArguments();
			final Annotation[][] parameterAnnotations = method.getParameterAnnotations();
			final Parameter[] parameters = method.getParameters();

			// do not log passwords (login,changepassword)
			if (arguments.length > 0 && !name.endsWith(".login") && !name.endsWith(".changePassword")) {
				final StringBuilder sb = new StringBuilder();
				sb.append(name).append('{');
				int counter = 0;
				for (final Object argument : arguments) {
					// log Multipart-File
					if (argument instanceof MultipartFile) {
						final MultipartFile file = (MultipartFile) argument;
						sb.append("multipart-file{");
						sb.append(file.getName())
								.append("=[").append(file.getOriginalFilename()).append(']')
								.append(";length(byte)=[").append(file.getSize()).append(']')
								.append(";contentType=[").append(file.getContentType()).append(']');
						sb.append('}');

					} else {
						// log @RequestBody or @RequestPart parameter
						if (hasRequestBodyAnnotation(parameterAnnotations, counter)) {
							sb.append('[').append(parameters[counter].getName());
							sb.append('=').append(argument).append("],");
						}

					}

					counter++;
				}
				sb.append('}');
				if (sb.length() > name.length() + 2) {
					log.debug(sb.toString());
				}
			}
		}
	}

	/**
	 * Check if the current argument-position(counter) is marked as @RequestBody or @RequestPart
	 *
	 * @param counter the current argument(Parameter)-position
	 * @param parameterAnnotations the method parameter annotations
	 * @return true if the current position parameter is marked, otherwise false
	 */
	private boolean hasRequestBodyAnnotation(final Annotation[][] parameterAnnotations, final int counter) {
		if (counter < parameterAnnotations.length) {
			final Annotation[] annotations = parameterAnnotations[counter];
			for (final Annotation annotation : annotations) {
				if (annotation instanceof RequestBody || annotation instanceof RequestPart) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * Log the return value on trace-Level.
	 *
	 * @param name the method name
	 * @param log current logger
	 * @param returnValue the returned object
	 */
	private void traceLogReturnValue(final String name, final Log log, final Object returnValue) {
		if (log.isTraceEnabled()) {
			try {
				if (returnValue instanceof ResponseElement || returnValue instanceof ResponseCollection) {
					final ObjectMapper mapper = new ObjectMapper();
					log.trace(name + "-return=" + mapper.writeValueAsString(returnValue));
				}
			} catch (final JsonProcessingException e) {
				log.trace("Error on logging", e);
			}
		}
	}

	/**
	 * Get logger for invoced class
	 *
	 * @param invocation the method invocation
	 * @return the invoced class logger
	 */
	private Log getLoggerForInvocation(final MethodInvocation invocation) {
		final Object target = invocation.getThis();
		return LogFactory.getLog(target.getClass());
	}

}
