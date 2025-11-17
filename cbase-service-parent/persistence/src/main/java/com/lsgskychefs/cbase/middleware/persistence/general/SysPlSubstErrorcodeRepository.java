/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPlSubstErrorcode;

/**
 * Repository class for {@link SysPlSubstErrorcode} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface SysPlSubstErrorcodeRepository extends PagingAndSortingRepository<SysPlSubstErrorcode, Long> {

	/**
	 * Find eu subst errorcode
	 * 
	 * @param cclient, the client
	 * @param nactive, active
	 * @return {@link SysPlSubstErrorcode}
	 */
	List<SysPlSubstErrorcode> findByCclientAndNactiveOrderByNsortAsc(final String cclient, final int nactive);

}
