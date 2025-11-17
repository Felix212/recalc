/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base;

import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * List of default supported parameter names for CbaseMiddleware-Application. This parameters can used on every Endpoint. The values will be
 * used for parameter conversations and response serialization.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum CbaseDefaultParameter {
	/** Name for date format pattern parameter. */
	DATE_FORMAT("dateFormat", FormatConstants.DATE_PATTERN),
	/** Name for number format */
	BIG_DECIMAL_FORMAT("bigDecimalFormat", FormatConstants.NUMBER_PATTERN),
	/** Name for decimal separator */
	USE_DECIMAL_POINT("useDecimalPoint", Boolean.TRUE.toString()),
	/** Name for locale */
	LOCALE("locale", FormatConstants.DEFAULT_LOCALE.toString());

	/** default parameter value, if parameter is not set. */
	private String defaultValue;

	/** the parameter name */
	private String paramName;

	/**
	 * Constructor
	 *
	 * @param paramName the default parameter name
	 * @param defaultValue value if the paraneter is not set
	 */
	CbaseDefaultParameter(final String paramName, final String defaultValue) {
		this.paramName = paramName;
		this.defaultValue = defaultValue;
	}

	/**
	 * Get defaultValue
	 *
	 * @return the defaultValue
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/**
	 * Get the parameter name.
	 *
	 * @return the parameter name
	 */
	public String getParamName() {
		return paramName;
	}

}
