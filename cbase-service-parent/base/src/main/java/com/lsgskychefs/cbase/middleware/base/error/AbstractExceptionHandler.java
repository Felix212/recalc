/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.error;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;

/**
 * Chain of Responsibility Pattern <br>
 * Abstract exception/error handler to handle CbaseMiddleware-Controller Exceptions .
 *
 * @param <E> the handler is responsible for these Error or Exception type.
 * @author Ingo Rietzschel - U125742
 */
public abstract class AbstractExceptionHandler<E extends Throwable> {

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(AbstractExceptionHandler.class);

	/** the next handler on chain */
	protected AbstractExceptionHandler<? extends Throwable> nextHandler;

	/**
	 * Constructor
	 *
	 * @param nextHandler the next handler on chain
	 */
	protected AbstractExceptionHandler(final AbstractExceptionHandler<? extends Throwable> nextHandler) {
		this.nextHandler = nextHandler;
	}

	/**
	 * Handle the error. If the current handler is responsible, the error attributes will be set. Otherwise the next handler is called.
	 *
	 * @param errorAttributes the map to set the error attribute values
	 * @param error the occurred exception/error
	 * @return determined exception {@link HttpStatus}
	 */
	public HttpStatus handleException(final Map<String, Object> errorAttributes, final Throwable error) {
		if (error == null) {
			return null;
		}
		final E throwable = canHandle(error);
		if (throwable != null) {
			LOGGER.debug("Current responsible exception handler");
			return setErrorAttributes(errorAttributes, throwable);

		}
		if (nextHandler == null) {
			LOGGER.warn("No responsible exception handler found!");
			return null;
		}
		return nextHandler.handleException(errorAttributes, error);
	}

	/**
	 * Check recursive the current throwable and the cause trace against the given clazz.
	 *
	 * @param error the occurred error
	 * @param clazz the Handler is responsible for this class
	 * @return null or the matched cause
	 */
	@SuppressWarnings("unchecked")
	protected E getExistingCauseExpection(final Throwable error, final Class<E> clazz) {
		if (error == null) {
			return null;
		}

		if (error.getClass() == clazz) {
			return (E) error;
		}

		return getExistingCauseExpection(error.getCause(), clazz);
	}

	/**
	 * Check if the current exception handler is responsible
	 *
	 * @param error the occurred error/exception
	 * @return typed Throwable if the handler is responsible, otherwise {@code null}
	 */
	abstract protected E canHandle(Throwable error);

	/**
	 * Set the error attributes
	 *
	 * @param errorAttributes the map to set the error attribute values
	 * @param error the occurred exception/error
	 * @return determined exception {@link HttpStatus}
	 */
	abstract protected HttpStatus setErrorAttributes(final Map<String, Object> errorAttributes, final E error);
}
