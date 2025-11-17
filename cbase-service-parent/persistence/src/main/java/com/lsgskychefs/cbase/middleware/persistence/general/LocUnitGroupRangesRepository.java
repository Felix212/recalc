/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitGroupRanges;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitGroupRangesId;

/**
 * Repository class for {@link LocUnitGroupRanges} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocUnitGroupRangesRepository extends PagingAndSortingRepository<LocUnitGroupRanges, LocUnitGroupRangesId> {

	/**
	 * Find label printing groups prod ranges by nlabelGroupKey
	 * 
	 * @param labelGroupKey, label group key
	 * @return List of {@link LocUnitGroupRanges}
	 */
	@Query("SELECT lugr "
			+ "FROM LocUnitGroupRanges lugr  "
			+ "JOIN lugr.locUnitProdRanges lupr "
			+ "WHERE lugr.locUnitLabelGroups.nlabelGroupKey = :labelGroupKey "
			+ "ORDER BY lupr.nsort ASC")
	List<LocUnitGroupRanges> findLabelPrintingGroupsProdRanges(
			@Param("labelGroupKey") final Long labelGroupKey);

}
