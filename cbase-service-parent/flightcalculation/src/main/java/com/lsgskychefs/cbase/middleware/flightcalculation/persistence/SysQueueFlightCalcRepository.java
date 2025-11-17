/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.LockModeType;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link SysQueueFlightCalc} entity.
 * Provides data access methods for flight calculation job queue.
 *
 * @author Migration Team
 */
@Repository
public interface SysQueueFlightCalcRepository extends JpaRepository<SysQueueFlightCalc, Long> {

	/**
	 * Find all pending jobs for a specific instance and functions.
	 * Jobs are ordered by process status, priority (nsort), and departure date.
	 *
	 * @param functions List of function IDs to process (-1 means all functions)
	 * @param instanceName Instance name
	 * @return List of pending flight calculation jobs
	 */
	@Query("SELECT j FROM SysQueueFlightCalc j " +
			"WHERE (j.cinstance = :instanceName OR j.cinstance IS NULL) " +
			"AND (j.nfunction IN :functions OR :processAll = true) " +
			"AND j.nprocessStatus IN (0, 1, 4) " +
			"ORDER BY j.nprocessStatus ASC, j.nsort ASC, j.ddeparture ASC")
	List<SysQueueFlightCalc> findPendingJobs(
			@Param("functions") List<Integer> functions,
			@Param("instanceName") String instanceName,
			@Param("processAll") boolean processAll);

	/**
	 * Find jobs assigned to a specific instance.
	 *
	 * @param instanceName Instance name
	 * @return List of jobs assigned to instance
	 */
	List<SysQueueFlightCalc> findByCinstance(String instanceName);

	/**
	 * Find job by result key and function.
	 *
	 * @param resultKey Result key (flight ID)
	 * @param function Function ID
	 * @return Optional job
	 */
	Optional<SysQueueFlightCalc> findByNresultKeyAndNfunction(Long resultKey, Integer function);

	/**
	 * Update job status to assigned for processing.
	 *
	 * @param jobNr Job number
	 * @param instanceName Instance name
	 * @param processStatus New process status
	 * @param startTime Start computing timestamp
	 */
	@Modifying
	@Query("UPDATE SysQueueFlightCalc j " +
			"SET j.cinstance = :instanceName, " +
			"    j.nprocessStatus = :processStatus, " +
			"    j.dstartComputing = :startTime " +
			"WHERE j.njobNr = :jobNr")
	void assignJobToInstance(
			@Param("jobNr") Long jobNr,
			@Param("instanceName") String instanceName,
			@Param("processStatus") Integer processStatus,
			@Param("startTime") Date startTime);

	/**
	 * Update job completion status.
	 *
	 * @param jobNr Job number
	 * @param processStatus Process status (3=success, 9=error)
	 * @param errorFlag Error flag (1=success, 2=error)
	 * @param errorMessage Error message
	 * @param stopTime Stop computing timestamp
	 */
	@Modifying
	@Query("UPDATE SysQueueFlightCalc j " +
			"SET j.nprocessStatus = :processStatus, " +
			"    j.nerror = :errorFlag, " +
			"    j.cerror = :errorMessage, " +
			"    j.dstopComputing = :stopTime, " +
			"    j.cmodified = 'processed' " +
			"WHERE j.njobNr = :jobNr")
	void updateJobStatus(
			@Param("jobNr") Long jobNr,
			@Param("processStatus") Integer processStatus,
			@Param("errorFlag") Integer errorFlag,
			@Param("errorMessage") String errorMessage,
			@Param("stopTime") Date stopTime);

	/**
	 * Set duplicate jobs to ignore status.
	 *
	 * @param resultKey Result key
	 * @param function Function
	 * @param processStatus Process status
	 * @param jobNrToKeep Job number to keep (exclude from update)
	 */
	@Modifying
	@Query("UPDATE SysQueueFlightCalc j " +
			"SET j.nprocessStatus = 7, " +  // 7 = IGNORE
			"    j.dstartComputing = CURRENT_TIMESTAMP, " +
			"    j.dstopComputing = CURRENT_TIMESTAMP " +
			"WHERE j.nresultKey = :resultKey " +
			"AND j.nfunction = :function " +
			"AND j.nprocessStatus = :processStatus " +
			"AND j.njobNr <> :jobNrToKeep")
	void markDuplicatesAsIgnored(
			@Param("resultKey") Long resultKey,
			@Param("function") Integer function,
			@Param("processStatus") Integer processStatus,
			@Param("jobNrToKeep") Long jobNrToKeep);

	/**
	 * Find job by job number with pessimistic write lock.
	 *
	 * @param jobNr Job number
	 * @return Optional job
	 */
	@Lock(LockModeType.PESSIMISTIC_WRITE)
	@Query("SELECT j FROM SysQueueFlightCalc j WHERE j.njobNr = :jobNr")
	Optional<SysQueueFlightCalc> findByIdWithLock(@Param("jobNr") Long jobNr);

	/**
	 * Count jobs already queued for a specific flight and function.
	 *
	 * @param resultKey Result key
	 * @param function Function
	 * @return Count of existing jobs
	 */
	@Query("SELECT COUNT(j) FROM SysQueueFlightCalc j " +
			"WHERE j.nresultKey = :resultKey " +
			"AND j.nfunction = :function")
	long countByResultKeyAndFunction(
			@Param("resultKey") Long resultKey,
			@Param("function") Integer function);

	/**
	 * Find all jobs for a specific result key (flight).
	 *
	 * @param resultKey Result key
	 * @return List of jobs for the flight
	 */
	List<SysQueueFlightCalc> findByNresultKey(Long resultKey);

	/**
	 * Count running MZV spawn processes for a result key.
	 *
	 * @param resultKey Result key
	 * @param function Function (10 for meal distribution)
	 * @param processStatus Process status (2 for running)
	 * @return Count of running processes
	 */
	@Query("SELECT COUNT(j) FROM SysQueueFlightCalc j " +
			"WHERE j.nresultKey = :resultKey " +
			"AND j.nfunction = :function " +
			"AND j.nprocessStatus = :processStatus")
	long countRunningProcesses(
			@Param("resultKey") Long resultKey,
			@Param("function") Integer function,
			@Param("processStatus") Integer processStatus);
}
