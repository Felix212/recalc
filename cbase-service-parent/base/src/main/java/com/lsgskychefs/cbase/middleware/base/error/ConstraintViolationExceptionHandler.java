/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.springframework.http.HttpStatus;

/**
 * Exception Handler for {@link ConstraintViolationException}
 *
 * @author Alex Schaab
 */
public class ConstraintViolationExceptionHandler extends AbstractExceptionHandler<ConstraintViolationException> {

	/** Constructor @param nextHandler */
	public ConstraintViolationExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		super(nextHandler);
	}

	/** VALIDATION_ERROR */
	public static final String VALIDATION_ERROR = "VALIDATION_ERROR";

	@Override
	protected ConstraintViolationException canHandle(final Throwable error) {
		return getExistingCauseExpection(error, ConstraintViolationException.class);

	}

	@Override
	protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final ConstraintViolationException error) {
		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_CODE_KEY, VALIDATION_ERROR);

		final StringBuilder sb = new StringBuilder("Validation failed due to [");
		for (final ConstraintViolation<?> cv : error.getConstraintViolations()) {
			sb.append("Attribute: ").append(cv.getPropertyPath()).append(' ').append(cv.getMessage()).append(';');
		}
		sb.append(']');

		errorAttributes.put(CbaseMiddlewareErrorAttributes.ERROR_MESSAGE_KEY, sb.toString());
		return HttpStatus.BAD_REQUEST;
	}
}
