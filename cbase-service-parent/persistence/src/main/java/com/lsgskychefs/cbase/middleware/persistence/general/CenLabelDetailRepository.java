/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenLabelDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenLabelDetailId;

/**
 * Repository class for {@link CenLabelDetail} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenLabelDetailRepository extends PagingAndSortingRepository<CenLabelDetail, CenLabelDetailId> {

	/**
	 * Get label detail data.
	 *
	 * @param nlabelTypeKey label type
	 * @param ddeparture departure date
	 * @return label detail data.
	 */
	@Query("SELECT label FROM CenLabelDetail label "
			+ "WHERE label.id.nlabelTypeKey = :nlabelTypeKey "
			+ "AND label.ccolumn = 'cdistributed_components' "
			+ "AND :ddeparture BETWEEN label.id.dvalidFrom AND label.cenLabelTypeDetail.dvalidTo")
	CenLabelDetail findLabelDetail(@Param("nlabelTypeKey") long nlabelTypeKey, @Param("ddeparture") Date ddeparture);
}
