/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTrailDetail;

/**
 * All Workorder Trailpoint states in {@link CenOutPpmTrailDetail}.
 *
 * @author Alex Schaab - U524036
 * @see CenOutPpmTrailDetail#getNstatus()
 */
public enum TrailpointState {
	/**
	 * nicht relevant hat keine Traildaten in den Stammdaten
	 */
	NOT_RELAVANT(null),
	/**
	 * initial (0) / in progress die SL war noch nicht am previous Trailpoint, is aber noch in time (white)
	 */
	INITIAL(0),
	/**
	 * real time bellow target time(10) die SL war schon am prev. Trailpoint und zwar in time (green)
	 */
	FINISHED_INTIME(10),
	/**
	 * target time exceeded by real time(20) die SL war schon am prev. Trailpoint und zwar zu spät (yellow)
	 */
	FINISHED_OVERDUE(20),
	/**
	 * current time would exceed the target time(30) die SL war noch nicht am previous Trailpoint, hätte da aber schon sein müssen (red)
	 */
	TOO_LATE(30);

	/** Enums as map, the state value is the key */
	private static Map<Integer, TrailpointState> map;

	static {
		map = new HashMap<>();
		for (final TrailpointState state : TrailpointState.values()) {
			map.put(state.stateValue, state);
		}
	}

	/** The integer value for this state */
	private Integer stateValue;

	/** Constructor */
	TrailpointState(final Integer stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * The value from current state. Is used in DB.
	 *
	 * @return the state value
	 */
	public Integer getStateValue() {
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
	 * Get the corresponding TrailpointState.
	 *
	 * @param stateValue state value
	 * @return the corresponding TrailpointState.
	 */
	public static TrailpointState getEnum(final Integer stateValue) {
		return TrailpointState.map.get(stateValue);
	}

}
