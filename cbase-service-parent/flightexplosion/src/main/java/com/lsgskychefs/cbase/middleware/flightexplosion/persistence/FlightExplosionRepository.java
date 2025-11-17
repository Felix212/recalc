/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.persistence;

import java.util.Date;
import java.util.List;

import javax.persistence.TemporalType;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.FlightLoadingEntry;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.IsoOffsetEntry;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.PackinglistExplosionDetailEntry;
import com.lsgskychefs.cbase.middleware.flightexplosion.pojo.PackinglistExplosionDetailParameter;
import com.lsgskychefs.cbase.middleware.persistence.CbaseMiddlewareRepository;
import com.lsgskychefs.cbase.middleware.persistence.query.CbaseMiddlewareNativeQuery;
import com.lsgskychefs.cbase.middleware.persistence.query.CbaseMiddlewareQuery;

/**
 * Common repository class. For special query/jpa functionality.
 *
 * @author Dirk Bunk - U200035
 */
@Repository
public class FlightExplosionRepository extends CbaseMiddlewareRepository {
	/** query for flight loadings loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('flight-loading-query.sql')}")
	private CbaseMiddlewareNativeQuery flightLoadingQuery;

	/** query for packinglist explosion details loaded and inject as String. */
	@Value("#{fileHelper.getSqlQuery('packinglist-explosion-detail-query.sql')}")
	private CbaseMiddlewareNativeQuery packinglistExplosionDetailQuery;

	/** query for iso offset and inject as String. */
	@Value("#{fileHelper.getSqlQuery('iso-offset-query.sql')}")
	private CbaseMiddlewareNativeQuery isoOffsetQuery;

	/**
	 * Gets the exploded flight loading data.
	 * 
	 * @param resultKey the result key of the flight to explode
	 * @param refDate reference date
	 * @param refTime reference time
	 * @param handlingId <code>1</code>: Standard Loading <code>2</code>: Supplemental Loading
	 * @param llExclude set to <code>true</code> to exclude loadinglists that are defined in loc_unit_ll_exclude
	 * @param unit only needed if llExclude is set to <code>1</code>
	 * @return the exploded flight loading data
	 */
	public List<FlightLoadingEntry> findFlightLoading(
			final Long resultKey,
			final Date refDate,
			final String refTime,
			final Integer handlingId,
			final Boolean llExclude,
			final String unit) {
		final CbaseMiddlewareQuery<FlightLoadingEntry> query =
				nativeQueryProvider.createNativeQuery(flightLoadingQuery, FlightLoadingEntry.class)
						.setParameter(ARG_RESULT_KEY, resultKey)
						.setParameter("arg_reference_date", refDate)
						.setParameter("arg_reference_time", refTime)
						.setParameter("arg_handling_id", handlingId)
						.setParameter("arg_ll_exclude", llExclude ? 1 : 0)
						.setParameter("arg_unit", unit);
		return query.getResultList();
	}

	/**
	 * Load the explosion detail entries.
	 * 
	 * @param param the parameter values
	 * @return the explosion detail entries
	 */
	public List<PackinglistExplosionDetailEntry> findPackinglistExplosionDetailData(final PackinglistExplosionDetailParameter param) {
		final CbaseMiddlewareQuery<PackinglistExplosionDetailEntry> query =
				nativeQueryProvider.createNativeQuery(packinglistExplosionDetailQuery, PackinglistExplosionDetailEntry.class)
						.setParameter(ARG_RESULT_KEY, param.getResultKey())
						.setParameter(ARG_DATE, param.getRefDate(), TemporalType.TIMESTAMP)
						.setParameter(ARG_CSC, param.getCsc())
						.setParameter(ARG_INDEX, param.getIndexKeys().toArray())
						.setParameter("arg_airline_key", param.getAirlineKey())
						.setParameter("arg_calc_date", param.getCalcDate(), TemporalType.TIMESTAMP)
						.setParameter("arg_calc_time", param.getCalcTime())
						.setParameter("arg_iso_offset", param.getIsoOffset())
						.setParameter("arg_check_boarding_unit", param.isCheckBoardingUnit() ? 1 : 0);
		return query.getResultList();
	}

	/**
	 * Calculates the ISO offset (in days).
	 * 
	 * @return
	 */
	public int getIsoOffset() {
		final CbaseMiddlewareQuery<IsoOffsetEntry> query =
				nativeQueryProvider.createNativeQuery(isoOffsetQuery, IsoOffsetEntry.class);
		return query.getResultList().get(0).getIsoOffset();
	}
}
