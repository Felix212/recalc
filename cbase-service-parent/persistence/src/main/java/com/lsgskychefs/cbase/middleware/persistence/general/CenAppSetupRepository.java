/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAppSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenAppSetupId;

/**
 * Repository class.
 * 
 * @author Heiko Rothenbach
 */
public interface CenAppSetupRepository extends PagingAndSortingRepository<CenAppSetup, Long> {
	/**
	 * Find an entry by ID-Columns
	 * 
	 * @param cenAppSetupId
	 * @return
	 */
	CenAppSetup findById(final CenAppSetupId cenAppSetupId);

	/**
	 * Find all entries by app and secion
	 * 
	 * @param capp
	 * @param csection
	 * @return
	 */
	List<CenAppSetup> findAllByIdCappAndIdCsection(final String capp, final String csection);
}
