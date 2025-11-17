/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All CBASE reckoning types.
 * 
 * @author Dirk Bunk - U200035
 */
public enum CbaseReckoningType {
	/** -1 - so far unknown reckoning type */
	UNKNOWN(-1, "Unknown"),

	/** 0 - Billing and Production */
	BILLING_AND_PRODUCTION(0, "Billing and Production"),

	/** 1 - Production */
	PRODUCTION(1, "Production"),

	/** 2 - Billing */
	BILLING(2, "Billing"),

	/** 3 - Information */
	INFORMATION(3, "Information"),

	/** 4 - Request */
	REQUEST(4, "Request");

	/** Contains mapping between the state integer value and {@link CbaseReckoningType} */
	private static Map<Integer, CbaseReckoningType> map;

	static {
		map = new HashMap<>();
		for (final CbaseReckoningType label : CbaseReckoningType.values()) {
			map.put(label.typeNumber, label);
		}
	}

	/** The value for the type. Is used in DB. */
	private int typeNumber;

	/** The state description */
	private String description;

	CbaseReckoningType(final int typeNumber, final String description) {
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
	 * Get the corresponding CbaseReckoningType.
	 *
	 * @param typeNumber type value
	 * @return the corresponding CbaseReckoningType.
	 */
	public static CbaseReckoningType getEnum(final int typeNumber) {
		final CbaseReckoningType value = map.get(typeNumber);
		return value == null ? CbaseReckoningType.UNKNOWN : value;
	}
}
