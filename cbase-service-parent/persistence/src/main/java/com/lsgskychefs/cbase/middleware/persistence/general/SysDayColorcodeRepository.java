/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysDayColorcode;

/**
 * Repository class.
 * 
 * @author Dirk Bunk - U200035
 */
public interface SysDayColorcodeRepository extends PagingAndSortingRepository<SysDayColorcode, Long> {

	/**
	 * Get color codes by unit.
	 *
	 * @param cunit the unit to retrieve the color codes for
	 * @return all color codes per unit
	 */
	List<SysDayColorcode> findBySysUnitsCunit(String cunit);
}
