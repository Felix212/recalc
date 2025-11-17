/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMaster;

/**
 * Repository class for {@link CenOutMaster} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface CenOutMasterRepository extends PagingAndSortingRepository<CenOutMaster, Long> {

	/**
	 * Get all {@link CenOutMaster} entities by result key.
	 *
	 * @param nresultKey
	 * @return the list of {@link CenOutMaster} entities
	 */
	List<CenOutMaster> findByNresultKey(long nresultKey);

	/**
	 * Delete all {@link CenOutMaster} entities by result key.
	 * 
	 * @param nresultKey
	 */
	@Modifying
	@Transactional
	@Query(value = "delete from CenOutMaster c where c.nresultKey = :arg_resultkey")
	void deleteByNresultKey(@Param("arg_resultkey") final Long nresultKey);
}
