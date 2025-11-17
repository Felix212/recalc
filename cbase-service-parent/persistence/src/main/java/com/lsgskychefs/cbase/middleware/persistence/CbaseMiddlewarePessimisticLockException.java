/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence;

/**
 * Encapsulate the LockTimeoutException or PessimisticLockException and get a better Information which element is locked.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewarePessimisticLockException extends RuntimeException {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor
	 *
	 * @param message the detail message (which is saved for later retrieval by the {@link #getMessage()} method).
	 * @param cause the cause (which is saved for later retrieval by the {@link #getCause()} method). (A <tt>null</tt> value is permitted,
	 *            and indicates that the cause is nonexistent or unknown.)
	 */
	public CbaseMiddlewarePessimisticLockException(final String message, final Throwable cause) {
		super(message, cause);
	}
}
