/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * All calculation modes for packinglists. These values usually used on nreckoning or nbilling_status
 *
 * @author Alex Schaab - U524036
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PackinglistCalculationMode {
	BILLING_AND_PRODUCTION(0),
	PRODUCTION(1),
	BILLING(2),
	INFORMATION(3),
	ON_REQUEST(4),
	UNKNOWN(99);

	/** Enums as map, the state value is the key */
	private static Map<Integer, PackinglistCalculationMode> map;

	static {
		PackinglistCalculationMode.map = new HashMap<>();
		for (final PackinglistCalculationMode state : PackinglistCalculationMode.values()) {
			PackinglistCalculationMode.map.put(state.stateValue, state);
		}
	}

	/** The integer value for this state */
	private int stateValue;

	/** Constructor */
	PackinglistCalculationMode(final int stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * The value from current state. Is used in DB.
	 *
	 * @return the state value
	 */
	public int getStateValue() {
		return stateValue;
	}

	/**
	 * Returns the name of this enum constant, exactly as declared in its enum declaration.
	 *
	 * @return the name of this enum constant
	 */
	public String getName() {
		return name();
	}

	/**
	 * Get the corresponding CenOutStatus.
	 *
	 * @param stateValue state value
	 * @return the corresponding CenOutStatus.
	 */
	public static PackinglistCalculationMode getEnum(final int stateValue) {
		final PackinglistCalculationMode value = PackinglistCalculationMode.map.get(stateValue);
		return value == null ? PackinglistCalculationMode.UNKNOWN : value;
	}

}
