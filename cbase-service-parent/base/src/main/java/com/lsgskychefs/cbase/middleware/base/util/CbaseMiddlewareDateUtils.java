/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.time.DurationFormatUtils;
import org.springframework.util.Assert;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;
import com.lsgskychefs.cbase.middleware.persistence.global.FormatConstants;

/**
 * Utility
 *
 * @author Alex Schaab
 */
public final class CbaseMiddlewareDateUtils {

	/** Constructor */
	private CbaseMiddlewareDateUtils() {
	}

	/**
	 * Adds the given time to existing date value.
	 *
	 * @param date existing date
	 * @param timeStr time to be added to date. e.g.'14:15'
	 * @return new date value
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} when time string could not be
	 *             parsed
	 */
	public static Date addTimeToDate(final Date date, final String timeStr) throws CbaseMiddlewareParsingException {

		Assert.notNull(date, "The date must not be null");
		Assert.notNull(timeStr, "The time string must not be null");

		LocalTime time;

		try {
			time = LocalTime.parse(timeStr);

			final Calendar c = Calendar.getInstance();
			c.setLenient(false);
			c.setTime(date);
			c.set(Calendar.HOUR_OF_DAY, time.getHour());
			c.set(Calendar.MINUTE, time.getMinute());
			c.set(Calendar.SECOND, time.getSecond());

			return c.getTime();

		} catch (final DateTimeParseException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"Given time sring could not be parsed", e);
		}

	}

	/**
	 * Calculates the time between the two given Dates.
	 *
	 * @param dateBefore the first date with time info
	 * @param dateAfter the second date with time info
	 * @return Time as String e.g. '03:30' in following format {@link FormatConstants#TIME_H_M}. '00:00' if dateAfter is less then
	 *         dateBefore
	 */
	public static String getTimeDifferenceAsString(final Date dateBefore, final Date dateAfter) {
		final String timeBefore;

		final LocalDateTime ldtBefore = LocalDateTime.ofInstant(dateBefore.toInstant(), ZoneId.systemDefault());
		final LocalDateTime ldtAfter = LocalDateTime.ofInstant(dateAfter.toInstant(), ZoneId.systemDefault());
		final Duration timeDifference = Duration.between(ldtBefore, ldtAfter);

		if (!timeDifference.isNegative()) {
			timeBefore = DurationFormatUtils.formatDuration(timeDifference.toMillis(), FormatConstants.TIME_H_M);
		} else {
			timeBefore = DurationFormatUtils.formatDuration(0, FormatConstants.TIME_H_M);
		}

		return timeBefore;
	}

	/**
	 * Truncates the time part of a date.
	 * 
	 * @param date the <code>Date</code> you want to truncate
	 * @return a new, truncated <code>Date</code> object
	 */
	public static Date truncate(final Date date) {
		final Calendar cal = Calendar.getInstance();

		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return new Date(cal.getTimeInMillis());
	}

}
