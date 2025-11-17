/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.portfolio;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.PortfolioItem;

/**
 * Portfolio items states
 * 
 * @author Paola Lera - U116198
 * @see PortfolioItem#getNstate()
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PortfolioItemConstants {

	/** Item States */
	CREATED(0),
	PUBLISHED(1),
	DELETED(2),
	UNKNOWN(99);

	/** Enums as map, the state value is the key */
	private static Map<Integer, PortfolioItemConstants> map;

	static {
		PortfolioItemConstants.map = new HashMap<>();
		for (final PortfolioItemConstants state : PortfolioItemConstants.values()) {
			PortfolioItemConstants.map.put(state.stateValue, state);
		}
	}

	/** The integer value for this state */
	private int stateValue;

	/** Constructor */
	PortfolioItemConstants(final int stateValue) {
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
	 * Get the corresponding item state.
	 *
	 * @param stateValue state value
	 * @return the corresponding item state.
	 */
	public static PortfolioItemConstants getEnum(final int stateValue) {
		final PortfolioItemConstants value = PortfolioItemConstants.map.get(stateValue);
		return value == null ? PortfolioItemConstants.UNKNOWN : value;
	}

}
