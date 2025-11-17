/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAircraftGalleys;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_AIRCRAFT_GALLEYS table - aircraft galley configurations.
 *
 * <p>Stores galley positions, codes, and capacities for each aircraft type.
 * Used for meal layout generation and capacity planning.
 *
 * @author Migration Team
 */
@Repository
public interface CenAircraftGalleysRepository extends JpaRepository<CenAircraftGalleys, Long> {

	/**
	 * Find all galleys for an aircraft.
	 *
	 * @param aircraftKey The aircraft key
	 * @return List of galleys ordered by position
	 */
	@Query("SELECT g FROM CenAircraftGalleys g " +
			"WHERE g.naircraftKey = :aircraftKey " +
			"ORDER BY g.ngalleyPosition ASC")
	List<CenAircraftGalleys> findByAircraftKey(@Param("aircraftKey") Long aircraftKey);

	/**
	 * Find galley by code and aircraft.
	 *
	 * @param aircraftKey The aircraft key
	 * @param galleyCode The galley code
	 * @return List of matching galleys
	 */
	@Query("SELECT g FROM CenAircraftGalleys g " +
			"WHERE g.naircraftKey = :aircraftKey " +
			"AND g.cgalleyCode = :galleyCode")
	List<CenAircraftGalleys> findByAircraftKeyAndCode(
			@Param("aircraftKey") Long aircraftKey,
			@Param("galleyCode") String galleyCode);

	/**
	 * Find galleys by position range.
	 *
	 * @param aircraftKey The aircraft key
	 * @param minPosition Minimum position
	 * @param maxPosition Maximum position
	 * @return List of galleys in position range
	 */
	@Query("SELECT g FROM CenAircraftGalleys g " +
			"WHERE g.naircraftKey = :aircraftKey " +
			"AND g.ngalleyPosition BETWEEN :minPosition AND :maxPosition " +
			"ORDER BY g.ngalleyPosition ASC")
	List<CenAircraftGalleys> findByAircraftKeyAndPositionRange(
			@Param("aircraftKey") Long aircraftKey,
			@Param("minPosition") int minPosition,
			@Param("maxPosition") int maxPosition);
}
