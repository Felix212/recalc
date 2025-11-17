/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.serializer;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;

import org.springframework.util.Assert;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdScalarSerializer;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;

/**
 * Serialize a BigDecimal based on configured DecimalFormat.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareBigDecimalSerializer extends StdScalarSerializer<BigDecimal> {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** Helper class to get default parameter value from current request or default value. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper;

	/**
	 * Constructor
	 *
	 * @param cbaseRestHelper Helper class to get decimal format
	 */
	public CbaseMiddlewareBigDecimalSerializer(final CbaseMiddlewareRestHelper cbaseRestHelper) {
		super(BigDecimal.class, false);
		Assert.notNull(cbaseRestHelper);
		this.cbaseRestHelper = cbaseRestHelper;
	}

	@Override
	public void serialize(final BigDecimal value, final JsonGenerator gen, final SerializerProvider provider) throws IOException {
		final DecimalFormat currentDecimalFormat = cbaseRestHelper.getNumberFormat();

		// Default should be native json standard for numbers when not using our custom parameter
		if (cbaseRestHelper.isDecimalPointParameterSet()) {
			gen.writeString(currentDecimalFormat.format(value));
		} else {
			gen.writeNumber(value);
		}

	}

}
