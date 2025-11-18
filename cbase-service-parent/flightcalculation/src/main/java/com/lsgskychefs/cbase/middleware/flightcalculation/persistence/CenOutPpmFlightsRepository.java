/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlightsId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.LockModeType;
import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link CenOutPpmFlights} entity (CEN_OUT table).
 * Provides access to flight master data.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutPpmFlightsRepository extends JpaRepository<CenOutPpmFlights, CenOutPpmFlightsId> {

	/**
	 * Find flight by result key.
	 *
	 * @param resultKey Result key
	 * @return Optional flight
	 */
	@Query("SELECT f FROM CenOutPpmFlights f WHERE f.id.nresultKey = :resultKey")
	Optional<CenOutPpmFlights> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find flight by result key with pessimistic write lock.
	 * This implements the PowerBuilder "SELECT FOR UPDATE NOWAIT" pattern.
	 *
	 * @param resultKey Result key
	 * @return Optional flight
	 * @throws javax.persistence.LockTimeoutException if lock cannot be acquired
	 * @throws javax.persistence.PessimisticLockException if lock cannot be acquired
	 */
	@Lock(LockModeType.PESSIMISTIC_WRITE)
	@Query("SELECT f FROM CenOutPpmFlights f WHERE f.id.nresultKey = :resultKey")
	Optional<CenOutPpmFlights> findByResultKeyWithLock(@Param("resultKey") Long resultKey);

	/**
	 * Find flights ready for calculation by queued release interface status.
	 * These are flights waiting to be processed.
	 *
	 * @param queuedReleaseInterfaces List of interface statuses to process
	 * @return List of flights
	 */
	@Query("SELECT f FROM CenOutPpmFlights f " +
			"WHERE f.nqueuedReleaseInterface IN :queuedReleaseInterfaces " +
			"ORDER BY f.id.ddeparture ASC")
	List<CenOutPpmFlights> findByQueuedReleaseInterface(
			@Param("queuedReleaseInterfaces") List<Integer> queuedReleaseInterfaces);

	/**
	 * Update flight status after successful calculation.
	 *
	 * @param resultKey Result key
	 * @param newStatus New status
	 * @param queuedReleaseInterface New queued release interface
	 */
	@Modifying
	@Query("UPDATE CenOutPpmFlights f " +
			"SET f.nstatus = :newStatus, " +
			"    f.nqueuedReleaseInterface = :queuedReleaseInterface " +
			"WHERE f.id.nresultKey = :resultKey")
	void updateFlightStatus(
			@Param("resultKey") Long resultKey,
			@Param("newStatus") Integer newStatus,
			@Param("queuedReleaseInterface") Integer queuedReleaseInterface);

	/**
	 * Update flight status from zero to target status.
	 * Used when flight has initial status of 0.
	 *
	 * @param resultKey Result key
	 * @param targetStatus Target status
	 */
	@Modifying
	@Query("UPDATE CenOutPpmFlights f " +
			"SET f.nstatus = :targetStatus " +
			"WHERE f.id.nresultKey = :resultKey " +
			"AND f.nstatus = 0")
	void updateFlightStatusFromZero(
			@Param("resultKey") Long resultKey,
			@Param("targetStatus") Integer targetStatus);

	/**
	 * Count flights with invalid meal definition references.
	 * These flights require forced meal recalculation.
	 *
	 * @param resultKey Result key
	 * @return Count of invalid references
	 */
	@Query(value = "SELECT COUNT(*) FROM cen_out_meals " +
			"WHERE nresult_key = :resultKey " +
			"AND nmodule_type = 0 " +
			"AND NOT EXISTS (SELECT 1 FROM cen_meals_detail " +
			"                WHERE cen_meals_detail.nhandling_detail_key = cen_out_meals.nhandling_detail_key)",
			nativeQuery = true)
	long countInvalidMealReferences(@Param("resultKey") Long resultKey);

	/**
	 * Delete flight by result key.
	 *
	 * @param resultKey Result key
	 */
	void deleteByIdNresultKey(Long resultKey);
}
