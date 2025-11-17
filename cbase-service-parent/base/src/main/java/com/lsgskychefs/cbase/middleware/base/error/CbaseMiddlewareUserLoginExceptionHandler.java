/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareUserLoginException;

/**
 * ExceptionHandler for CbaseMiddlewareUserLoginException.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareUserLoginExceptionHandler extends AbstractExceptionHandler<CbaseMiddlewareUserLoginException> {

	/** Constructor @param nextHandler */
	public CbaseMiddlewareUserLoginExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected CbaseMiddlewareUserLoginException canHandle(final Throwable error) {
		if (error instanceof CbaseMiddlewareUserLoginException) {
			return (CbaseMiddlewareUserLoginException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final CbaseMiddlewareUserLoginException error) {
		final CbaseMiddlewareUserLoginException e = error;
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, e.getLoginStatus().name());
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, e.getMessage());
		return null;
	}

}
