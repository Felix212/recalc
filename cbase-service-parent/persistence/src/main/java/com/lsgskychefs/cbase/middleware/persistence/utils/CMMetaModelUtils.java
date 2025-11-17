/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.utils;

import javax.persistence.metamodel.SingularAttribute;

import com.google.common.base.CaseFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject;

/**
 * Utility class for meta model.
 *
 * @author Ingo Rietzschel - U125742
 */
public final class CMMetaModelUtils {

	/** Constructor */
	private CMMetaModelUtils() {
	}

	/**
	 * Get the corresponding name for given Meta-Model-Attribute.<br>
	 * SingularAttribute<CenEuFlights, Integer> nservFlightNumber -> 'nserv_flight_number'
	 *
	 * @param key Meta-Model-Attribute
	 * @return the corresponding name
	 */
	public static String convertToUnderScore(final SingularAttribute<? extends DomainObject, ?> key) {
		return CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, key.getName());
	}

	/**
	 * Get the converted key for given camelCaseKey.<br>
	 * nservFlightNumber -> 'nserv_flight_number'
	 *
	 * @param camelCaseKey attribute name as String
	 * @return the corresponding Meta-Model-Attribute name
	 */
	public static String convertToUnderScore(final String camelCaseKey) {
		return CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, camelCaseKey);
	}

	/**
	 * Get the converted key for given under_score.<br>
	 * 'nserv_flight_number' -> 'nservFlightNumber'
	 *
	 * @param underScoredKey Meta-Model-Attribute name as String
	 * @return the corresponding attribute name
	 */
	public static String convertToCamelCase(final String underScoredKey) {
		return CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, underScoredKey);
	}

	/**
	 * Concatenate the given attributes with '.'.
	 *
	 * @param attributes the attributes
	 * @return the concatenated String.
	 */
	@SafeVarargs
	public static String cat(final SingularAttribute<? extends DomainObject, ?>... attributes) {
		final StringBuilder sb = new StringBuilder();
		boolean addPoint = false;
		for (final SingularAttribute<? extends DomainObject, ?> singularAttribute : attributes) {
			if (addPoint) {
				sb.append('.');
			}
			sb.append(singularAttribute.getName());
			addPoint = true;
		}
		return sb.toString();
	}

}
