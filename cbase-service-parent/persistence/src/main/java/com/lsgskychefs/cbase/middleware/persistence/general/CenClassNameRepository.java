/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenClassName;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenClassNameId;

/**
 * Repository class for {@link CenClassName} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenClassNameRepository extends PagingAndSortingRepository<CenClassName, CenClassNameId> {

	/**
	 * Find airline classes by airline key
	 * 
	 * @param nairlineKey, the key of the airline
	 * @return List of {@link CenClassName}
	 */
	List<CenClassName> findByIdNairlineKeyOrderByNclassNumberAsc(final Long nairlineKey);

	/**
	 * Find entity by airline key and class
	 * 
	 * @param nairlineKey the key of the airline
	 * @param cclass the class to look for
	 * @return Entity of {@link CenClassName}
	 */
	CenClassName findByIdNairlineKeyAndIdCclass(final Long nairlineKey, final String cclass);
}
