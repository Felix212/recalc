/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;

/**
 * ExceptionHandler for BindException
 *
 * @author Ingo Rietzschel - U125742
 */
public class BindExceptionHandler extends AbstractExceptionHandler<BindException> {

	/** Constructor @param nextHandler */
	public BindExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	@Override
	protected BindException canHandle(final Throwable error) {
		if (error instanceof BindException) {
			return (BindException) error;
		}

		return null;
	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final BindException error) {
		if (error.hasErrors()) {
			errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY,
					"Validation failed for object='" + error.getObjectName() + "'. Error count: "
							+ error.getErrorCount());

			final StringBuilder sb = new StringBuilder("Validation failed due to [");
			final BindingResult bindingResult = error.getBindingResult();
			buildErrorMessage(sb, bindingResult);
			sb.append(']');
			errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, sb.toString());

		} else {
			errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, "No errors");
		}
		return HttpStatus.BAD_REQUEST;

	}

	/**
	 * Build the error message for a {@link BindingResult} error.
	 *
	 * @param sb the {@link StringBuilder} to write in
	 * @param bindingResult the error result
	 */
	static void buildErrorMessage(final StringBuilder sb, final BindingResult bindingResult) {
		for (final ObjectError er : bindingResult.getAllErrors()) {
			if (er instanceof FieldError) {
				final FieldError fe = (FieldError) er;
				sb.append("{Field error in object '").append(fe.getObjectName())
						.append("' on field '").append(fe.getField())
						.append("' the rejected value is [").append(fe.getRejectedValue()).append("]; ")
						.append(" reason: ").append(fe.getCode()).append(" - ")
						.append(fe.getDefaultMessage()).append("} ");

			} else {
				sb.append(er.toString());
			}

		}
	}
}
