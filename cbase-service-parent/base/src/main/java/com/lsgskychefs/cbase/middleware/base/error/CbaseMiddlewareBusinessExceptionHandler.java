/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;

/**
 * ExceptionHandler for CbaseMiddlewareBusinessException
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareBusinessExceptionHandler extends AbstractExceptionHandler<CbaseMiddlewareBusinessException> {

	/** Constructor @param nextHandler */
	public CbaseMiddlewareBusinessExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected CbaseMiddlewareBusinessException canHandle(final Throwable error) {
		if (error instanceof CbaseMiddlewareBusinessException) {
			return (CbaseMiddlewareBusinessException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final CbaseMiddlewareBusinessException error) {
		final CbaseMiddlewareBusinessException e = error;
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, e.getType().name());
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, e.getMessage());
		return e.getType().getHttpStatus();
	}

}
