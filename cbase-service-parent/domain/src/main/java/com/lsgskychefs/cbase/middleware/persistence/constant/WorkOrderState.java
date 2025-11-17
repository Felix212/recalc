/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpm;

/**
 * All Workorder states.
 *
 * @author Ingo Rietzschel - U125742
 * @see CenOutPpm#getNstatus()
 */
public enum WorkOrderState {
	/** 5 - Workorder is locked for start batch. */
	LOCKED(5, "batch locked"),
	/** 0 - Workorder is open(batch can started - OPEN/SCHEDULED) */
	UNLOCKED(0, "batch can started - OPEN/SCHEDULED"),
	/** 10 - Workorder is in progress(batch run/prod. started) */
	IN_PROGRESS(10, "batch run/production started"),
	/** 20 - Workorder is done(batch ended). */
	DONE(20, "batch finished"),
	/** 30 - Workorder(Batch) is approved(reviewed) */
	APPROVED(30, "reviewed"),
	/** so far unknown state */
	UNKNOWN(Integer.MIN_VALUE, "unknown");

	/** Contains mapping between the state integer value and {@link WorkOrderState} */
	private static Map<Integer, WorkOrderState> map;

	static {
		map = new HashMap<>();
		for (final WorkOrderState state : WorkOrderState.values()) {
			map.put(state.stateValue, state);
		}
	}

	/** The value from current state. Is used in DB. */
	private int stateValue;

	/** The state description */
	private String description;

	WorkOrderState(final int stateValue, final String description) {
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
	 * Get the corresponding WorkOrderState.
	 *
	 * @param stateValue state value
	 * @return the corresponding WorkOrderState.
	 */
	public static WorkOrderState getEnum(final int stateValue) {
		final WorkOrderState value = map.get(stateValue);
		return value == null ? WorkOrderState.UNKNOWN : value;
	}

}
