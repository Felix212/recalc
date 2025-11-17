/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Repository for accessing meal component details.
 *
 * <p>PowerBuilder equivalent: DataStore queries on cen_meals_detail table
 *
 * <p>CenMealsDetail represents individual components of a meal (appetizer, main, dessert, etc.)
 * Each meal (CenMeals) has multiple components (CenMealsDetail) in a ONE-TO-MANY relationship.
 *
 * <p>CRITICAL: Each component becomes ONE CenOutMeals record in the output.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealsDetailRepository extends JpaRepository<CenMealsDetail, Long> {

	/**
	 * Find all components for a meal definition.
	 *
	 * <p>PowerBuilder: Retrieves from cen_meals_detail WHERE nhandling_meal_key = :key
	 *
	 * @param handlingMealKey The meal definition key (PK of CenMeals)
	 * @param validDate The date for validity check
	 * @return List of meal components ordered by priority
	 */
	@Query("SELECT d FROM CenMealsDetail d " +
			"WHERE d.cenMeals.nhandlingMealKey = :handlingMealKey " +
			"AND d.dvalidFrom <= :validDate " +
			"AND d.dvalidTo >= :validDate " +
			"ORDER BY d.nprio ASC")
	List<CenMealsDetail> findByMealKeyAndDate(
			@Param("handlingMealKey") Long handlingMealKey,
			@Param("validDate") Date validDate);

	/**
	 * Find all components for multiple meal definitions (batch operation).
	 *
	 * <p>More efficient than calling findByMealKeyAndDate multiple times.
	 *
	 * @param handlingMealKeys List of meal definition keys
	 * @param validDate The date for validity check
	 * @return List of meal components ordered by meal key then priority
	 */
	@Query("SELECT d FROM CenMealsDetail d " +
			"WHERE d.cenMeals.nhandlingMealKey IN :handlingMealKeys " +
			"AND d.dvalidFrom <= :validDate " +
			"AND d.dvalidTo >= :validDate " +
			"ORDER BY d.cenMeals.nhandlingMealKey ASC, d.nprio ASC")
	List<CenMealsDetail> findByMealKeysAndDate(
			@Param("handlingMealKeys") List<Long> handlingMealKeys,
			@Param("validDate") Date validDate);

	/**
	 * Count components for a meal definition.
	 *
	 * <p>Useful for validation - every meal should have at least one component.
	 *
	 * @param handlingMealKey The meal definition key
	 * @param validDate The date for validity check
	 * @return Number of valid components
	 */
	@Query("SELECT COUNT(d) FROM CenMealsDetail d " +
			"WHERE d.cenMeals.nhandlingMealKey = :handlingMealKey " +
			"AND d.dvalidFrom <= :validDate " +
			"AND d.dvalidTo >= :validDate")
	long countByMealKeyAndDate(
			@Param("handlingMealKey") Long handlingMealKey,
			@Param("validDate") Date validDate);
}
