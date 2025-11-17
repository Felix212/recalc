/*
 * LocUnitAreasRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsConcept;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysSlsKeyword;

/**
 * Repository class for {@link CenSlsConcept} object/table.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface CenSlsConceptRepository extends PagingAndSortingRepository<CenSlsConcept, Long> {

	/**
	 * Get all concepts for a given owner.
	 *
	 * @param cowner the ohner ID.
	 * @return List of {@link CenSlsConcept}
	 */
	List<CenSlsConcept> findByCownerOrderByCnameAsc(String cowner);

	/**
	 * Get all concepts with 100% match for given {@link SysSlsKeyword}. Pay attention as concpets may be duplicated in response list.
	 * findByDISTINCT fails cause Oracle cannot distinct Blobs -_-. Workarround for now is using {@link LinkedHashSet} to remove duplicates
	 * 
	 * @param nkeywordKeys List of {@link SysSlsKeyword} the concept must match
	 * @return List of {@link CenSlsConcept}
	 */
	List<CenSlsConcept> findBySysSlsKeywordsNkeywordKeyIn(ArrayList<Long> nkeywordKeys);

}
