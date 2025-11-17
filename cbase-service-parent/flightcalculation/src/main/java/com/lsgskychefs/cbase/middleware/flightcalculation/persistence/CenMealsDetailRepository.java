/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_MEALS_DETAIL table - detailed meal configurations.
 *
 * <p>This table contains the specific meal items, quantities, and configurations
 * for each meal definition from CEN_MEALS.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealsDetailRepository extends JpaRepository<CenMealsDetail, Long> {

	/**
	 * Find all meal details for a specific meal definition.
	 *
	 * @param handlingMealKey The meal definition key (from CEN_MEALS)
	 * @return List of meal details ordered by sort sequence
	 */
	@Query("SELECT md FROM CenMealsDetail md " +
			"WHERE md.nhandlingMealKey = :handlingMealKey " +
			"ORDER BY md.nsort ASC")
	List<CenMealsDetail> findByHandlingMealKey(@Param("handlingMealKey") Long handlingMealKey);

	/**
	 * Find meal details by handling detail key.
	 *
	 * @param handlingDetailKey The handling detail key
	 * @return List of meal details
	 */
	@Query("SELECT md FROM CenMealsDetail md " +
			"WHERE md.nhandlingDetailKey = :handlingDetailKey " +
			"ORDER BY md.nsort ASC")
	List<CenMealsDetail> findByHandlingDetailKey(@Param("handlingDetailKey") Long handlingDetailKey);

	/**
	 * Check if meal detail exists for validation.
	 *
	 * @param handlingDetailKey The handling detail key
	 * @return true if detail exists
	 */
	@Query("SELECT COUNT(md) > 0 FROM CenMealsDetail md " +
			"WHERE md.nhandlingDetailKey = :handlingDetailKey")
	boolean existsByHandlingDetailKey(@Param("handlingDetailKey") Long handlingDetailKey);
}
