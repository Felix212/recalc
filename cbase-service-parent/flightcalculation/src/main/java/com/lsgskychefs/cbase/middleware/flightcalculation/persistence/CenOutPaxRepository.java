/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPaxId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link CenOutPax} entity.
 * Provides data access methods for flight PAX data.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutPaxRepository extends JpaRepository<CenOutPax, CenOutPaxId> {

	/**
	 * Find all PAX records for a flight by result key.
	 *
	 * @param resultKey Flight result key
	 * @return List of PAX records for the flight
	 */
	@Query("SELECT p FROM CenOutPax p WHERE p.id.nresultKey = :resultKey ORDER BY p.id.nclassNumber")
	List<CenOutPax> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find PAX record for a specific class.
	 *
	 * @param resultKey Flight result key
	 * @param classCode Class code
	 * @return Optional PAX record
	 */
	@Query("SELECT p FROM CenOutPax p WHERE p.id.nresultKey = :resultKey AND p.cclass = :classCode")
	Optional<CenOutPax> findByResultKeyAndClass(
			@Param("resultKey") Long resultKey,
			@Param("classCode") String classCode);

	/**
	 * Delete all PAX records for a flight.
	 *
	 * @param resultKey Flight result key
	 */
	@Query("DELETE FROM CenOutPax p WHERE p.id.nresultKey = :resultKey")
	void deleteByResultKey(@Param("resultKey") Long resultKey);
}
