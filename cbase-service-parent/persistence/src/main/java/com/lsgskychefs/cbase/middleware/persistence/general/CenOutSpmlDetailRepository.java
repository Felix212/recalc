/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpmlDetail;

/**
 * Repository class for {@link CenOutSpmlDetail} entity/table.
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */
public interface CenOutSpmlDetailRepository extends PagingAndSortingRepository<CenOutSpmlDetail, Long> {

	/**
	 * List of spml details from flight with picture.
	 *
	 * @param nresultKey the flight key
	 * @return list of spml details
	 */
	@EntityGraph(attributePaths = { "cenPackinglists.cenPackinglistPictures.cenPictures" })
	@Query("SELECT spmlDetail FROM CenOutSpmlDetail spmlDetail "
			+ "JOIN spmlDetail.cenPackinglists packinglist "
			+ "JOIN packinglist.cenPackinglistPictures packinglistPicture  "
			+ "JOIN packinglistPicture.cenPictures picture "
			+ "JOIN spmlDetail.cenOutSpml spml "
			+ "WHERE spml.nresultKey = :nresultKey ")
	List<CenOutSpmlDetail> findBySpmlsWithPictures(@Param("nresultKey") long nresultKey);

	/**
	 * List of spml details from flight
	 * 
	 * @param nresultKey the flight key
	 * @return list of spml details
	 */
	List<CenOutSpmlDetail> findByCenOutSpmlNresultKey(@Param("nresultKey") long nresultKey);
}
