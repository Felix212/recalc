/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsPackages;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsPackagesId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_MEALS_PACKAGES table - meal package definitions.
 *
 * <p>Defines meal packages and their contents for different routes/classes.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealsPackagesRepository extends JpaRepository<CenMealsPackages, CenMealsPackagesId> {

	/**
	 * Find meal packages by handling meal key.
	 *
	 * @param handlingMealKey The handling meal key
	 * @return List of meal packages
	 */
	@Query("SELECT mp FROM CenMealsPackages mp " +
			"WHERE mp.id.nhandlingMealKey = :handlingMealKey " +
			"ORDER BY mp.nsort ASC")
	List<CenMealsPackages> findByHandlingMealKey(@Param("handlingMealKey") Long handlingMealKey);

	/**
	 * Find meal packages by rotation and class.
	 *
	 * @param rotationKey The rotation key
	 * @param classCode The service class code
	 * @return List of meal packages
	 */
	@Query("SELECT mp FROM CenMealsPackages mp " +
			"WHERE mp.nrotationKey = :rotationKey " +
			"AND mp.cclass = :classCode " +
			"ORDER BY mp.nsort ASC")
	List<CenMealsPackages> findByRotationAndClass(
			@Param("rotationKey") Long rotationKey,
			@Param("classCode") String classCode);
}
