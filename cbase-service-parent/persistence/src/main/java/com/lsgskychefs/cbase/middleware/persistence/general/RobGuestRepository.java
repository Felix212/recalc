/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobGuest;

/**
 * Repository class for {@link RobGuest} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobGuestRepository extends PagingAndSortingRepository<RobGuest, Long> {
	/**
	 * Find all ordered by name.
	 *
	 * @return the list of {@link RobGuest}
	 */
	List<RobGuest> findAllByOrderByCnameAsc();
}
