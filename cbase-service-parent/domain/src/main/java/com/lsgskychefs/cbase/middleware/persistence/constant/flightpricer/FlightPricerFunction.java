/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightpricer;

/**
 * The possible flight pricer functions.
 *
 * @author Alex Schaab
 */
public enum FlightPricerFunction {

	/** TODO: Alex Bezeichnung einholen */
	ONE(1);

	/** the flight pricer function value. */
	private int functionValue;

	FlightPricerFunction(final int functionValue) {
		this.functionValue = functionValue;
	}

	/**
	 * Get functionValue
	 *
	 * @return the functionValue
	 */
	public int getFunctionValue() {
		return functionValue;
	}

}
