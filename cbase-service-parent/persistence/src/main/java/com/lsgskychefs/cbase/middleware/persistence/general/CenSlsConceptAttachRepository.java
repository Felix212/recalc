/*
 * CenSlsConceptAttachRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsConceptAttach;

/**
 * Repository class for {@link CenSlsConceptAttach} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface CenSlsConceptAttachRepository extends PagingAndSortingRepository<CenSlsConceptAttach, Long> {

	/**
	 * Get Concept Attachments by type doc or image
	 * 
	 * @param nconceptKey the concept id
	 * @param ctype doc/image
	 * @return List of {@link CenSlsConceptAttach}
	 */
	List<CenSlsConceptAttach> findByCenSlsConceptNconceptKeyAndCtype(final Long nconceptKey, final String ctype);
}
