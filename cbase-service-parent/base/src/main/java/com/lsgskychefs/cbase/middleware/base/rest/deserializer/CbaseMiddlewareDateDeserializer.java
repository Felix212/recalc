/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.deserializer;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;

/**
 * Deserialize a Date based on configured DateFormat.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareDateDeserializer extends com.fasterxml.jackson.databind.deser.std.DateDeserializers.DateDeserializer {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** Helper class to get default parameter value from current request or default value. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper;

	/**
	 * Constructor
	 *
	 * @param cbaseRestHelper Helper class to get date format
	 */
	public CbaseMiddlewareDateDeserializer(final CbaseMiddlewareRestHelper cbaseRestHelper) {
		super();
		this.cbaseRestHelper = cbaseRestHelper;
	}

	@Override
	public java.util.Date deserialize(final JsonParser jp, final DeserializationContext ctxt) throws IOException {
		final CbaseMiddlewareDateFormatter dateFormat = cbaseRestHelper.getDateTimeFormat();
		final String str = jp.getText();
		try {
			return dateFormat.parse(str);
		} catch (final CbaseMiddlewareTechnicalException e) {
			throw new IOException(e.getMessage(), e);
		}

	}

}
