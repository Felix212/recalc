/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.converter;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.lsgskychefs.cbase.middleware.base.CbaseDefaultParameter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;

/**
 * Convert a String into BigDecimal, use default format or from existing request.
 *
 * @author Ingo Rietzschel - U125742
 */
@Component
public class StringToBigDecimalConverter implements Converter<String, BigDecimal> {

	/** Cbase REST Helper. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper = new CbaseMiddlewareRestHelper();

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(StringToBigDecimalConverter.class);

	/**
	 * Convert a given {@link String} into a {@link BigDecimal} and return the BigDecimal. It is used/support the default format('12.12' and
	 * '12,12'). <br>
	 * Should on current request the parameter {@link CbaseDefaultParameter#BIG_DECIMAL_FORMAT} contain, so its format will be used.
	 */
	@Override
	public BigDecimal convert(final String source) {

		final DecimalFormat decimalFormat = cbaseRestHelper.getNumberFormat();
		try {
			return (BigDecimal) decimalFormat.parse(source);

		} catch (final ParseException e) {
			LOGGER.warn("Error on parsing BigDecimal: {} - format: {} -  msg: {}" + source, decimalFormat.toPattern(), e.getMessage());
		}

		return null;
	}

}
