/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPax;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightPaxId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for {@link SysQueueFlightPax} entity.
 * Provides access to PAX data changes in the job queue.
 *
 * @author Migration Team
 */
@Repository
public interface SysQueueFlightPaxRepository extends JpaRepository<SysQueueFlightPax, SysQueueFlightPaxId> {

	/**
	 * Find all PAX changes for a specific job.
	 *
	 * @param jobNr Job number
	 * @return List of PAX changes
	 */
	@Query("SELECT p FROM SysQueueFlightPax p WHERE p.id.njobNr = :jobNr ORDER BY p.cclass")
	List<SysQueueFlightPax> findByJobNr(@Param("jobNr") Long jobNr);

	/**
	 * Find PAX change by job and class.
	 *
	 * @param jobNr Job number
	 * @param classCode Class code
	 * @return PAX change for specific class
	 */
	@Query("SELECT p FROM SysQueueFlightPax p WHERE p.id.njobNr = :jobNr AND p.cclass = :classCode")
	SysQueueFlightPax findByJobNrAndClass(
			@Param("jobNr") Long jobNr,
			@Param("classCode") String classCode);

	/**
	 * Delete all PAX changes for a job.
	 *
	 * @param jobNr Job number
	 */
	void deleteByIdNjobNr(Long jobNr);
}
