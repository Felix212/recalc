/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error.exception;

/**
 * Parsing Exception
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareParsingException extends CbaseMiddlewareBusinessException {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type the exception reason
	 * @param message the message
	 * @param original the original throwable.
	 */
	public CbaseMiddlewareParsingException(final CbaseMiddlewareBusinessExceptionType type, final String message,
			final Throwable original) {
		super(type, message, original);
	}

}
