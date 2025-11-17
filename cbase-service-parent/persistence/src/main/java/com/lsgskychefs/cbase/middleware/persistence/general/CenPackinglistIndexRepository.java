/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistIndex;

/**
 * Repository class for {@link CenPackinglistIndex} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenPackinglistIndexRepository extends PagingAndSortingRepository<CenPackinglistIndex, Long> {

	/**
	 * Get {@link CenPackinglistIndex} by cpackinglist.
	 *
	 * @param cpackinglist the packinglist identifier
	 * @return the packinglist index
	 */
	CenPackinglistIndex findByCpackinglist(String cpackinglist);

	/**
	 * Get {@link CenPackinglistIndex} by njasperKey.
	 * 
	 * @param njasperKey
	 * @return {@link CenPackinglistIndex}
	 */
	CenPackinglistIndex findFirstByCenPackinglistsesNjasperKey(long njasperKey);
}
