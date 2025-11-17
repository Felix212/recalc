/*
 * SysSlsKeywordsRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysSlsKeyword;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysSlsKeywordCategory;

/**
 * Repository class. Heiko Rothenbach
 */
public interface SysSlsKeywordRepository extends PagingAndSortingRepository<SysSlsKeyword, Long> {

	/**
	 * Find SysSlsKeywords by SysSlsKeywordCategory-Object.
	 *
	 * @param sysSlsKeywordCategory the SysSlsKeywordCategory-Object
	 * @return List of SysSlsKeywords Entries
	 */
	List<SysSlsKeyword> findBySysSlsKeywordCategoryOrderByNsortAsc(SysSlsKeywordCategory sysSlsKeywordCategory);

	/**
	 * Gets a list of Keywords
	 * 
	 * @param nkeywordKeys the ids
	 * @return List of {@link SysSlsKeyword}
	 */
	List<SysSlsKeyword> findByNkeywordKeyIn(ArrayList<Long> nkeywordKeys);

}
