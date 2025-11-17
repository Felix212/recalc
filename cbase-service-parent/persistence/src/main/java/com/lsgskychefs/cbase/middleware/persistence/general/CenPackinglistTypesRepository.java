/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistTypes;

/**
 * Repository class for {@link CenPackinglistTypes} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenPackinglistTypesRepository extends PagingAndSortingRepository<CenPackinglistTypes, Long> {
	/**
	 * Find all cenpackinglist types by client and cpackinglistTypeCobis not null
	 * 
	 * @param cclient, the client
	 * @return list of {@link CenPackinglistTypes}
	 */
	List<CenPackinglistTypes> findByCclientAndCpackinglistTypeCobisNotNull(final String cclient);
}
