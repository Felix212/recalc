/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link CenOutSpml} entity.
 * Provides data access methods for flight SPML (special meal) data.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutSpmlRepository extends JpaRepository<CenOutSpml, Long> {

	/**
	 * Find all SPML records for a flight by result key.
	 *
	 * @param resultKey Flight result key
	 * @return List of SPML records for the flight
	 */
	@Query("SELECT s FROM CenOutSpml s WHERE s.nresultKey = :resultKey ORDER BY s.nclassNumber, s.nprio")
	List<CenOutSpml> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find SPML record for a specific class and SPML code.
	 *
	 * @param resultKey Flight result key
	 * @param classCode Class code
	 * @param spmlCode SPML code (e.g., 'VGML', 'HNML')
	 * @return Optional SPML record
	 */
	@Query("SELECT s FROM CenOutSpml s WHERE s.nresultKey = :resultKey " +
			"AND s.cclass = :classCode AND s.cspml = :spmlCode")
	Optional<CenOutSpml> findByResultKeyAndClassAndCode(
			@Param("resultKey") Long resultKey,
			@Param("classCode") String classCode,
			@Param("spmlCode") String spmlCode);

	/**
	 * Find all SPML records for a specific class.
	 *
	 * @param resultKey Flight result key
	 * @param classCode Class code
	 * @return List of SPML records for the class
	 */
	@Query("SELECT s FROM CenOutSpml s WHERE s.nresultKey = :resultKey AND s.cclass = :classCode " +
			"ORDER BY s.nprio")
	List<CenOutSpml> findByResultKeyAndClass(
			@Param("resultKey") Long resultKey,
			@Param("classCode") String classCode);

	/**
	 * Delete all SPML records for a flight.
	 *
	 * @param resultKey Flight result key
	 */
	@Query("DELETE FROM CenOutSpml s WHERE s.nresultKey = :resultKey")
	void deleteByResultKey(@Param("resultKey") Long resultKey);
}
