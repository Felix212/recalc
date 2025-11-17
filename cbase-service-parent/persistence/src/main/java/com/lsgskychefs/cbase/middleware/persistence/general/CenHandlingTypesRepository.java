/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenHandlingTypes;

/**
 * Repository class for {@link CenHandlingTypes} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenHandlingTypesRepository extends PagingAndSortingRepository<CenHandlingTypes, Long> {
	/**
	 * Find handling types
	 * 
	 * @param nairlineKey, the airline key
	 * @param showDefault, show default or not
	 * @return list of {@link CenHandlingTypes}
	 */
	@Query("SELECT cht FROM CenHandlingTypes cht "
			+ "WHERE cht.cenAirlines.nairlineKey = :nairlineKey "
			+ "AND ( cht.ctext <> '*' OR :argShowDefault = 1 )")
	List<CenHandlingTypes> findHandlingTypesQuery(
			@Param("nairlineKey") final Long nairlineKey, @Param("argShowDefault") final Integer showDefault);

}
