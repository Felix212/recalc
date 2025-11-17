/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.io.IOException;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.LinkedCaseInsensitiveMap;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Filter to handle the request parameter case insensitive.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareCaseInsensitiveRequestFilter extends OncePerRequestFilter {
	@Override
	protected void doFilterInternal(final HttpServletRequest request, final HttpServletResponse response, final FilterChain filterChain)
			throws ServletException, IOException {
		filterChain.doFilter(new CaseInsensitiveHttpServletRequestWrapper(request), response);
	}

	/**
	 * A HttpServletRequestWrapper to handle the request parameter case insensitive
	 *
	 * @author Ingo Rietzschel - U125742
	 */
	private final static class CaseInsensitiveHttpServletRequestWrapper extends HttpServletRequestWrapper {

		/** The incredible case insensitive map to handle the request parameter case insensitive */
		private final LinkedCaseInsensitiveMap<String[]> params = new LinkedCaseInsensitiveMap<>();

		/**
		 * Constructs a request object wrapping the given request.
		 *
		 * @param request current request
		 * @throws IllegalArgumentException if the request is null
		 */
		CaseInsensitiveHttpServletRequestWrapper(final HttpServletRequest request) {
			super(request);
			params.putAll(request.getParameterMap());
		}

		@Override
		public String getParameter(final String name) {
			final String[] values = getParameterValues(name);
			if (values == null || values.length == 0) {
				return null;
			}
			return values[0];
		}

		@Override
		public Map<String, String[]> getParameterMap() {
			return Collections.unmodifiableMap(this.params);
		}

		@Override
		public Enumeration<String> getParameterNames() {
			return Collections.enumeration(this.params.keySet());
		}

		@Override
		public String[] getParameterValues(final String name) {
			return params.get(name);
		}
	}

}
