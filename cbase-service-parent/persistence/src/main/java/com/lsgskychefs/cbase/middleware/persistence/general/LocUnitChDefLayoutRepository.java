package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitChDefLayout;

public interface LocUnitChDefLayoutRepository extends PagingAndSortingRepository<LocUnitChDefLayout, Long> {

	/**
	 * Find detailed warehouse data
	 * 
	 * @param nwarehouseKey, the chosen warehouse
	 * @return List of {@link LocUnitChDefLayout}
	 */
	List<LocUnitChDefLayout> findByLocUnitChWarehouseNwarehouseKey(final Long nwarehouseKey);

}
