/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenDocGenQueueBl;

/**
 * Repository class for {@link CenDocGenQueueBl} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenDocGenQueueBlRepository extends PagingAndSortingRepository<CenDocGenQueueBl, Long> {

	/**
	 * Find all CenDocGenQueueBl by primary key
	 * 
	 * @param ndocGenQueueBl, primary key
	 * @return {@link CenDocGenQueueBl}
	 */
	List<CenDocGenQueueBl> findByNdocGenQueueBl(final long ndocGenQueueBl);

}
