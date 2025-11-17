/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.flightcalc;

/**
 * The possible flight calculation functions. Who calls the service respectively how is calculated.
 *
 * @see SYS_QUEUE_FL_FUNCTIONS
 * @author Ingo Rietzschel - U125742
 */

public enum FlightCalcFunction {

	/** 1 - Process sys_queue_flight_calc */
	FLIGHT_CALC(1),
	/** 2 - Web, process cen_out, nqueued_release_interface=4 */
	WEB_CALC(2),
	/** 3 - Web A/C-Change, process cen_out, nqueued_release_interface=5 */
	WEB_CALCMC(3),
	/** 4 - Amos Spml, process cen_out, nqueued_release_interface=7 */
	AMOS_SPML(4),
	/** 6 - LCL-Flight, process sys_queue_flight_calc */
	LCL_FLIGHT(6),
	/** 7 - Obelisk - LCL-Flight, process sys_queue_flight_calc */
	OBELISK_LCL(7),
	/** 8 - flight delete */
	FLIGHT_DEL(8),
	/** 9 - BOB zuspielen */
	BOP_RECALC(9),
	/** 10 - Mealdistribution */
	MEAL_DISTRIB(10),
	/** 11 - Recalculation Flight, process sys_queue_flight_calc */
	RECALC(11),
	/** 12 - Meal + Additional Loading - The top off flight calculation function. */
	MEAL_ADDITIONAL(12),
	/** 13 - CFS-Flightcalc with Package/LOS discovery */
	CFS_FLIGHTCALC(13);

	/** the flight clac function value. */
	private int functionValue;

	FlightCalcFunction(final int functionValue) {
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
