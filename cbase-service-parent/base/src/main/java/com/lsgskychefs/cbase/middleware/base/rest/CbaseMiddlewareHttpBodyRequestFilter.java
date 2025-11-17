/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.FilterChain;
import javax.servlet.ReadListener;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Filter to wrap all requests to make a copy of the request body, so you can manually read it more times
 *
 * @author Alex Schaab - U524036
 */
public class CbaseMiddlewareHttpBodyRequestFilter extends OncePerRequestFilter {
	@Override
	protected void doFilterInternal(final HttpServletRequest request, final HttpServletResponse response, final FilterChain filterChain)
			throws ServletException, IOException {
		filterChain.doFilter(new BodyHttpServletRequestWrapper(request), response);
	}

	/**
	 * A HttpServletRequestWrapper to be able to read Inputstream multiple times
	 *
	 * @author Alex Schaab - U524036
	 */
	private final static class BodyHttpServletRequestWrapper extends HttpServletRequestWrapper {

		/** The logger. */
		private static final Logger LOGGER = LoggerFactory.getLogger(BodyHttpServletRequestWrapper.class);

		/** The HTTP Body */
		private final String body;

		/** The original character encoding */
		private final String requestCharacterEncoding;

		/**
		 * Flag to control whether to read the HTTP body since this could lead unnecessary memory allocation when transferring real files
		 * and no JSON parameters
		 */
		private boolean intercept = false;

		/**
		 * Constructs a request object wrapping the given request.
		 *
		 * @param request current request
		 */
		BodyHttpServletRequestWrapper(final HttpServletRequest request) {
			super(request);

			final StringBuilder stringBuilder = new StringBuilder();
			// Only non GET and < 256KB
			if (!request.getMethod().equals(RequestMethod.GET.name()) && (request.getContentLength() < 262144)
					&& request.getContentType() != null && !(request.getContentType().contains(MediaType.MULTIPART_FORM_DATA_VALUE))) {

				intercept = true;

				InputStream inputStream = null;
				try {
					inputStream = request.getInputStream();
				} catch (final IOException e) {
					LOGGER.error("Error getting the request InputStream...", e);
				}
				if (inputStream != null) {
					try (BufferedReader bufferedReader =
							new BufferedReader(new InputStreamReader(inputStream, request.getCharacterEncoding()));) {

						final char[] charBuffer = new char[128];
						int bytesRead = -1;

						while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
							stringBuilder.append(charBuffer, 0, bytesRead);
						}

					} catch (final IOException ex) {
						LOGGER.error("Error reading the request body...", ex);
					}
				} else {
					stringBuilder.append("");
				}
			}

			body = stringBuilder.toString();
			requestCharacterEncoding = request.getCharacterEncoding();

		}

		@Override
		public ServletInputStream getInputStream() throws IOException {
			if (intercept) {
				final ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(body.getBytes(requestCharacterEncoding));
				return new ServletInputStream() {
					public int read() throws IOException {
						return byteArrayInputStream.read();
					}

					@Override
					public boolean isFinished() {
						return false;
					}

					@Override
					public boolean isReady() {
						return false;
					}

					@Override
					public void setReadListener(final ReadListener listener) {
						throw new UnsupportedOperationException("Not implemented");
					}
				};
			} else {
				return super.getInputStream();
			}
		}

		@Override
		public BufferedReader getReader() throws IOException {
			return new BufferedReader(new InputStreamReader(this.getInputStream()));
		}

	}

}
