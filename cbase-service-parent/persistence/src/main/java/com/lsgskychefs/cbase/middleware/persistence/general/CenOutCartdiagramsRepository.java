/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutCartdiagrams;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutCartdiagramsId;

/**
 * Repository class for {@link CenOutCartdiagrams} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface CenOutCartdiagramsRepository extends PagingAndSortingRepository<CenOutCartdiagrams, CenOutCartdiagramsId> {

	/**
	 * Gets the details for the generated cartdiagram pdf for one specific stowage.
	 * 
	 * @param nresultKey the flight id
	 * @param ntransaction the flight transaction number
	 * @param ctype usually 'CD' for card diagram
	 * @param stowageEx - stowage with place and galley e.g. 2M1-20 A
	 * @return one {@link CenOutCartdiagrams}, null if cart diagram is not generated yet.
	 */
	List<CenOutCartdiagrams> findByIdNresultKeyAndIdNtransactionAndIdCtypeAndCstowage(final Long nresultKey, final Long ntransaction,
			final String ctype, final String stowageEx);

}
