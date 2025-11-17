/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest.deserializer;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;

import org.springframework.util.Assert;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdScalarDeserializer;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;

/**
 * Deserialize a BigDecimal based on configured DecimalFormat.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareBigDecimalDeserializer extends StdScalarDeserializer<BigDecimal> {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** Helper class to get default parameter value from current request or default value. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper;

	/**
	 * Constructor
	 *
	 * @param cbaseRestHelper Helper class to get decimal format
	 */
	public CbaseMiddlewareBigDecimalDeserializer(final CbaseMiddlewareRestHelper cbaseRestHelper) {
		super(BigDecimal.class);
		Assert.notNull(cbaseRestHelper);
		this.cbaseRestHelper = cbaseRestHelper;
	}

	/** {@inheritDoc} */
	@Override
	public BigDecimal deserialize(final JsonParser p, final DeserializationContext ctxt) throws IOException {
		final DecimalFormat currentDecimalFormat = cbaseRestHelper.getNumberFormat();
		try {
			return (BigDecimal) currentDecimalFormat.parse(p.getText());
		} catch (final ParseException e) {
			return p.getDecimalValue();
		}
	}

}
