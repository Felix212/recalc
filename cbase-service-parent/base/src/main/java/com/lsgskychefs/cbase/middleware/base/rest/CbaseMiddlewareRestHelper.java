/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.rest;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.LocaleUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.lsgskychefs.cbase.middleware.base.CbaseDefaultParameter;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;
import com.lsgskychefs.cbase.middleware.base.util.CbaseMiddlewareDateFormatter;

/**
 * Helper methods for rest get param
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareRestHelper implements Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CbaseMiddlewareRestHelper.class);

	/**
	 * Get the date pattern from request parameter or the default pattern.
	 *
	 * @param param The used parameter name
	 * @return the date pattern from request parameter or the default pattern.
	 */
	public String getParamValue(final CbaseDefaultParameter param) {
		String value = param.getDefaultValue();
		final HttpServletRequest request = getRequest(param);
		if (request != null) {
			final String paramValue = request.getParameter(param.getParamName());
			if (StringUtils.isNotBlank(paramValue)) {
				value = paramValue;
			}
		}

		return value;
	}

	/**
	 * Get the DateFormat, defined by request parameter or default pattern(format).
	 *
	 * @return the DateFormat with current pattern(format)
	 * @see CbaseMiddlewareRestHelper#getParamValue(CbaseDefaultParameter)
	 */
	public CbaseMiddlewareDateFormatter getDateTimeFormat() {
		final String datePattern = getParamValue(CbaseDefaultParameter.DATE_FORMAT);
		try {
			return new CbaseMiddlewareDateFormatter(datePattern, getLocale());
		} catch (final IllegalArgumentException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.INVALID_ARGUMENT, "wrong pattern", e);
		}

	}

	/**
	 * Get the DecimalFormat, defined by request parameter or default pattern(format).
	 *
	 * @return the DateFormat with current pattern(format)
	 * @see CbaseMiddlewareRestHelper#getParamValue(CbaseDefaultParameter)
	 */
	public DecimalFormat getNumberFormat() {
		DecimalFormat decimalFormat = (DecimalFormat) getRequestAttribute(CbaseDefaultParameter.BIG_DECIMAL_FORMAT);
		if (decimalFormat == null) {
			final String numberPattern = getParamValue(CbaseDefaultParameter.BIG_DECIMAL_FORMAT);
			final DecimalFormatSymbols cbaseDecimalFormatSymbols = new DecimalFormatSymbols();
			cbaseDecimalFormatSymbols.setDecimalSeparator(',');
			cbaseDecimalFormatSymbols.setGroupingSeparator('.');
			if (isDecimalPoint()) {
				cbaseDecimalFormatSymbols.setDecimalSeparator('.');
				cbaseDecimalFormatSymbols.setGroupingSeparator(',');
			}
			try {
				decimalFormat = new DecimalFormat(numberPattern);
				decimalFormat.setParseBigDecimal(true);
				decimalFormat.setDecimalFormatSymbols(cbaseDecimalFormatSymbols);

			} catch (final IllegalArgumentException e) {
				LOGGER.warn("Invalid numberPattern: " + numberPattern, e);
				decimalFormat = new DecimalFormat(CbaseDefaultParameter.BIG_DECIMAL_FORMAT.getDefaultValue());
			}
			// cache format per request
			setRequestAttribute(CbaseDefaultParameter.BIG_DECIMAL_FORMAT, decimalFormat);
		}
		return decimalFormat;

	}

	/**
	 * If the decimal separator is point or comma, defined by request parameter or false
	 *
	 * @return {@code true} if the decimal separator is a point, or {@code false} for comma.
	 */
	public boolean isDecimalPoint() {
		return Boolean.valueOf(getParamValue(CbaseDefaultParameter.USE_DECIMAL_POINT));
	}

	/**
	 * Checks if the Parameter useDecimalPoint is used
	 *
	 * @return {@code true} if the CbaseDefaultParameter.USE_DECIMAL_POINT is send in the request
	 */
	public boolean isDecimalPointParameterSet() {
		final HttpServletRequest request = getRequest(CbaseDefaultParameter.USE_DECIMAL_POINT);
		if (request != null) {
			final String paramValue = request.getParameter(CbaseDefaultParameter.USE_DECIMAL_POINT.getParamName());
			if (paramValue != null) {
				return true;
			}
			return false;

		}
		return false;
	}

	/**
	 * The locale, defined by request parameter or default
	 *
	 * @return the locale
	 */
	public Locale getLocale() {
		return LocaleUtils.toLocale(getParamValue(CbaseDefaultParameter.LOCALE));
	}

	/**
	 * Get request attribute value by given key.
	 *
	 * @param param the used key
	 * @return request attribute value
	 */
	private Object getRequestAttribute(final CbaseDefaultParameter param) {
		final HttpServletRequest request = getRequest(param);
		if (request != null) {
			return request.getAttribute(param.getParamName());
		}
		return null;
	}

	/**
	 * Set request attribute value under given key.
	 *
	 * @param param the used key
	 * @param obj the saved value
	 */
	private void setRequestAttribute(final CbaseDefaultParameter param, final Object obj) {
		final HttpServletRequest request = getRequest(param);
		if (request != null) {
			request.setAttribute(param.getParamName(), obj);
		}
	}

	/**
	 * Get current request.
	 *
	 * @param param only for log
	 * @return current request
	 */
	private HttpServletRequest getRequest(final CbaseDefaultParameter param) {
		try {
			final RequestAttributes currentRequestAttributes = RequestContextHolder.currentRequestAttributes();
			if (currentRequestAttributes instanceof ServletRequestAttributes) {
				return ((ServletRequestAttributes) currentRequestAttributes).getRequest();
			}

		} catch (final IllegalStateException e) {
			LOGGER.error("Can't get the parameter: " + param.name(), e);
		}
		return null;
	}

}
