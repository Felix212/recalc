/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealCover;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for CEN_MEAL_COVER table - meal covers/presentations.
 *
 * <p>Meal covers define the meal items served and their ratios per passenger.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealCoverRepository extends JpaRepository<CenMealCover, Long> {

	/**
	 * Find meal cover by key.
	 *
	 * @param coverKey The meal cover key
	 * @return Meal cover if found
	 */
	@Query("SELECT mc FROM CenMealCover mc WHERE mc.ncoverKey = :coverKey")
	Optional<CenMealCover> findByCoverKey(@Param("coverKey") Long coverKey);

	/**
	 * Find all meal covers for a rotation.
	 *
	 * @param rotationKey The rotation key
	 * @return List of meal covers
	 */
	@Query("SELECT mc FROM CenMealCover mc " +
			"WHERE mc.nrotationKey = :rotationKey " +
			"ORDER BY mc.nprio ASC")
	List<CenMealCover> findByRotationKey(@Param("rotationKey") Long rotationKey);

	/**
	 * Find meal cover by rotation and service class.
	 *
	 * @param rotationKey The rotation key
	 * @param classCode The service class code (Y, C, F, etc.)
	 * @return Meal cover if found
	 */
	@Query("SELECT mc FROM CenMealCover mc " +
			"WHERE mc.nrotationKey = :rotationKey " +
			"AND mc.cclass = :classCode " +
			"ORDER BY mc.nprio ASC")
	List<CenMealCover> findByRotationAndClass(
			@Param("rotationKey") Long rotationKey,
			@Param("classCode") String classCode);
}
