/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenEmailGroupsMaster;

/**
 * Repository class for {@link CenEmailGroupsMaster} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenEmailGroupsMasterRepository extends PagingAndSortingRepository<CenEmailGroupsMaster, Long> {

	/**
	 * Find all {@link CenEmailGroupsMaster}
	 * 
	 * @return {@link CenEmailGroupsMaster}
	 */
	List<CenEmailGroupsMaster> findAllByOrderByEgmCtextAsc();

}
