/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAircraftCompartments;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_AIRCRAFT_COMPARTMENTS table - aircraft cabin compartments.
 *
 * <p>Stores compartment configurations including service class assignments,
 * positions, and capacities for each aircraft type.
 *
 * @author Migration Team
 */
@Repository
public interface CenAircraftCompartmentsRepository extends JpaRepository<CenAircraftCompartments, Long> {

	/**
	 * Find all compartments for an aircraft.
	 *
	 * @param aircraftKey The aircraft key
	 * @return List of compartments ordered by position
	 */
	@Query("SELECT c FROM CenAircraftCompartments c " +
			"WHERE c.naircraftKey = :aircraftKey " +
			"ORDER BY c.nposition ASC")
	List<CenAircraftCompartments> findByAircraftKey(@Param("aircraftKey") Long aircraftKey);

	/**
	 * Find compartments for a specific service class.
	 *
	 * @param aircraftKey The aircraft key
	 * @param classCode The service class code (F, C, Y, etc.)
	 * @return List of compartments for this class
	 */
	@Query("SELECT c FROM CenAircraftCompartments c " +
			"WHERE c.naircraftKey = :aircraftKey " +
			"AND c.cclass = :classCode " +
			"ORDER BY c.nposition ASC")
	List<CenAircraftCompartments> findByAircraftKeyAndClass(
			@Param("aircraftKey") Long aircraftKey,
			@Param("classCode") String classCode);

	/**
	 * Find compartment by position.
	 *
	 * @param aircraftKey The aircraft key
	 * @param position The compartment position
	 * @return List of matching compartments
	 */
	@Query("SELECT c FROM CenAircraftCompartments c " +
			"WHERE c.naircraftKey = :aircraftKey " +
			"AND c.nposition = :position")
	List<CenAircraftCompartments> findByAircraftKeyAndPosition(
			@Param("aircraftKey") Long aircraftKey,
			@Param("position") int position);
}
