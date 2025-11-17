/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsConcept;

/**
 * Cen Sls Concepts state.
 *
 * @author Heiko Rothenbach - U009907
 * @see CenSlsConcept#getNstatus()
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CenSlsConceptState {
	/** First State when creating a concept (0) */
	CREATED(0),
	FINISHED(1),
	UNKNOWN(99);

	/** Enums as map, the state value is the key */
	private static Map<Integer, CenSlsConceptState> map;

	static {
		CenSlsConceptState.map = new HashMap<>();
		for (final CenSlsConceptState state : CenSlsConceptState.values()) {
			CenSlsConceptState.map.put(state.stateValue, state);
		}
	}

	/** The integer value for this state */
	private int stateValue;

	/** Constructor */
	CenSlsConceptState(final int stateValue) {
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
	public static CenSlsConceptState getEnum(final int stateValue) {
		final CenSlsConceptState value = CenSlsConceptState.map.get(stateValue);
		return value == null ? CenSlsConceptState.UNKNOWN : value;
	}

}
