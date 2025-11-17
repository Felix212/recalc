/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All Flight Change states.
 *
 * @author Kostadin Kostov - U140907
 * @see CenOutPpmFlights#getNacTimeChange()
 */
public enum FlightChangeState {
	/** 0 - Nothing changed */
	UNCHANGED(0, "nothing changed"),
	/** 1 - Departure changed */
	DEPARTURE_CHANGED(1, "departure changed"),
	/** 2 - Aircraft changed */
	AIRCRAFT_CHANGED(2, "aircraft changed"),
	/** 3 - Departure and Aircraft changed */
	DEPARTURE_AND_AIRCRAFT_CHANGED(3, "departure and aircraft changed"),
	/** so far unknown state */
	UNKNOWN(Integer.MIN_VALUE, "unknown");
	
	/** Contains mapping between the state integer value and {@link FlightChangeState} */
	private static Map<Integer, FlightChangeState> map;

	static {
		map = new HashMap<>();
		for (final FlightChangeState state : FlightChangeState.values()) {
			map.put(state.stateValue, state);
		}
	}

	/** The value from current state. Is used in DB. */
	private int stateValue;

	/** The state description */
	private String description;

	FlightChangeState(final int stateValue, final String description) {
		this.stateValue = stateValue;
		this.description = description;
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
	 * Get description
	 *
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * Get the corresponding FlightChangeState.
	 *
	 * @param stateValue state value
	 * @return the corresponding FlightChangeState.
	 */
	public static FlightChangeState getEnum(final int stateValue) {
		final FlightChangeState value = map.get(stateValue);
		return value == null ? FlightChangeState.UNKNOWN : value;
	}

}
