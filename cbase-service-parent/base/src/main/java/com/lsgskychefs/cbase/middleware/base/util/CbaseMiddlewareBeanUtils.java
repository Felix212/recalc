/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.util;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;

/**
 * Utils class for bean operations.
 *
 * @author Ingo Rietzschel - U125742
 */
public final class CbaseMiddlewareBeanUtils {

	/** Constructor */
	private CbaseMiddlewareBeanUtils() {
	}

	/**
	 * <p>
	 * Copy property values from the origin bean to the destination bean for all cases where the property names are the same.
	 * </p>
	 * <p>
	 * For more details see <code>BeanUtilsBean</code>.
	 * </p>
	 *
	 * @param dest Destination bean whose properties are modified
	 * @param orig Origin bean whose properties are retrieved
	 * @exception IllegalAccessException if the caller does not have access to the property accessor method
	 * @exception @see BeanUtils#copyProperties
	 */
	public static void copyProperties(final Object dest, final Object orig) {
		try {
			BeanUtils.copyProperties(dest, orig);
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN,
					String.format("Error on copy property from '%s' to '%s' !", orig.getClass(), dest.getClass()), e);
		}
	}
}
