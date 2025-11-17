/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlineAccounts;

/**
 * Repository class for {@link CenAirlineAccounts} entity/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface CenAirlineAccountsRepository extends PagingAndSortingRepository<CenAirlineAccounts, Long> {

	/**
	 * Find by nairlineKey and caccount.
	 *
	 * @param nairlineKey
	 * @param caccount
	 * @return the entity of {@link CenAirlineAccounts}
	 */
	CenAirlineAccounts findByCenAirlinesNairlineKeyAndCaccount(final Long nairlineKey, final String caccount);

	/**
	 * Find by nairlineKey and csapCode.
	 *
	 * @param nairlineKey
	 * @param csapCode
	 * @return the entity of {@link CenAirlineAccounts}
	 */
	CenAirlineAccounts findFirstByCenAirlinesNairlineKeyAndCsapCode(final Long nairlineKey, final String csapCode);
}
