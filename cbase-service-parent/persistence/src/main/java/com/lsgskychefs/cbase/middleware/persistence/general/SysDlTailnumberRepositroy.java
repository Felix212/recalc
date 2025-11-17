/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysDlTailnumber;

/**
 * Repository class for {@link SysDlTailnumber} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysDlTailnumberRepositroy extends PagingAndSortingRepository<SysDlTailnumber, Long> {

	/**
	 * Get the first found for given aircraft type.
	 * 
	 * @param catype the aircraft type
	 * @return the first found
	 */
	SysDlTailnumber findFirstByCactype(String catype);
}
