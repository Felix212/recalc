/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsSpml;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository for CEN_MEALS_SPML table - special meal (SPML) definitions.
 *
 * <p>Maps SPML codes to meal definitions for special dietary requirements.
 *
 * @author Migration Team
 */
@Repository
public interface CenMealsSpmlRepository extends JpaRepository<CenMealsSpml, Long> {

	/**
	 * Find SPML definition by code.
	 *
	 * @param spmlCode The SPML code (e.g., VGML, KSML, GFML)
	 * @return SPML definition if found
	 */
	@Query("SELECT ms FROM CenMealsSpml ms WHERE ms.cspml = :spmlCode")
	Optional<CenMealsSpml> findBySpmlCode(@Param("spmlCode") String spmlCode);

	/**
	 * Find SPML definitions for a rotation.
	 *
	 * @param rotationKey The rotation key
	 * @return List of SPML definitions
	 */
	@Query("SELECT ms FROM CenMealsSpml ms WHERE ms.nrotationKey = :rotationKey")
	List<CenMealsSpml> findByRotationKey(@Param("rotationKey") Long rotationKey);

	/**
	 * Find SPML definition by code and rotation.
	 *
	 * @param spmlCode The SPML code
	 * @param rotationKey The rotation key
	 * @return SPML definition if found
	 */
	@Query("SELECT ms FROM CenMealsSpml ms " +
			"WHERE ms.cspml = :spmlCode " +
			"AND ms.nrotationKey = :rotationKey")
	Optional<CenMealsSpml> findBySpmlCodeAndRotation(
			@Param("spmlCode") String spmlCode,
			@Param("rotationKey") Long rotationKey);
}
