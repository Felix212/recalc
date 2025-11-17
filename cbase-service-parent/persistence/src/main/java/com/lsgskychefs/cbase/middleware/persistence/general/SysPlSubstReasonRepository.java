/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPlSubstReason;

/**
 * Repository class for {@link SysPlSubstReason} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface SysPlSubstReasonRepository extends PagingAndSortingRepository<SysPlSubstReason, Long> {

	/**
	 * Find eu subst reasons
	 * 
	 * @param cclient, the client
	 * @param nactive, active
	 * @return {@link SysPlSubstReason}
	 */
	List<SysPlSubstReason> findByCclientAndNactiveOrderByCsortAsc(final String cclient, final int nactive);

}
