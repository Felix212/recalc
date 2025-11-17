/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightcalc;

/**
 * If the flight calculator service use history dato or current.
 *
 * @author Ingo Rietzschel - U125742
 */
// TODO iri, alex: auflisten(und richtige Bezeichnung) und beschreiben
public enum FlightCalcHistory {
	/** Info for flight calculator service to use history data */
	USE_HISTORY_DATA(1);

	/** value for current enum */
	private int historyValue;

	/** Constructor */
	FlightCalcHistory(final int historyValue) {
		this.historyValue = historyValue;
	}

	/**
	 * Get historyValue
	 *
	 * @return the historyValue
	 */
	public int getHistoryValue() {
		return historyValue;
	}
}
