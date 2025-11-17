/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.portfolio;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * Portfolio User Roles
 * 
 * @author Paola Lera - U116198
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PortfolioUserRoles {

	/** User Roles */
	READ(1),
	READ_WRITE(2),
	UNKNOWN(99);

	/** Enums as map, the state value is the key */
	private static Map<Integer, PortfolioUserRoles> map;

	static {
		PortfolioUserRoles.map = new HashMap<>();
		for (final PortfolioUserRoles state : PortfolioUserRoles.values()) {
			PortfolioUserRoles.map.put(state.stateValue, state);
		}
	}

	/** The integer value for this state */
	private int stateValue;

	/** Constructor */
	PortfolioUserRoles(final int stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * The value from current state.
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
	 * Get the corresponding user role.
	 *
	 * @param stateValue state value
	 * @return the corresponding user role.
	 */
	public static PortfolioUserRoles getEnum(final int stateValue) {
		final PortfolioUserRoles value = PortfolioUserRoles.map.get(stateValue);
		return value == null ? PortfolioUserRoles.UNKNOWN : value;
	}

}
