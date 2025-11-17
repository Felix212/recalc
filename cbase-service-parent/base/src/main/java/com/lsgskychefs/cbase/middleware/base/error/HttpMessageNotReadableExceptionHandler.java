/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;

/**
 * ExceptionHandler for HttpMessageNotReadableException.
 *
 * @author Ingo Rietzschel - U125742
 */
public class HttpMessageNotReadableExceptionHandler extends AbstractExceptionHandler<HttpMessageNotReadableException> {

	/** CONVERSION_ERROR */
	public static final String CONVERSION_ERROR = "CONVERSION_ERROR";

	/** Constructor @param nextHandler */
	public HttpMessageNotReadableExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected HttpMessageNotReadableException canHandle(final Throwable error) {
		if (error instanceof HttpMessageNotReadableException) {
			return (HttpMessageNotReadableException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final HttpMessageNotReadableException error) {
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, CONVERSION_ERROR);
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, error.getMessage());
		return HttpStatus.BAD_REQUEST;
	}

}
