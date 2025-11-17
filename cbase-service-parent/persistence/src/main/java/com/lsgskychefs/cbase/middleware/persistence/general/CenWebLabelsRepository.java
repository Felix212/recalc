/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenWebLabels;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenWebLabelsId;

/**
 * Repository class for {@link CenWebLabels} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenWebLabelsRepository extends PagingAndSortingRepository<CenWebLabels, CenWebLabelsId> {

	/**
	 * Delete all {@link CenWebLabels} by flight key and user.
	 *
	 * @param cflightKey the flight key
	 * @param cuser the user
	 * @return the deleted
	 */
	Long deleteByIdCflightKeyAndIdCuser(String cflightKey, String cuser);
}
