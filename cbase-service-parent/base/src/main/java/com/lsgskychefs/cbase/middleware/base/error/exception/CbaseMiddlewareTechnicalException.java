/*
 * CbaseMiddlewareBusinessException.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error.exception;

/**
 * Exception class for CBASE Middleware technical exceptions.
 *
 * @author Andreas Morgenstern
 */
public final class CbaseMiddlewareTechnicalException extends RuntimeException {

	/** serial version uid */
	private static final long serialVersionUID = -6580572695593910258L;

	/** The type to define(describe the reason) for technical exception. */
	public enum CbaseMiddlewareTechnicalExceptionType {
		/** Unknown error. */
		UNKNOWN,
		/** Invalid argument/parameter */
		INVALID_ARGUMENT,
		/** Attribute exist already as key */
		ATTRIBUTE_NAME_ALREADY_EXIST,
		/** Timeout during processing */
		TIMEOUT;
	}

	/** type/reason of exception */
	private final CbaseMiddlewareTechnicalExceptionType type;

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type the exception reason
	 * @param message the message
	 * @param original the original throwable.
	 */
	public CbaseMiddlewareTechnicalException(final CbaseMiddlewareTechnicalExceptionType type, final String message,
			final Throwable original) {
		super(type.name() + " - " + message, original);
		this.type = type;
	}

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type the exception reason
	 * @param message the message
	 */
	public CbaseMiddlewareTechnicalException(final CbaseMiddlewareTechnicalExceptionType type, final String message) {
		super(type.name() + " - " + message);
		this.type = type;
	}

	/**
	 * Get the exception type(reason).
	 *
	 * @return the type(reason) of current exception
	 */
	public CbaseMiddlewareTechnicalExceptionType getType() {
		return type;
	}

}
