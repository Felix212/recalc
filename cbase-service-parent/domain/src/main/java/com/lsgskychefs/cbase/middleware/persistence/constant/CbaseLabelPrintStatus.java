/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * Possible printing status for labels.
 * 
 * @author Dirk Bunk - U200035
 */
public enum CbaseLabelPrintStatus {
	/** -1 - so far unknown state */
	UNKNOWN(-1, "Unknown"),

	/** 0 - Not printed */
	NOT_PRINTED(0, "Not printed"),

	/** 1 - Printed */
	PRINTED(1, "Printed");

	/** Contains mapping between the status integer value and {@link CbaseLabelPrintStatus} */
	private static Map<Integer, CbaseLabelPrintStatus> map;

	static {
		map = new HashMap<>();
		for (final CbaseLabelPrintStatus label : CbaseLabelPrintStatus.values()) {
			map.put(label.statusNumber, label);
		}
	}

	/** The value for the status. Is used in DB. */
	private int statusNumber;

	/** The state description */
	private String description;

	CbaseLabelPrintStatus(final int statusNumber, final String description) {
		this.statusNumber = statusNumber;
		this.description = description;
	}

	/**
	 * The value from current status. Is used in DB.
	 *
	 * @return the status value
	 */
	public int getStatusValue() {
		return statusNumber;
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
	 * Get the corresponding CbaseLabelPrintStatus.
	 *
	 * @param statusNumber status value
	 * @return the corresponding CbaseLabelPrintStatus.
	 */
	public static CbaseLabelPrintStatus getEnum(final int statusNumber) {
		final CbaseLabelPrintStatus value = map.get(statusNumber);
		return value == null ? CbaseLabelPrintStatus.UNKNOWN : value;
	}
}
