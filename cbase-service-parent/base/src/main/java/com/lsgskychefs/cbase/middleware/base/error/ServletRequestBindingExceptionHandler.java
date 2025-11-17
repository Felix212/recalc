/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.ServletRequestBindingException;

/**
 * ExceptionHandler for ServletRequestBindingException.
 *
 * @author Ingo Rietzschel - U125742
 */
public class ServletRequestBindingExceptionHandler extends AbstractExceptionHandler<ServletRequestBindingException> {

	/** Constructor @param nextHandler */
	public ServletRequestBindingExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected ServletRequestBindingException canHandle(final Throwable error) {
		if (error instanceof ServletRequestBindingException) {
			return (ServletRequestBindingException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final ServletRequestBindingException error) {
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, error.getMessage());
		return HttpStatus.INTERNAL_SERVER_ERROR;
	}

}
