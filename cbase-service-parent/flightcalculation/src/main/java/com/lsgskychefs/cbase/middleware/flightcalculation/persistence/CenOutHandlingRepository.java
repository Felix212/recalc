/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandling;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandlingId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_OUT_HANDLING table - flight handling instructions.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutHandlingRepository extends JpaRepository<CenOutHandling, CenOutHandlingId> {

	/**
	 * Find all handling items for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return List of handling items for the flight
	 */
	@Query("SELECT h FROM CenOutHandling h WHERE h.id.nresultKey = :resultKey ORDER BY h.nprio ASC")
	List<CenOutHandling> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Delete all handling items for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return Number of deleted records
	 */
	@Modifying
	@Query("DELETE FROM CenOutHandling h WHERE h.id.nresultKey = :resultKey")
	int deleteByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Count handling items for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return Number of handling records
	 */
	@Query("SELECT COUNT(h) FROM CenOutHandling h WHERE h.id.nresultKey = :resultKey")
	long countByResultKey(@Param("resultKey") Long resultKey);
}
