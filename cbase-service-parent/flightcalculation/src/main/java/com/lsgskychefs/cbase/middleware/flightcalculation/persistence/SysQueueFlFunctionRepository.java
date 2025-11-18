/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlFunction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for {@link SysQueueFlFunction} entity (SYS_QUEUE_FL_FUNCTION table).
 * Provides access to flight calculation function configuration.
 *
 * @author Migration Team
 */
@Repository
public interface SysQueueFlFunctionRepository extends JpaRepository<SysQueueFlFunction, Integer> {

	/**
	 * Find function configuration by function ID.
	 *
	 * @param functionId Function ID
	 * @return Optional function configuration
	 */
	Optional<SysQueueFlFunction> findByNfunction(Integer functionId);

	/**
	 * Find all functions with specific internal function type.
	 *
	 * @param internalFunction Internal function type
	 * @return List of functions
	 */
	List<SysQueueFlFunction> findByNinternalFunction(Integer internalFunction);

	/**
	 * Find functions by queued release interface value.
	 *
	 * @param queuedReleaseInterface Queued release interface value
	 * @return List of functions
	 */
	List<SysQueueFlFunction> findByNqueuedReleaseInterface(Integer queuedReleaseInterface);

	/**
	 * Find all active function configurations ordered by function ID.
	 *
	 * @return List of all functions
	 */
	@Query("SELECT f FROM SysQueueFlFunction f ORDER BY f.nfunction")
	List<SysQueueFlFunction> findAllOrderedByFunction();
}
