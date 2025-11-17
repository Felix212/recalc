/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

/**
 * The possible remote printer functions.
 * 
 * @see SYS_REMOTE_PRINTER_FUNC
 * @author Dirk Bunk - U200035
 */
public enum RemotePrinterFunction {
	PROD_LABEL_1(10),
	PROD_LABEL_1_INCREASE(11),
	PROD_LABEL_2(20),
	PROD_LABEL_2_INCREASE(21),
	RESERVE_LABEL(25),
	VPS_SHIFT_REPORT(30),
	EQUIPMENT_REPORT(40),
	TROLLEY_REPORT(50),
	TOUR_REPORT(55),
	CART_DIAGRAM(60),
	FOOD_PACKING_FLIGHTS(70),
	STD_PDF_REPORT(80),
	SPML_LABEL(90);

	/** the remote printer function value. */
	private long functionValue;

	RemotePrinterFunction(final long functionValue) {
		this.functionValue = functionValue;
	}

	/**
	 * Get functionValue
	 *
	 * @return the functionValue
	 */
	public long getFunctionValue() {
		return functionValue;
	}
}
