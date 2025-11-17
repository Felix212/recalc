/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenLabelTypeDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenLabelTypeDetailId;

/**
 * Repository class for {@link CenLabelTypeDetail} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenLabelTypeDetailRepository extends PagingAndSortingRepository<CenLabelTypeDetail, CenLabelTypeDetailId> {

	/**
	 * Find the {@link CenLabelTypeDetail} by id (nlabelTypeKey and date)
	 *
	 * @param nlabelTypeKey the label type key
	 * @param date the valid date
	 * @return the found {@link CenLabelTypeDetail}
	 */
	@Query("SELECT labelType FROM CenLabelTypeDetail labelType "
			+ "WHERE labelType.id.nlabelTypeKey = :nlabelTypeKey "
			+ "AND :date BETWEEN labelType.id.dvalidFrom AND labelType.dvalidTo")
	CenLabelTypeDetail findByLabelTypeKeyAndDate(@Param("nlabelTypeKey") Long nlabelTypeKey, @Param("date") Date date);
}
