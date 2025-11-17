/*
 * Copyright (c) 2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocOperations;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocOperationsId;

/**
 * Repository class for {@link LocOperations} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface LocOperationsRepository extends PagingAndSortingRepository<LocOperations, LocOperationsId> {

	/**
	 * Get all Operation Times for a given client and unit.
	 *
	 * @param cclient the client.
	 * @param cunit the unit.
	 * @return the found {@link LocOperations}
	 */
	List<LocOperations> findByIdCclientAndIdCunitOrderByNsort(String cclient, String cunit);
}
