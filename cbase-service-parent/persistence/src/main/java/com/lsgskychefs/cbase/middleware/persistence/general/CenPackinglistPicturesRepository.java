/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Collection;
import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistsId;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenPackinglistPicturesRepository extends PagingAndSortingRepository<CenPackinglistPictures, CenPackinglistsId> {

	/**
	 * {@link CenPackinglistPictures} by given ids.
	 *
	 * @param ids primary keys
	 * @return list of {@link CenPackinglistPictures}
	 */
	List<CenPackinglistPictures> findByIdIn(Collection<CenPackinglistsId> ids);
}
