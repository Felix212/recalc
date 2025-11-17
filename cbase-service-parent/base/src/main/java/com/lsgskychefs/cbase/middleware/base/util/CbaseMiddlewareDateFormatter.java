/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang3.time.DateUtils;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * Special formatter to support UTC default date string format(e.g. 2011-12-03T10:15:30Z)<br>
 * is obsolet
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareDateFormatter {

	/** The pattern @see {@link SimpleDateFormat} */
	private final String pattern;
	/** the formatter */
	private final SimpleDateFormat sdf;

	/** Constructor to use the default pattern or UTC default date format{@link DateTimeFormatter#ISO_INSTANT}. */
	public CbaseMiddlewareDateFormatter() {
		this.pattern = FormatConstants.DATE_PATTERN;
		sdf = new SimpleDateFormat(pattern, FormatConstants.DEFAULT_LOCALE);
	}

	/**
	 * Constructor to use the given pattern or UTC default date format{@link DateTimeFormatter#ISO_INSTANT}.
	 *
	 * @param pattern the date format pattern @see {@link SimpleDateFormat}
	 */
	public CbaseMiddlewareDateFormatter(final String pattern) {
		this.pattern = pattern;
		this.sdf = new SimpleDateFormat(pattern, FormatConstants.DEFAULT_LOCALE);
	}

	/**
	 * Constructor to use the given pattern and locale or UTC default date format{@link DateTimeFormatter#ISO_INSTANT}.
	 *
	 * @param pattern the date format pattern @see {@link SimpleDateFormat}
	 * @param locale locale to use
	 */
	public CbaseMiddlewareDateFormatter(final String pattern, final Locale locale) {
		this.pattern = pattern;
		this.sdf = new SimpleDateFormat(pattern, locale);
	}

	/**
	 * Parse a given {@link String} into a {@link Date} and return the date value. It is used the defined pattern.
	 *
	 * @param text a String to parse
	 * @return the parsed date
	 */
	public Date parse(final String text) {
		try {
			return sdf.parse(text);
		} catch (final ParseException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.INVALID_ARGUMENT,
					String.format("Failed to parse Date value '%s' (format: '%s') ", text, pattern),
					e);

		}

	}

	/**
	 * Formats a Date into a date/time string.
	 *
	 * @param date the time value to be formatted into a time string.
	 * @return the formatted time string.
	 */
	public String format(final Date date) {
		return sdf.format(date);
	}

	/**
	 * Try to parse the given date string with given pattern.
	 *
	 * @param dateString date to check
	 * @param pattern pattern to check
	 * @return the parsed date or null;
	 */
	public static Date parseDate(final String dateString, final String pattern) {

		try {
			return DateUtils.parseDateStrictly(dateString, pattern);
		} catch (final ParseException e) {
			return null;
		}

	}

}
