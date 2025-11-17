/*
 * CenOutCommentRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenProductGroup;

/**
 * Repository class.
 *
 * @author Heiko Rothenbach
 */
public interface CenProductGroupRepository extends PagingAndSortingRepository<CenProductGroup, Long> {
	/**
	 * Return all Product Groups assigned to the given app
	 * 
	 * @param capp
	 * @return List<CenProductGroup>
	 */
	@Query("SELECT p FROM CenProductGroup p, SysAppProductGroup h WHERE "
			+ "p.nproductIndexKey=h.id.nproctIndexKey "
			+ "AND h.id.capp=:capp")
	List<CenProductGroup> findForApp(@Param("capp") String capp);

}
