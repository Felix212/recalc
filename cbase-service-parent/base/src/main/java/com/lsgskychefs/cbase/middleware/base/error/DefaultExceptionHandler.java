/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;

/**
 * Default ExceptionHandler
 *
 * @author Ingo Rietzschel - U125742
 */
public class DefaultExceptionHandler extends AbstractExceptionHandler<Throwable> {

	/** Constructor @param nextHandler */
	public DefaultExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected Throwable canHandle(final Throwable error) {
		return error;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final Throwable error) {
		// set default values for error key and error message to be overwritten later
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, "No message available");
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, null);
		return null;
	}

}
