/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenEmailSignDetail;

/**
 * Repository class for {@link CenEmailSignDetail} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenEmailSignDetailRepository extends PagingAndSortingRepository<CenEmailSignDetail, Long> {

	/**
	 * Find email texts detail
	 * 
	 * @param esdEsmNkey, master key
	 * @return List of {@link CenEmailSignDetail}
	 */
	List<CenEmailSignDetail> findByCenEmailSignMasterEsmNkeyOrderByEsdNsortAsc(final Long esdEsmNkey);

}
