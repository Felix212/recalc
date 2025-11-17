/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAircraftConfigurations;

/**
 * Repository class for {@link CenAircraftConfigurations} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenAircraftConfigurationsRepository extends PagingAndSortingRepository<CenAircraftConfigurations, Long> {

	/**
	 * Find aircraft version
	 * 
	 * @param naircraftKey, aircraft key
	 * @return List of {@link CenAircraftConfigurations}
	 */
	@Query("SELECT cac "
			+ "FROM CenAircraftConfigurations cac  "
			+ "JOIN cac.cenClassName ccn "
			+ "WHERE cac.cenAircraft.naircraftKey = :aircraftKey "
			+ "AND cac.cenClassName.nbookingClass = 1 "
			+ "ORDER BY cac.ngroupKey ASC, cac.cenClassName.nclassNumber ASC")
	List<CenAircraftConfigurations> findAircraftVersion(
			@Param("aircraftKey") final Long naircraftKey);

}
