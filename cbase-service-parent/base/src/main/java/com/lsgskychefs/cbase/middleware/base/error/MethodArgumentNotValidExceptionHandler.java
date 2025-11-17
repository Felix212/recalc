/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.core.MethodParameter;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;

/**
 * ExceptionHandler for {@link MethodArgumentNotValidException}.
 *
 * @author Ingo Rietzschel - U125742
 */
public class MethodArgumentNotValidExceptionHandler extends AbstractExceptionHandler<MethodArgumentNotValidException> {

	/** Constructor @param nextHandler */
	public MethodArgumentNotValidExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	/** VALIDATION_ERROR */
	public static final String VALIDATION_ERROR = "VALIDATION_ERROR";

	@Override
	protected MethodArgumentNotValidException canHandle(final Throwable error) {
		if (error instanceof MethodArgumentNotValidException) {
			return (MethodArgumentNotValidException) error;
		}
		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final MethodArgumentNotValidException error) {
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, VALIDATION_ERROR);

		final MethodParameter parameter = error.getParameter();
		final StringBuilder sb = new StringBuilder("Validation failed for parameter '")
				.append(parameter.getParameterName()).append("' at index '").append(parameter.getParameterIndex()).append("'. [");
		final BindingResult bindingResult = error.getBindingResult();
		BindExceptionHandler.buildErrorMessage(sb, bindingResult);
		sb.append(']');

		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, sb.toString());
		return HttpStatus.BAD_REQUEST;
	}

}
