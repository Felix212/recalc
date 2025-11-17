/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysProductCategory;

/**
 * Repository class for {@link SysProductCategory} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface SysProductCategoryRepository extends PagingAndSortingRepository<SysProductCategory, Long> {
	/**
	 * Finds one <code>SysProductCategory</code> entity by a given SAP Code
	 *
	 * @param csapCode the SAP Code
	 * @return the found <code>SysProductCategory</code> entity
	 */
	SysProductCategory findFirstByCsapCode(String csapCode);
}
