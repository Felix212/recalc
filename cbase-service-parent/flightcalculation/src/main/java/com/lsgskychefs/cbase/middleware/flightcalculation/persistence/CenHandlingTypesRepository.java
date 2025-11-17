/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenHandlingTypes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository for CEN_HANDLING_TYPES table - handling type configurations.
 *
 * <p>Defines handling types and their configurations for different airlines/routes.
 *
 * @author Migration Team
 */
@Repository
public interface CenHandlingTypesRepository extends JpaRepository<CenHandlingTypes, Long> {

	/**
	 * Find handling type by key.
	 *
	 * @param handlingTypeKey The handling type key
	 * @return Handling type if found
	 */
	@Query("SELECT ht FROM CenHandlingTypes ht WHERE ht.nhandlingTypeKey = :handlingTypeKey")
	Optional<CenHandlingTypes> findByHandlingTypeKey(@Param("handlingTypeKey") Long handlingTypeKey);

	/**
	 * Find handling type by code.
	 *
	 * @param handlingCode The handling code
	 * @return Handling type if found
	 */
	@Query("SELECT ht FROM CenHandlingTypes ht WHERE ht.chandlingType = :handlingCode")
	Optional<CenHandlingTypes> findByHandlingCode(@Param("handlingCode") String handlingCode);
}
