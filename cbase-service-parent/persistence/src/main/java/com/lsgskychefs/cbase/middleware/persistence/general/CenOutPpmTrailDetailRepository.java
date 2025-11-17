/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmTrailDetail;

/**
 * Repository class for {@link CenOutPpmTrailDetail}
 *
 * @author Alex Schaab - U524036
 */
public interface CenOutPpmTrailDetailRepository extends PagingAndSortingRepository<CenOutPpmTrailDetail, Long> {

	/**
	 * Get Trailpoint details for Tracking flight readiness
	 * 
	 * @param flight the PPM flight
	 * @param npackinglistIndexKey the packinglist id
	 * @param cclass the class
	 * @param ntrailpointKey the trailpoint id
	 * @return trailpoint details
	 */
	CenOutPpmTrailDetail findByCenOutPpmTrailCenOutPpmFlightsAndCenOutPpmTrailNplIndexKeyAndCenOutPpmTrailCclassAndNtrailpointKey(
			final CenOutPpmFlights flight, final Long npackinglistIndexKey, final String cclass, final Long ntrailpointKey);

	/**
	 * Get Trailpoint details for Tracking flight readiness
	 * 
	 * @param flight the PPM flight
	 * @param npackinglistIndexKey the packinglist id
	 * @param ntrailpointKey the trailpoint id
	 * @return trailpoint details
	 */
	List<CenOutPpmTrailDetail> findByCenOutPpmTrailCenOutPpmFlightsAndCenOutPpmTrailNplIndexKeyAndNtrailpointKey(
			final CenOutPpmFlights flight, final Long npackinglistIndexKey, final Long ntrailpointKey);

	/**
	 * Get Trailpoint details for Tracking flight and Trailpoint
	 * 
	 * @param flight
	 * @param ctrailpoint
	 * @return trailpoint details
	 */
	List<CenOutPpmTrailDetail> findByCenOutPpmTrailCenOutPpmFlightsAndCtrailpoint(
			final CenOutPpmFlights flight, final String ctrailpoint);

	/**
	 * Get Trailpoint details for Tracking Trolley and Trailpoint
	 * 
	 * @param ntrailpointKey the trailpoint id
	 * @param nppmTrolleyKey the trolley id
	 * @return
	 */
	List<CenOutPpmTrailDetail>
			findByNtrailpointKeyAndCenOutPpmPrLabDtlTpsCenOutPpmPrLabDetailCenOutPpmProdLabelCenOutPpmTrolleyNppmTrolleyKey(
					final Long ntrailpointKey, final Long nppmTrolleyKey);

	/**
	 * Get Trailpoint details for Flight and Packinglist
	 * 
	 * @param flight
	 * @param npackinglistIndexKey
	 * @return
	 */
	List<CenOutPpmTrailDetail> findByCenOutPpmTrailCenOutPpmFlightsAndCenOutPpmTrailNplIndexKeyOrderByDplannedReadyTimeDesc(
			final CenOutPpmFlights flight, final Long npackinglistIndexKey);
}
