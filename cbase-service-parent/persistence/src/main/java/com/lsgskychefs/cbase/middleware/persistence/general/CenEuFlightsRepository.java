/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenEuFlights;

/**
 * Repository class for {@link CenEuFlights} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenEuFlightsRepository extends PagingAndSortingRepository<CenEuFlights, Long> {

	/**
	 * Get the EU-Flight or {@code null}.
	 *
	 * @param neuRegionKey the EU rigion key.
	 * @param cflightKey the flight key as String
	 * @return the EU flight or {@code null}
	 */
	CenEuFlights findByNeuRegionKeyAndCflightKey(long neuRegionKey, String cflightKey);

	/**
	 * Get the EU-Flight.
	 *
	 * @param cairline airline owner
	 * @param nflightNumber flight number
	 * @param csuffix flight suffix(a suffix or a blank)
	 * @param ddeparture departure date
	 * @return the flight
	 */
	CenEuFlights findByCairlineAndNflightNumberAndDdepartureAndCsuffix(String cairline, int nflightNumber, Date ddeparture, String csuffix);

	/**
	 * Get EU-Flight data by neuFlightsKey
	 * 
	 * @param neuFlightsKey, the eu flight key
	 * @return List of {@link CenEuFlights}
	 */
	List<CenEuFlights> findByNeuFlightsKey(final long neuFlightsKey);
}
