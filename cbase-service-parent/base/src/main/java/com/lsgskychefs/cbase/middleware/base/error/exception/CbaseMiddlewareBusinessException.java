/*
 * CbaseMiddlewareBusinessException.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Exception class for CBASE Middleware business exceptions.
 *
 * @author Andreas Morgenstern
 */
@ResponseStatus(code = HttpStatus.BAD_REQUEST)
public class CbaseMiddlewareBusinessException extends Exception {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** The type to define(describe the reason) for exception. */
	public enum CbaseMiddlewareBusinessExceptionType {
		/** Unknown error - HttpStatus.INTERNAL_SERVER_ERROR-500. */
		UNKNOWN(HttpStatus.INTERNAL_SERVER_ERROR),
		/** Primary Key not found - HttpStatus.NOT_FOUND-404. */
		UNKNOWN_ID(HttpStatus.NOT_FOUND),
		/** Object not found(search without primary key, but one element/object is expected) - HttpStatus.NOT_FOUND-404. */
		NOT_FOUND(HttpStatus.NOT_FOUND),
		/** Element has wrong state - HttpStatus.CONFLICT-409. */
		WRONG_STATE(HttpStatus.CONFLICT),
		/** Current element has a locked state - HttpStatus.CONFLICT-409 */
		LOCKED_STATE(HttpStatus.CONFLICT),
		/** Current element has a locked state by SMDB app - HttpStatus.CONFLICT-409 */
		LOCKED_STATE_BY_SMDB(HttpStatus.CONFLICT),
		/** Batch sequence(WorkOrder) not found - HttpStatus.NOT_FOUND-404. */
		UNKNOWN_BATCH_SEQ(HttpStatus.NOT_FOUND),
		/** part of batch is different - HttpStatus.CONFLICT-409 */
		BATCH_INCONSISTENT(HttpStatus.CONFLICT),
		/** Database record(s) inconsistent - HttpStatus.CONFLICT-409 */
		DB_INCONSISTENT(HttpStatus.CONFLICT),
		/** No free number available - HttpStatus.CONFLICT-409 */
		NO_FREE_BATCH_NO_AVAILABLE(HttpStatus.CONFLICT),
		/** Inconsistent parameter. Not all expected values set or other relations not adherence - HttpStatus.BAD_REQUEST-400 */
		PARAM_INCONSITENT(HttpStatus.BAD_REQUEST),
		/** Wrong parameter(argument) value - HttpStatus.CONFLICT-409 */
		ILLEGAL_ARGUMENT(HttpStatus.CONFLICT),
		/** Today the password has been changed too often. - HttpStatus.CONFLICT-409 */
		MAX_CHANGES(HttpStatus.CONFLICT),
		/** The new password has already been used - HttpStatus.CONFLICT-409 */
		PWD_ALREADY_USED(HttpStatus.CONFLICT),
		/** The current password is wrong - HttpStatus.CONFLICT-409 */
		WRONG_PWD(HttpStatus.CONFLICT),
		/** The resource that is being accessed is locked - HttpStatus.LOCKED-423 */
		LOCKED(HttpStatus.LOCKED),
		/** Current element does not meet functional requirement */
		FUNCTIONAL_VIOLATION(HttpStatus.CONFLICT),
		/** Special Authorization needed */
		SPECIAL_AUTHORIZATION(HttpStatus.CONFLICT);

		/** assigned http status */
		private HttpStatus httpStatus;

		/**
		 * Constructor
		 *
		 * @param httpStatus http status code for this exception type.
		 */
		CbaseMiddlewareBusinessExceptionType(final HttpStatus httpStatus) {
			this.httpStatus = httpStatus;
		}

		/**
		 * Get httpStatus
		 *
		 * @return the httpStatus
		 */
		public HttpStatus getHttpStatus() {
			return httpStatus;
		}
	}

	/** type/reason of Exception */
	private final CbaseMiddlewareBusinessExceptionType type;

	/**
	 * Public constructor taking message and throwable.
	 *
	 * @param type the exception reason
	 * @param message the message
	 * @param original the original throwable.
	 */
	public CbaseMiddlewareBusinessException(final CbaseMiddlewareBusinessExceptionType type, final String message,
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
	public CbaseMiddlewareBusinessException(final CbaseMiddlewareBusinessExceptionType type, final String message) {
		super(type.name() + " - " + message);
		this.type = type;
	}

	/**
	 * Get the exception type(reason).
	 *
	 * @return the type(reason) of current exception
	 */
	public CbaseMiddlewareBusinessExceptionType getType() {
		return type;
	}

}
