/*
 * CbaseMiddlewareErrorController.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.comparators.ReverseComparator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.WebRequest;

/**
 * ErrorController for CBASE Middleware responsible for constructing JSON error messages returned to service callers.
 *
 * @author Andreas Morgenstern
 */
@RestController
@ConditionalOnWebApplication
public class CbaseMiddlewareErrorController implements ErrorController {

	/**
	 * The error path url.
	 */
	@Value("${error.path:/error}")
	private String errorPath;

	/**
	 * Helper to receive default error attributes.
	 */
	@Autowired
	private ErrorAttributes errorAttributes;

	/**
	 * {@inheritDoc}
	 */
	@Override
	public String getErrorPath() {
		return this.errorPath;
	}

	/**
	 * Constructs a JSON error message containing the following attributes: TODO: correct attributes
	 * <ul>
	 * <li>timestamp
	 * <li>http status
	 * <li>http error
	 * <li>error code
	 * <li>error message
	 * <li>request path
	 * </ul>
	 *
	 * @param request the <code>HttpServletRequest</code> of the request.
	 * @return the error message to be returned to the caller
	 */
	@RequestMapping(value = { "${error.path:/error}" }, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Map<String, Object>> error(final WebRequest request) {
		final Map<String, Object> body = getErrorAttributes(request);
		final Integer statusCode = (Integer) request.getAttribute(CbaseMiddlewareErrorAttributes.JAVAX_SERVLET_ERROR_STATUS_CODE, 0);
		final TreeMap<String, Object> newBody = new TreeMap<>(new ReverseComparator<String>());
		newBody.putAll(body);
		return new ResponseEntity<>(newBody, HttpStatus.valueOf(statusCode));
	}

	/**
	 * Receive attribute to be returned to the caller.
	 *
	 * @param request the <code>HttpServletRequest</code> of the request.
	 * @return the attributes.
	 */
	private Map<String, Object> getErrorAttributes(final WebRequest request) {
		return this.errorAttributes.getErrorAttributes(request, false);
	}

}
