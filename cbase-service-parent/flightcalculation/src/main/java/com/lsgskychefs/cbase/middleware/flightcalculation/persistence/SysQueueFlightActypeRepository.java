/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightActype;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link SysQueueFlightActype} entity.
 * Provides access to aircraft type change data in the job queue.
 *
 * @author Migration Team
 */
@Repository
public interface SysQueueFlightActypeRepository extends JpaRepository<SysQueueFlightActype, Long> {

	/**
	 * Find all aircraft type changes for a specific job.
	 *
	 * @param jobNr Job number
	 * @return List of aircraft changes (should be 0 or 1)
	 */
	@Query("SELECT a FROM SysQueueFlightActype a WHERE a.njobNr = :jobNr")
	List<SysQueueFlightActype> findByJobNr(@Param("jobNr") Long jobNr);

	/**
	 * Find first aircraft type change for a job.
	 *
	 * @param jobNr Job number
	 * @return Optional aircraft change
	 */
	@Query("SELECT a FROM SysQueueFlightActype a WHERE a.njobNr = :jobNr")
	Optional<SysQueueFlightActype> findFirstByJobNr(@Param("jobNr") Long jobNr);

	/**
	 * Delete all aircraft changes for a job.
	 *
	 * @param jobNr Job number
	 */
	void deleteByNjobNr(Long jobNr);
}
