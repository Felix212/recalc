/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightpricer;

/**
 * flight pricer process states.
 *
 * @author Alex Schaab
 */
public enum FlightPricerProcessState {
	/** unprocessed 0 */
	UNPROCESSED(0),
	/** allocated 1 */
	ALLOCATED(1),
	/** is working 2 */
	WORKING(2),
	/** finished processing 3 */
	FINISHED(3),
	/** ignored 8 */
	IGNORED(8),
	/** faulty 9 */
	FAULTY(9);

	/** The integer value for current enum. */
	private int stateValue;

	FlightPricerProcessState(final int stateValue) {
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
