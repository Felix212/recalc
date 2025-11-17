/*
 * RequestLoggerHandlerInterceptorAdapter.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * A <code>HandlerInterceptorAdapter</code> responsible for logging HTTP requests.
 *
 * @author Andreas Morgenstern
 */
@Component
public class RequestLoggerHandlerInterceptorAdapter extends HandlerInterceptorAdapter {

	/**
	 * The logger.
	 */
	private static final Logger LOGGER = LoggerFactory.getLogger(RequestLoggerHandlerInterceptorAdapter.class);

	@Override
	public boolean preHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug(getDescription(request, handler));
		}
		return true;
	}

	/**
	 * Creates a string containing the following request information if available
	 * <ul>
	 * <li>uri
	 * <li>client address
	 * <li>session
	 * <li>user
	 * <li>parameters
	 * <li>Java handler method
	 * </ul>
	 *
	 * @param request The <code>HttpServletRequest</code>
	 * @param handler The handler object
	 * @return the String containing the request information
	 */
	public static String getDescription(final HttpServletRequest request, final Object handler) {

		final String requestURI = request.getRequestURI();
		final StringBuilder sb = new StringBuilder(1000);
		sb.append("uri={").append(requestURI).append('}');
		sb.append(";parameters={");
		setParameterInfos(request, sb);
		sb.append('}');
		final String client = request.getRemoteAddr();
		final String fwd = request.getHeader("x-forwarded-for");
		sb.append(";client={").append(client).append(" - x-forwarded-for:").append(fwd).append('}');
		final String remoteHost = request.getRemoteHost();
		final String fwdHost = request.getHeader("x-forwarded-host");
		sb.append(";host={").append(remoteHost).append(" - x-forwarded-host: ").append(fwdHost).append('}');
		final HttpSession session = request.getSession(false);
		final String sessionId = (session != null) ? session.getId() : null;
		sb.append(";session={").append(sessionId).append('}');
		final String user = request.getRemoteUser();
		sb.append(";user={").append(user).append('}');
		final String handlerString = (handler != null) ? handler.toString() : null;
		sb.append(";handler={");
		sb.append(handlerString);
		sb.append('}');

		// on debug level log all headers
		if (LOGGER.isTraceEnabled()) {
			sb.append(";headers={");
			final Enumeration<String> headerNames = request.getHeaderNames();
			while (headerNames.hasMoreElements()) {
				final String name = headerNames.nextElement();
				final String header = request.getHeader(name);
				sb.append(name).append("=[").append(header).append("];");
			}
			sb.append('}');
		}

		return sb.toString();
	}

	/**
	 * Get the parameter name and value (no body data).
	 *
	 * @param request the current request
	 * @param sb the StringBuilder to write in data.
	 */
	private static void setParameterInfos(final HttpServletRequest request, final StringBuilder sb) {
		final Map<String, String[]> parameterMap = request.getParameterMap();
		boolean first = true;
		for (final Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
			if ("password".equals(entry.getKey())) {
				continue;
			}
			if (!first) {
				sb.append(", ");
			}
			sb.append(entry.getKey()).append('=');
			sb.append(Arrays.toString(entry.getValue()));
			first = false;
		}
	}

}
