/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightcalc;

/**
 * Possible flight clac modifier.
 *
 * @author Ingo Rietzschel - U125742
 */
// TODO iri, alex: auflisten(und richtige Bezeichnung) und beschreiben
public enum FlightCalcModifier {
	/** processed */
	PROCESSED("processed"),
	/** requested by Top Off App */
	TOP_OFF("requested by Top Off App");

	/** The value for current enum. */
	private String modifierValue;

	FlightCalcModifier(final String modifierValue) {
		this.modifierValue = modifierValue;
	}

	/**
	 * Get modifierValue
	 *
	 * @return the modifierValue
	 */
	public String getModifierValue() {
		return modifierValue;
	}
}
