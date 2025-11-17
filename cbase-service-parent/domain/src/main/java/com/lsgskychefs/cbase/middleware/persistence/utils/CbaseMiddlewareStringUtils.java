/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * Class for special String methods.
 *
 * @author Ingo Rietzschel - U125742
 */
public final class CbaseMiddlewareStringUtils {

	/** Constructor */
	private CbaseMiddlewareStringUtils() {
	}

	/**
	 * <p>
	 * Returns either the passed in String, or if the String is {@code null} or empty, the value of " ".
	 * </p>
	 * Is relevant for Oracle db empty string is null on Oracle!
	 *
	 * <pre>
	 * CbaseMiddlewareStringUtils.defaultString(null)  = " "
	 * CbaseMiddlewareStringUtils.defaultString("")    = " "
	 * CbaseMiddlewareStringUtils.defaultString("bat") = "bat"
	 * </pre>
	 *
	 * @param value the String to check, may be null or blank
	 * @return the passed in String, or if the String is {@code null} or empty, the value of " "
	 */
	public static String defaultString(final String value) {
		return StringUtils.isBlank(value) ? " " : value;
	}

	/**
	 * <p>
	 * Returns either the passed in String, or if the String is {@code null} or empty, the value of {@code defaultStr}.
	 * </p>
	 *
	 * <pre>
	 * StringUtils.defaultString(null, "NULL")  = "NULL"
	 * StringUtils.defaultString("", "NULL")    = "NULL"
	 * StringUtils.defaultString("bat", "NULL") = "bat"
	 * </pre>
	 *
	 * @param value the String to check, may be null or blank
	 * @param defaultStr the default String to return
	 * @return the passed in String, or the default if it was {@code null} or empty.
	 */
	public static String defaultString(final String value, final String defaultStr) {
		return StringUtils.isBlank(value) ? defaultStr : value;
	}
}
