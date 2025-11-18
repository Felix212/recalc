/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenRotations;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.Optional;

/**
 * Repository for CEN_ROTATIONS table - routing/rotation configurations.
 *
 * <p>Rotations define the flight routes and are used to look up meal definitions.
 *
 * @author Migration Team
 */
@Repository
public interface CenRotationsRepository extends JpaRepository<CenRotations, Long> {

	/**
	 * Find rotation by routing plan detail key and validity date.
	 *
	 * <p>PowerBuilder equivalent: uf_match_rotation()
	 *
	 * @param routingDetailKey Routing plan detail key
	 * @param validityDate Date to check validity
	 * @return Rotation if found
	 */
	@Query("SELECT r FROM CenRotations r " +
			"WHERE r.nroutingDetailKey = :routingDetailKey " +
			"AND (r.dvalidFrom IS NULL OR r.dvalidFrom <= :validityDate) " +
			"AND (r.dvalidTo IS NULL OR r.dvalidTo >= :validityDate)")
	Optional<CenRotations> findByRoutingDetailKeyAndValidity(
			@Param("routingDetailKey") Long routingDetailKey,
			@Param("validityDate") Date validityDate);

	/**
	 * Find rotation by airline and route (city pair).
	 *
	 * @param airlineKey Airline key
	 * @param tlcFrom Origin TLC (three-letter code) key
	 * @param tlcTo Destination TLC key
	 * @param validityDate Date to check validity
	 * @return Rotation if found
	 */
	@Query("SELECT r FROM CenRotations r " +
			"WHERE r.nairlineKey = :airlineKey " +
			"AND r.ntlcFrom = :tlcFrom " +
			"AND r.ntlcTo = :tlcTo " +
			"AND (r.dvalidFrom IS NULL OR r.dvalidFrom <= :validityDate) " +
			"AND (r.dvalidTo IS NULL OR r.dvalidTo >= :validityDate)")
	Optional<CenRotations> findByAirlineAndRoute(
			@Param("airlineKey") Long airlineKey,
			@Param("tlcFrom") Long tlcFrom,
			@Param("tlcTo") Long tlcTo,
			@Param("validityDate") Date validityDate);
}
