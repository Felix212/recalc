/*
 * LocUnitAreasRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysAppGridConfig;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface SysAppGridConfigRepository extends PagingAndSortingRepository<SysAppGridConfig, Long> {

	/**
	 * Find all SysSlsKeywordGroup.
	 * 
	 * @param capp the Name of the app
	 * @param cgrid the Name of the grid in the app
	 * @return List of SysAppGridConfig Entries
	 */
	List<SysAppGridConfig> findByCappAndCgridOrderByCprofileAsc(String capp, String cgrid);

	/**
	 * Find all SysSlsKeywordGroup.
	 * 
	 * @param capp the Name of the app
	 * @param cgrid the Name of the grid in the app
	 * @param cprofile the Profile Name of the the grid
	 * @return List of SysAppGridConfig Entries
	 */
	List<SysAppGridConfig> findByCappAndCgridAndCprofile(String capp, String cgrid, String cprofile);

}
