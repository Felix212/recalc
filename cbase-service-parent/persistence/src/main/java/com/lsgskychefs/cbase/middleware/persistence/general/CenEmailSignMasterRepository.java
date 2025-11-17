/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenEmailSignMaster;

/**
 * Repository class for {@link CenEmailSignMaster} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenEmailSignMasterRepository extends PagingAndSortingRepository<CenEmailSignMaster, Long> {

	/**
	 * Find email texts master
	 * 
	 * @return List of {@link CenEmailSignMaster}
	 */
	List<CenEmailSignMaster> findAllByOrderByEsmNtypeAscEsmCtextAscEsmDvalidFromAsc();

}
