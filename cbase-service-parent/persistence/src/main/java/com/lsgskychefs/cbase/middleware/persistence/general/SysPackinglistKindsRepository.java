/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPackinglistKinds;

/**
 * Repository class for {@link SysPackinglistKinds} object/table.
 *
 * @author Paola Lera - U116198
 * @author Dirk Bunk - U200035
 */
public interface SysPackinglistKindsRepository extends PagingAndSortingRepository<SysPackinglistKinds, Long> {

	/**
	 * Find all packinglist kinds by nselection
	 * 
	 * @param nselection the nselection
	 * @return list of {@link SysPackinglistKinds}
	 */
	List<SysPackinglistKinds> findByNselection(final int nselection);

	/**
	 * Finds one entity of {@link SysPackinglistKinds} by a npackinglistIndexKey
	 * 
	 * @param npackinglistIndexKey
	 * @return entity of {@link SysPackinglistKinds}
	 */
	@Query("SELECT kind FROM SysPackinglistKinds kind, CenPackinglistIndex idx "
			+ "WHERE idx.id.npackinglistIndexKey = :npackinglistIndexKey "
			+ "AND idx.nplKindKey = kind.id.nplKindKey")
	SysPackinglistKinds findByNpackinglistIndexKey(@Param("npackinglistIndexKey") final Long npackinglistIndexKey);

	/**
	 * Finds all entities of {@link SysPackinglistKinds} by a list of ckind
	 * 
	 * @param ckinds a list of ckind
	 * @return entity of {@link SysPackinglistKinds}
	 */
	List<SysPackinglistKinds> findByCkindIn(final List<String> ckinds);
}
