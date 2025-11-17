/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobEvent;

/**
 * Repository class for {@link RobEvent} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobEventRepository extends PagingAndSortingRepository<RobEvent, Long> {
	/**
	 * Find all ordered by name.
	 *
	 * @return the list of {@link RobEvent}
	 */
	List<RobEvent> findAllByOrderByCnameAsc();
}
