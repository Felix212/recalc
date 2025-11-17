/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenCateringUoPdf;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenCateringUoPdfId;

/**
 * Repository class for {@link CenCateringUoPdf} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface CenCateringUoPdfRepository extends PagingAndSortingRepository<CenCateringUoPdf, CenCateringUoPdfId> {

	/**
	 * {@link CenCateringUoPdf} by given id and date.
	 *
	 * @param ncateringUserobjectIds ids
	 * @param ddepartureDate the
	 * @return list of {@link CenCateringUoPdf}
	 */
	@Query("SELECT pdf FROM CenCateringUoPdf pdf "
			+ "WHERE pdf.id.ncateringUserobjectId IN (:ncateringUserobjectIds) "
			+ "AND pdf.id.dvalidFrom <= :ddepartureDate "
			+ "AND pdf.dvalidTo >= :ddepartureDate ")
	List<CenCateringUoPdf> findByIdAndDate(@Param("ncateringUserobjectIds") Collection<Long> ncateringUserobjectIds,
			@Param("ddepartureDate") Date ddepartureDate);
}
