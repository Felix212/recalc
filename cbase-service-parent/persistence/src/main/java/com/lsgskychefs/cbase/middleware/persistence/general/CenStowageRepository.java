/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenStowage;

/**
 * Repository class for {@link CenStowage} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface CenStowageRepository extends PagingAndSortingRepository<CenStowage, Long> {

	/**
	 * Loads all {@link CenStowage} from Masterdata
	 *
	 * @param cairline the Airline
	 * @param cactype the Aircraft Type
	 * @param cgalleyversion the Version for Aircraft type
	 * @return all storages
	 */
	@EntityGraph(value = "CenStowage.cenGalley", type = EntityGraphType.LOAD, attributePaths = { "cenGalley", "cenGalley.cenAircraft" })
	@Query("SELECT stowages FROM CenStowage stowages "
			+ "JOIN stowages.cenGalley galley "
			+ "JOIN galley.cenAircraft aircraft  "
			+ "JOIN aircraft.cenAirlines airlines  "
			+ "WHERE airlines.cairline = :cairline "
			+ "AND aircraft.cactype = :cactype "
			+ "AND aircraft.cgalleyversion = :cgalleyversion "
			+ "ORDER BY stowages.nsort, galley.nsort")
	List<CenStowage> findStowagesByAirlineAndAircraft(
			@Param("cairline") String cairline,
			@Param("cactype") String cactype,
			@Param("cgalleyversion") String cgalleyversion);
}
