/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenWebDocuments;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenWebDocumentsId;

/**
 * Repository class for {@link CenWebDocuments} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenWebDocumentRepository extends PagingAndSortingRepository<CenWebDocuments, CenWebDocumentsId> {

	/**
	 * Delete all {@link CenWebDocuments} by flight key and user.
	 *
	 * @param cflightKey the flight key
	 * @param cuser the user
	 * @return the deleted
	 */
	Long deleteByIdCflightKeyAndIdCuser(String cflightKey, String cuser);
}
