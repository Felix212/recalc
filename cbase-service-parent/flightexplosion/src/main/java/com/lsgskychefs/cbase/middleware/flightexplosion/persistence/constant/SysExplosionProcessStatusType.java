/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All SysExplosion process status types.
 * 
 * @author Dirk Bunk - U200035
 */
public enum SysExplosionProcessStatusType {
	/** -1 - so far unknown process status type */
	UNKNOWN(-1, "Unknown"),

	/** 0 - Open */
	OPEN(0, "Open"),

	/** 1 - Assigned */
	ASSIGNED(1, "Assigned"),

	/** 2 - Started */
	STARTED(2, "Started"),

	/** 3 - Done */
	DONE(3, "Done"),

	/** 8 - Duplicated */
	DUPLICATED(8, "Duplicated"),

	/** 9 - Failed */
	FAILED(9, "Failed");

	/** Contains mapping between the state integer value and {@link SysExplosionProcessStatusType} */
	private static Map<Integer, SysExplosionProcessStatusType> map;

	static {
		map = new HashMap<>();
		for (final SysExplosionProcessStatusType label : SysExplosionProcessStatusType.values()) {
			map.put(label.typeNumber, label);
		}
	}

	/** The value for the type. Is used in DB. */
	private int typeNumber;

	/** The state description */
	private String description;

	SysExplosionProcessStatusType(final int typeNumber, final String description) {
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
	public static SysExplosionProcessStatusType getEnum(final int typeNumber) {
		final SysExplosionProcessStatusType value = map.get(typeNumber);
		return value == null ? SysExplosionProcessStatusType.UNKNOWN : value;
	}
}
