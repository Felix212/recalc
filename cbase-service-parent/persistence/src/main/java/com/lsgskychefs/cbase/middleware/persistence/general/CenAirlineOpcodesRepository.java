/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenAirlineOpcodes;

/**
 * Repository class for {@link CenAirlineOpcodes} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenAirlineOpcodesRepository extends PagingAndSortingRepository<CenAirlineOpcodes, Long> {

	/**
	 * Find airline opcodes by airline key
	 * 
	 * @param nairlineKey, the airline key
	 * @return link of {@link CenAirlineOpcodes}
	 */
	List<CenAirlineOpcodes> findByCenAirlinesNairlineKeyOrderByCopcodeAsc(final Long nairlineKey);

}
