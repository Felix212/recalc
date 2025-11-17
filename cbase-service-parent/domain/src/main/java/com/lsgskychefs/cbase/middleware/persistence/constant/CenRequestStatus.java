/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All CenRequest process status types.
 * 
 * @author Alex Schaab - U524036
 */


public enum CenRequestStatus {
	/** -1 - so far unknown process status type */
	UNKNOWN(-1, "Unknown"),
	
	/** 0 - Open */
	OPEN(0, "Open"),

	/** 1 - In Pogress */
	IN_PROGRESS(1, "In Pogress"),
	
	/** 2 - DONE */
	DONE(2, "Done"),

	/** 3 - Failed */
	FAILED(3, "Failed");

	/** Contains mapping between the state integer value and {@link CenRequestStatus} */
	private static Map<Integer, CenRequestStatus> map;

	static {
		map = new HashMap<>();
		for (final CenRequestStatus label : CenRequestStatus.values()) {
			map.put(label.typeNumber, label);
		}
	}

	/** The value for the type. Is used in DB. */
	private int typeNumber;

	/** The state description */
	private String description;

	CenRequestStatus(final int typeNumber, final String description) {
		this.typeNumber = typeNumber;
		this.description = description;
	}

	/**
	 * The value from current type. Is used in DB.
	 *
	 * @return the state value
	 */
	public int getValue() {
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
	public static CenRequestStatus getEnum(final int typeNumber) {
		final CenRequestStatus value = map.get(typeNumber);
		return value == null ? CenRequestStatus.UNKNOWN : value;
	}
}
