/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

/**
 * Contains the native queries.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareNativeQuery {

	/** the native sql query */
	private final String query;

	/**
	 * Constructor
	 *
	 * @param query the native query string
	 */
	public CbaseMiddlewareNativeQuery(final String query) {
		this.query = query;
	}

	/**
	 * Get the native sql query as String.
	 *
	 * @return the native query
	 */
	public String getQuery() {
		return query;
	}

}
