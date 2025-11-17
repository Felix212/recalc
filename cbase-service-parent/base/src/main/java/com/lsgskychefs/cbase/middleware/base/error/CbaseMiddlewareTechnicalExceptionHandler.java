/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;

/**
 * ExceptionHandler for CbaseMiddlewareTechnicalException
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareTechnicalExceptionHandler extends AbstractExceptionHandler<CbaseMiddlewareTechnicalException> {

	/** Constructor @param nextHandler */
	public CbaseMiddlewareTechnicalExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected CbaseMiddlewareTechnicalException canHandle(final Throwable error) {
		if (error instanceof CbaseMiddlewareTechnicalException) {
			return (CbaseMiddlewareTechnicalException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final CbaseMiddlewareTechnicalException error) {
		final CbaseMiddlewareTechnicalException e = error;
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, e.getType().name());
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, "Technical server error");
		return HttpStatus.INTERNAL_SERVER_ERROR;
	}

}
