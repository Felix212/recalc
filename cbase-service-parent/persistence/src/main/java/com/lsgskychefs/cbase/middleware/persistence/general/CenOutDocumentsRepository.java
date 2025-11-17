/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutDocuments;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutDocumentsId;

/**
 * Repository class for {@link CenOutDocuments} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenOutDocumentsRepository extends PagingAndSortingRepository<CenOutDocuments, CenOutDocumentsId> {

	/**
	 * Delete {@link CenOutDocuments} by given flight and transaction.
	 *
	 * @param nresultKey flight key
	 * @param ntransaction transaction key
	 */
	void deleteByIdNresultKeyAndIdNtransaction(long nresultKey, long ntransaction);
		
	/**
	 * @param nresultKeys
	 * @param cuser
	 * @return
	 */
	List<CenOutDocuments> findByIdCuserAndCenOutNresultKeyIn(String cuser, List<Long> nresultKeys);

	/**
	 * Find Document Browser Cen Out Documents
	 * 
	 * @param nresultKeys, the ID's
	 * @param cuser, the user
	 * @return list of {@link CenOutDocuments}
	 */
	@Query("SELECT doc FROM CenOutDocuments doc "
			+ "JOIN doc.cenOut co "
			+ "WHERE co.ntransaction = doc.id.ntransaction "
			+ "AND co.nresultKey in (:arg_resultkeys) "
			+ "AND doc.id.cuser = :arg_user")
	List<CenOutDocuments> findCenOutDocumentsByResultKeysAndCuser(
			@Param("arg_resultkeys") final List<Long> nresultKeys, @Param("arg_user") final String cuser);
	
	
}
