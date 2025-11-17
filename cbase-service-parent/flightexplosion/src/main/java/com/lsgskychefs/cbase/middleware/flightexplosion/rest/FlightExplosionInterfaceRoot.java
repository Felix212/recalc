/*
 *SalesInterfaceRoot.java
 *
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.flightexplosion.rest;

import com.lsgskychefs.cbase.middleware.base.rest.RestInterfaceRoot;

/**
 * Class holding the context root for all REST API requests
 *
 * @author Dirk Bunk - U200035
 */
public final class FlightExplosionInterfaceRoot {

	/** The root context for the rest services of this module. */
	public static final String FLIGHT_EXPLOSION_API_ROOT = RestInterfaceRoot.REST_API_ROOT + "/flight-explosion";

	/* ########################################################################################### */

	/** path to explode a single flight and store results in cen_out_master */
	public static final String EXPLODE = "/explode/{nresultKey}";

	/**
	 * Private Constructor.
	 */
	private FlightExplosionInterfaceRoot() {
		// do nothing.
	}

}
