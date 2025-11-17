/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysThreeLetterCodes;

/**
 * Repository class for {@link SysThreeLetterCodes} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface SysThreeLetterCodesRepository extends PagingAndSortingRepository<SysThreeLetterCodes, Long> {

	/**
	 * Find sys three letter codes
	 * 
	 * @return List of {@link SysThreeLetterCodes}
	 */
	List<SysThreeLetterCodes> findAllByOrderByCtlc();
}
