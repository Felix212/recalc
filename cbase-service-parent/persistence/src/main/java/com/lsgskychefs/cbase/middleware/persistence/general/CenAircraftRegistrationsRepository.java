/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAircraftRegistrations;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAircraftRegistrationsId;

/**
 * Repository class for {@link CenAircraftRegistrations} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenAircraftRegistrationsRepository
		extends PagingAndSortingRepository<CenAircraftRegistrations, CenAircraftRegistrationsId> {

	/**
	 * Find tailnumbers.
	 *
	 * @param naircraftKey, aircraft key
	 * @return list of {@link CenAircraftRegistrations}
	 */
	List<CenAircraftRegistrations> findByIdNaircraftKeyOrderByIdCregistrationAsc(final Long naircraftKey);

}
