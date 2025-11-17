/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightcalc;

/**
 * flight calculation process states.
 *
 * @author Ingo Rietzschel - U125742
 */
// TODO iri, alex: auflisten(und richtige Bezeichnung) und beschreiben
public enum FlightCalcProcessState {
	/** 0: noch nix passiert */
	ZERO(0),
	/** 1: die Master-Instanz hat den Job einer Instanz zugeordnet. In CINSTANCE steht dann die Instanz, der es zugeordnet wurde */
	ONE(1),
	/** 3: success */
	THREE(3),
	/**
	 * retry (der FlightCalc setzt diesen Status z.B., wenn noch eine Online Explosion läuft, die erst fertig werde muss. Bei m nächsten
	 * Lesen der Jobs werden diese dann wieder mitgelesen und nocheinmal versucht)
	 */
	FOUR(4),
	/** ignore job */
	SEVEN(7),
	/** Fehler */
	NINE(9);

	/** The integer value for current emum. */
	private int stateValue;

	FlightCalcProcessState(final int stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * Get stateValue
	 *
	 * @return the stateValue
	 */
	public int getStateValue() {
		return stateValue;
	}
}
