/*
 * Copyright (c) 2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitPpmShortwaste;

/**
 * Repository class for {@link LocUnitPpmShortwaste}
 *
 * @author Heiko Rothenbach
 */
public interface LocUnitPpmShortwasteRepository extends PagingAndSortingRepository<LocUnitPpmShortwaste, Long> {

	/**
	 * Returns all LocUnitPpmShortwaste for a givrn unit and kind
	 * 
	 * @param cunit
	 * @param nkind
	 * @return
	 */
	List<LocUnitPpmShortwaste> findByCunitAndNkind(final String cunit, final int nkind);
}
