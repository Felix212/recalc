/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOut;

/**
 * All cen out states ({@link CenOut#getNstatus()}).
 *
 * @author Ingo Rietzschel - U125742
 */
public enum CenOutState {

	/** 0 - flight is currently processed */
	LOCKED(0, true),
	/** 1- created/generated (system) */
	GENERATED(1, true),
	/** 2 - updated (system) */
	UPDATED(2, true),
	/** 3 - edited manually */
	MANUAL(3, false),
	/** 4 - production state one */
	PROD_ONE(4, false),
	/** 5 - Prod Stat 2 */
	PROD_TWO(5, false),
	/** 6 - flight closed */
	FLIGHT_CLOSED(6, false),
	/** 7 - billed */
	BILLED(7, false),
	/** 8 - transmitted to billing system */
	TRANSFERED(8, false),
	/** so far unknown state */
	UNKNOWN(Integer.MIN_VALUE, true);

	/** Enums as map, the state value is the key */
	private static Map<Integer, CenOutState> map;

	static {
		map = new HashMap<>();
		for (final CenOutState state : CenOutState.values()) {
			map.put(state.stateValue, state);
		}
	}

	/** The value from current state. Is used in DB. */
	private int stateValue;

	/** if the state is handled by system or manually */
	private boolean system;

	/**
	 * Constructor
	 *
	 * @param stateValue the value of state
	 * @param system is handled by system or manually
	 */
	CenOutState(final int stateValue, final boolean system) {
		this.stateValue = stateValue;
		this.system = system;
	}

	/**
	 * The value from current state. Is used in DB.
	 *
	 * @return the stateValue
	 */
	public int getStateValue() {
		return stateValue;
	}

	/**
	 * if the state is handled by system or manually
	 *
	 * @return the isSystem
	 */
	public boolean isSystem() {
		return system;
	}

	/**
	 * Get the corresponding CenOutStatus.
	 *
	 * @param stateValue state value
	 * @return the corresponding CenOutStatus.
	 */
	public static CenOutState getEnum(final int stateValue) {
		final CenOutState value = map.get(stateValue);
		return value == null ? CenOutState.UNKNOWN : value;
	}

	/**
	 * Name and value as String "LOCKED-0"
	 *
	 * @return the name and value as String
	 */
	public String getNameAndValue() {
		return this.name() + "-" + stateValue;
	}
}
