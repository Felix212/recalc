/*
 * LocUnitAreasRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsConcept;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsConceptUsage;

/**
 * Repository class for {@link CenSlsConceptUsage} object/table.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenSlsConceptUsageRepository extends PagingAndSortingRepository<CenSlsConceptUsage, Long> {

	/**
	 * Get all concept usage for a given concept.
	 *
	 * @param cenSlsConcepts the concept.
	 * @return the found {@link CenSlsConceptUsage}
	 */
	List<CenSlsConceptUsage> findByCenSlsConcept(CenSlsConcept cenSlsConcept);

}
