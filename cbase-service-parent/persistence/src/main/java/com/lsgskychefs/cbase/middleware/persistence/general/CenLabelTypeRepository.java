/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenLabelType;

/**
 * Repository class for {@link CenLabelType} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface CenLabelTypeRepository extends PagingAndSortingRepository<CenLabelType, Long> {

	/**
	 * Find label types by nlabelGroupKeys
	 * 
	 * @param nlabelGroupKeys, List of nlabelGroupKey
	 * @return List of {@link CenLabelType}
	 */
	List<CenLabelType> findByNlabelGroupKeyIn(final List<Long> nlabelGroupKeys);

}
