/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.serializer;

import java.io.IOException;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.DateSerializer;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;

/**
 * Serialize a Date based on configured DateFormat.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareDateSerializer extends DateSerializer {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** Helper class to get default parameter value from current request or default value. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper;

	/**
	 * Constructor
	 *
	 * @param cbaseRestHelper Helper class to get date format
	 */
	public CbaseMiddlewareDateSerializer(final CbaseMiddlewareRestHelper cbaseRestHelper) {
		super();
		this.cbaseRestHelper = cbaseRestHelper;
	}

	@Override
	public void serialize(final Date value, final JsonGenerator gen, final SerializerProvider provider) throws IOException {
		final CbaseMiddlewareDateFormatter dateFormat = cbaseRestHelper.getDateTimeFormat();
		gen.writeString(dateFormat.format(value));
	}
}
