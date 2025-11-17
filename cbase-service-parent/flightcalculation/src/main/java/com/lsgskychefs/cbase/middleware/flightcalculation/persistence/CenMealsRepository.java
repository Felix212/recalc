/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMeals;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Repository for CEN_MEALS table - meal definitions and configurations.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealsRepository extends JpaRepository<CenMeals, Long> {

	/**
	 * Find meals by routing plan key (route-specific meal definitions).
	 *
	 * @param rotationKey Routing plan key
	 * @param classNumber Service class number
	 * @param validityDate Date to check validity
	 * @return List of meal definitions
	 */
	@Query("SELECT m FROM CenMeals m " +
			"WHERE m.nrotationKey = :rotationKey " +
			"AND m.nclassNumber = :classNumber " +
			"AND (m.dvalidFrom IS NULL OR m.dvalidFrom <= :validityDate) " +
			"AND (m.dvalidTo IS NULL OR m.dvalidTo >= :validityDate)")
	List<CenMeals> findByRotationAndClassAndValidity(
			@Param("rotationKey") Long rotationKey,
			@Param("classNumber") Long classNumber,
			@Param("validityDate") Date validityDate);

	/**
	 * Find all meals for a routing plan.
	 *
	 * @param rotationKey Routing plan key
	 * @param validityDate Date to check validity
	 * @return List of meal definitions
	 */
	@Query("SELECT m FROM CenMeals m " +
			"WHERE m.nrotationKey = :rotationKey " +
			"AND (m.dvalidFrom IS NULL OR m.dvalidFrom <= :validityDate) " +
			"AND (m.dvalidTo IS NULL OR m.dvalidTo >= :validityDate)")
	List<CenMeals> findByRotationAndValidity(
			@Param("rotationKey") Long rotationKey,
			@Param("validityDate") Date validityDate);
}
