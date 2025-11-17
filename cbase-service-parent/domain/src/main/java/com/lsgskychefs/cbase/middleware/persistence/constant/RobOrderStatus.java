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
public enum RobOrderStatus {
	/** 0 - Open */
	OPEN(0, "Open"),

	/** 2 - Done */
	DONE(1, "Done"),

	/** 3 - Deleted */
	DELETED(2, "Deleted");

	/** Contains mapping between the state integer value and {@link RobOrderStatus} */
	private static Map<Integer, RobOrderStatus> map;

	static {
		map = new HashMap<>();
		for (final RobOrderStatus label : RobOrderStatus.values()) {
			map.put(label.typeNumber, label);
		}
	}

	/** The value for the type. Is used in DB. */
	private int typeNumber;

	/** The state description */
	private String description;

	RobOrderStatus(final int typeNumber, final String description) {
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
	 * Get the corresponding RobOrderStatus.
	 *
	 * @param typeNumber type value
	 * @return the corresponding RobOrderStatus.
	 */
	public static RobOrderStatus getEnum(final int typeNumber) {
		final RobOrderStatus value = map.get(typeNumber);
		return value;
	}
}
