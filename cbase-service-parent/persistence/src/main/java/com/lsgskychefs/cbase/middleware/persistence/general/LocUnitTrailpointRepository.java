/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitTrailpoint;

/**
 * Repository class for {@link LocUnitTrailpoint}
 *
 * @author Alex Schaab - U524036
 * @author Dirk Bunk - U200035
 */
public interface LocUnitTrailpointRepository extends PagingAndSortingRepository<LocUnitTrailpoint, Long> {

	/**
	 * Get a list of {@link LocUnitTrailpoint} for a specific unit
	 * 
	 * @param cunit the unit
	 * @return list of {@link LocUnitTrailpoint}
	 */
	List<LocUnitTrailpoint> findBySysUnitsCunitOrderByNsort(final String cunit);

	/**
	 * Get a list of {@link LocUnitTrailpoint} that are in the same group
	 * 
	 * @param ntrailpointKey the trailpoint key
	 * @return list of {@link LocUnitTrailpoint}
	 */
	@Query("SELECT l FROM LocUnitTrailpoint l WHERE "
			+ "l.ntrailpointGroupKey = "
			+ "(SELECT l.ntrailpointGroupKey FROM LocUnitTrailpoint l WHERE l.ntrailpointKey = :ntrailpointKey) "
			+ " OR (l.ntrailpointGroupKey IS NULL AND l.ntrailpointKey = :ntrailpointKey)")
	List<LocUnitTrailpoint> findAllTrailpointsWithinGroup(@Param("ntrailpointKey") Long ntrailpointKey);
}
