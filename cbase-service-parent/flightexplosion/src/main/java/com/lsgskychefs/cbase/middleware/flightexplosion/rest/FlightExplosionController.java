/*
 * SalesController.java
 *
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.rest.AbstractCbaseMiddlewareController;
import com.lsgskychefs.cbase.middleware.flightexplosion.business.FlightExplosionService;

/**
 * This class provides a REST interface for interacting with the {@link FlightExplosionService}.
 *
 * @author Dirk Bunk - U200035
 */
@RestController
@RequestMapping(FlightExplosionInterfaceRoot.FLIGHT_EXPLOSION_API_ROOT)
public class FlightExplosionController extends AbstractCbaseMiddlewareController {
	/** The {@link FlightExplosionService} that interacts with the underlying database repositories */
	@Autowired
	private FlightExplosionService flightExplosionService;

	/**
	 * Explodes one specific flight and stores the results in cen_out_master (if needed)
	 * 
	 * @param nresultKey the key of the flight to explode
	 * @param getNewDetailKey set to <code>true</code> to get a new value for plDetailKey
	 * @return the explosion data as list of <code>ExplodedPackinglistEntry</code>
	 * @throws CbaseMiddlewareBusinessException
	 */
	@RequestMapping(method = RequestMethod.POST, value = FlightExplosionInterfaceRoot.EXPLODE)
	public void explodeFlight(
			@PathVariable final Long nresultKey,
			@RequestParam(required = false, defaultValue = "false") final boolean getNewDetailKey) throws CbaseMiddlewareBusinessException {
		flightExplosionService.explodeFlight(nresultKey, getNewDetailKey);
	}
}
