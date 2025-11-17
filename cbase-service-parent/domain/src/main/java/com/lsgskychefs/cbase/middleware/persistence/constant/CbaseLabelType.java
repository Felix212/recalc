/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All CBASE label types.
 * 
 * @author Dirk Bunk - U200035
 */
public enum CbaseLabelType {
	/** so far unknown state */
	UNKNOWN(0, "Unknown"),

	/** 1 - Flight Label */
	FLIGHT_LABEL(1, "Flight Label"),

	/** 2 - Prod. Label 1 */
	PROD_LABEL1(2, "Prod. Label 1"),

	/** 22 - Prod. Label 2 */
	PROD_LABEL2(22, "Prod. Label 2"),

	/** 222 - Reserve Label */
	RESERVE_LABEL(222, "Reserve Label"),

	/** 3 - Cart Diagram */
	CART_DIAGRAM(3, "Cart Diagram"),

	/** 4 - Spml Label */
	SPML_LABEL(4, "SPML Label"),

	/** 44 - Spml CO Label */
	SPML_CO_LABEL(44, "SPML CO Label"),

	/** 99 - Distribution Errors */
	DISTRIBUTION_ERRORS(99, "Distribution Errors");

	/** Contains mapping between the state integer value and {@link CbaseLabelType} */
	private static Map<Integer, CbaseLabelType> map;

	static {
		map = new HashMap<>();
		for (final CbaseLabelType label : CbaseLabelType.values()) {
			map.put(label.typeNumber, label);
		}
	}

	/** The value for the type. Is used in DB. */
	private int typeNumber;

	/** The state description */
	private String description;

	CbaseLabelType(final int typeNumber, final String description) {
		this.typeNumber = typeNumber;
		this.description = description;
	}

	/**
	 * The value from current type. Is used in DB.
	 *
	 * @return the state value
	 */
	public int getTypeValue() {
		return typeNumber;
	}

	/**
	 * Get description
	 *
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Get the corresponding CbaseLabelType.
	 *
	 * @param typeNumber type value
	 * @return the corresponding CbaseLabelType.
	 */
	public static CbaseLabelType getEnum(final int typeNumber) {
		final CbaseLabelType value = map.get(typeNumber);
		return value == null ? CbaseLabelType.UNKNOWN : value;
	}
}
