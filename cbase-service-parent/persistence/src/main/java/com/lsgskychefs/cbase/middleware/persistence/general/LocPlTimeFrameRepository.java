/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPlTimeFrame;

/**
 * Repository class for {@link LocPlTimeFrame} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface LocPlTimeFrameRepository extends PagingAndSortingRepository<LocPlTimeFrame, Long> {
	/**
	 * Gets a LocPlTimeFrame entity for a specific packinglist, unit, airline and date
	 * 
	 * @param npackinglistIndexKey
	 * @param cunit
	 * @param nairlineKey
	 * @return found {@link LocPlTimeFrame} entity or null
	 */
	List<LocPlTimeFrame> findByNpackinglistIndexKeyAndCunitAndNairlineKey(
			final Long npackinglistIndexKey,
			final String cunit,
			final Long nairlineKey);
}
