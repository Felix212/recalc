/*
 * CenSlsProjConcAttRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsProjConcAtt;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSlsProjConcAttId;

/**
 * Repository class for {@link CenSlsProjConcAtt} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface CenSlsProjConcAttRepository extends PagingAndSortingRepository<CenSlsProjConcAtt, CenSlsProjConcAttId> {

	/**
	 * Get Concept Attachments by type doc or image
	 * 
	 * @param nprojConceptKey the concept id
	 * @param ctype doc/image
	 * @return List of {@link CenSlsProjConcAtt}
	 */
	List<CenSlsProjConcAtt> findByIdNprojConceptKeyAndCtype(final Long nprojConceptKey, final String ctype);
}
