/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenBlData;

/**
 * Repository class for {@link CenDocGenBlData} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenDocGenBlDataRepository extends PagingAndSortingRepository<CenDocGenBlData, Long> {

	/**
	 * Find all CenDocGenBlData by ndocGenQueueBl
	 * 
	 * @param ndocGenQueueBl, primary key
	 * @return {@link CenDocGenBlData}
	 */
	List<CenDocGenBlData> findByCenDocGenQueueBlNdocGenQueueBl(final long ndocGenQueueBl);

}
