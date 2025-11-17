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
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsProject;

/**
 * Repository class for {@link CenSlsConcept} object/table.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenSlsProjectRepository extends PagingAndSortingRepository<CenSlsProject, Long> {

	/**
	 * Get all concepts for a given owner.
	 *
	 * @param cowner the ohner ID.
	 * @return the found {@link CenSlsConcept}
	 */
	List<CenSlsProject> findByCownerOrderByCnameAsc(String cowner);

}
