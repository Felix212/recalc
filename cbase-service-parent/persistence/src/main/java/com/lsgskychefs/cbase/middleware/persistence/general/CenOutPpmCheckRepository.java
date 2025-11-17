/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmCheck;

/**
 * Repository class for {@link CenOutPpmCheck} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface CenOutPpmCheckRepository extends PagingAndSortingRepository<CenOutPpmCheck, Long> {
	/**
	 * Gets all supervisor check entries for one shift
	 * 
	 * @param nppmSchedKey
	 * @return List<CenOutPpmCheck>
	 */
	List<CenOutPpmCheck> findAllByCenOutPpmSchedNppmSchedKeyOrderByDtimestampAsc(final long nppmSchedKey);

}
