/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.converter;

import java.util.Date;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.lsgskychefs.cbase.middleware.base.CbaseDefaultParameter;
import com.lsgskychefs.cbase.middleware.base.rest.CbaseMiddlewareRestHelper;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;

/**
 * Convert a String into Date, use deafult format or from existing request.
 *
 * @author Ingo Rietzschel - U125742
 */
@Component
public class StringToDateConverter implements Converter<String, Date> {

	/** Cbase REST Helper. */
	private final CbaseMiddlewareRestHelper cbaseRestHelper = new CbaseMiddlewareRestHelper();

	/**
	 * Convert a given {@link String} into a {@link Date} and return the date value. It is used the default date format(
	 * {@link CbaseDefaultParameter#DATE_FORMAT}. Should on current request the parameter {@link CbaseDefaultParameter#DATE_FORMAT} contain,
	 * so its format will be used.
	 */
	@Override
	public Date convert(final String source) {
		final CbaseMiddlewareDateFormatter dateTimeFormat = cbaseRestHelper.getDateTimeFormat();
		return dateTimeFormat.parse(source);

	}

}
