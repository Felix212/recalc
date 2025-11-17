/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

/**
 * ExceptionHandler for {@link MethodArgumentTypeMismatchException} .
 *
 * @author Ingo Rietzschel - U125742
 */
public class MethodArgumentTypeMismatchExceptionHandler extends AbstractExceptionHandler<MethodArgumentTypeMismatchException> {

	/** TYPE_MISMATCH_ERROR */
	public static final String TYPE_MISMATCH_ERROR = "METHOD_ARGUMENT_TYPE_MISMATCH";

	/** Constructor @param nextHandler */
	public MethodArgumentTypeMismatchExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected MethodArgumentTypeMismatchException canHandle(final Throwable error) {
		if (error instanceof MethodArgumentTypeMismatchException) {
			return (MethodArgumentTypeMismatchException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final MethodArgumentTypeMismatchException error) {
		final MethodArgumentTypeMismatchException e = error;
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, TYPE_MISMATCH_ERROR);
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, e.getMessage());
		return HttpStatus.BAD_REQUEST;
	}
}
