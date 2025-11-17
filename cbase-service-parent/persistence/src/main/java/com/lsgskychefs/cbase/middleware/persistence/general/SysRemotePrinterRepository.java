/*
 * SysRemotePrinterRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysRemotePrinter;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;

/**
 * Repository class for {@link SysRemotePrinter} object/table.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface SysRemotePrinterRepository extends PagingAndSortingRepository<SysRemotePrinter, Long> {

	/**
	 * Get all concepts for a given owner.
	 *
	 * @param sysUnits a SysUnits Entry .
	 * @return the found {@link SysRemotePrinter}
	 */
	List<SysRemotePrinter> findBySysUnitsOrderByCnameAsc(SysUnits sysUnits);

}
