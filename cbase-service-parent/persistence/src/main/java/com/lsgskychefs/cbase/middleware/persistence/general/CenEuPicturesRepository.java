/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenEuPictures;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenEuPicturesId;

/**
 * Repository class for {@link CenEuPictures} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenEuPicturesRepository extends PagingAndSortingRepository<CenEuPictures, CenEuPicturesId> {

	/**
	 * Load {@link CenEuPictures} by region and packing list.
	 * 
	 * @param neuRegionKey system/region of packing list
	 * @param cpackinglist packing list code
	 * @return the {@link CenEuPictures} list
	 */
	List<CenEuPictures> findByIdNeuRegionKeyAndIdCpackinglist(long neuRegionKey, String cpackinglist);

	/**
	 * Load {@link CenEuPictures} by role id.
	 * 
	 * @param euRole, role id
	 * @return the {@link CenEuPictures} list
	 */
	List<CenEuPictures> findBySysEuRegionsSysRolesNroleIdOrderByIdCpackinglist(int euRole);
}
