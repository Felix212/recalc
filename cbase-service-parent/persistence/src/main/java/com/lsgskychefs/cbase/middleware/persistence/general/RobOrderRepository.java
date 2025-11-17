/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobOrder;

/**
 * Repository class for {@link RobOrder} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobOrderRepository extends PagingAndSortingRepository<RobOrder, Long> {
	/**
	 * Find all ordered by delivery time.
	 *
	 * @return the list of {@link RobOrder}
	 */
	List<RobOrder> findAllByOrderByDdeliveryTimeAsc();

	/**
	 * Finds first by guest key ordered by order group.
	 * 
	 * @param nguestKey
	 * @return
	 */
	RobOrder findFirstByRobGuestNguestKeyOrderByNorderGroupAsc(long nguestKey);
}
