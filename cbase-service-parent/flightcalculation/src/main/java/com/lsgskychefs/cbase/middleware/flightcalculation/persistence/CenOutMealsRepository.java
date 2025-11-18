/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_OUT_MEALS table - flight meal output data.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutMealsRepository extends JpaRepository<CenOutMeals, Long> {

	/**
	 * Find all meals for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return List of meals for the flight
	 */
	@Query("SELECT m FROM CenOutMeals m WHERE m.nresultKey = :resultKey ORDER BY m.nprio ASC")
	List<CenOutMeals> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find meals for a specific flight and class.
	 *
	 * @param resultKey Flight result key
	 * @param classCode Service class code
	 * @return List of meals for the flight and class
	 */
	@Query("SELECT m FROM CenOutMeals m WHERE m.nresultKey = :resultKey AND m.cclass = :classCode ORDER BY m.nprio ASC")
	List<CenOutMeals> findByResultKeyAndClass(@Param("resultKey") Long resultKey, @Param("classCode") String classCode);

	/**
	 * Delete all meals for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return Number of deleted records
	 */
	@Modifying
	@Query("DELETE FROM CenOutMeals m WHERE m.nresultKey = :resultKey")
	int deleteByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Count meals for a specific flight.
	 *
	 * @param resultKey Flight result key
	 * @return Number of meal records
	 */
	@Query("SELECT COUNT(m) FROM CenOutMeals m WHERE m.nresultKey = :resultKey")
	long countByResultKey(@Param("resultKey") Long resultKey);
}
