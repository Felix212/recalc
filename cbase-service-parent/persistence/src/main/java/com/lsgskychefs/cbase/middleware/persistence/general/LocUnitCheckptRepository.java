/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitCheckpt;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface LocUnitCheckptRepository extends PagingAndSortingRepository<LocUnitCheckpt, Long> {

	/**
	 * Get defined checkpoints, for given unit.
	 *
	 * @param cunit company of the region
	 * @return defined checkpoints
	 */
	List<LocUnitCheckpt> findByCunitOrderByNsort(String cunit);

}
