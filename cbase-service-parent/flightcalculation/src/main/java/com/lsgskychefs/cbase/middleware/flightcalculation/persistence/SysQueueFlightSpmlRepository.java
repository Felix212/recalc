/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpml;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightSpmlId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for {@link SysQueueFlightSpml} entity.
 * Provides access to SPML (Special Meals) data changes in the job queue.
 *
 * @author Migration Team
 */
@Repository
public interface SysQueueFlightSpmlRepository extends JpaRepository<SysQueueFlightSpml, SysQueueFlightSpmlId> {

	/**
	 * Find all SPML changes for a specific job.
	 *
	 * @param jobNr Job number
	 * @return List of SPML changes
	 */
	@Query("SELECT s FROM SysQueueFlightSpml s WHERE s.id.njobNr = :jobNr ORDER BY s.cclass, s.cspmlCode")
	List<SysQueueFlightSpml> findByJobNr(@Param("jobNr") Long jobNr);

	/**
	 * Find SPML change by job, class, and SPML code.
	 *
	 * @param jobNr Job number
	 * @param classCode Class code
	 * @param spmlCode SPML code
	 * @return SPML change
	 */
	@Query("SELECT s FROM SysQueueFlightSpml s " +
			"WHERE s.id.njobNr = :jobNr " +
			"AND s.cclass = :classCode " +
			"AND s.cspmlCode = :spmlCode")
	SysQueueFlightSpml findByJobNrAndClassAndSpml(
			@Param("jobNr") Long jobNr,
			@Param("classCode") String classCode,
			@Param("spmlCode") String spmlCode);

	/**
	 * Delete all SPML changes for a job.
	 *
	 * @param jobNr Job number
	 */
	void deleteByIdNjobNr(Long jobNr);
}
