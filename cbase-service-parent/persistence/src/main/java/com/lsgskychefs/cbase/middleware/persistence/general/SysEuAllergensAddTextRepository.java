/*
 * SysSlsKeywordsRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysEuAllergensAddText;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLanguages;

/**
 * Repository class for {@link SysEuAllergensAddText} object/table.
 *
 * @author Heiko Rothenbach - U009907
 */
public interface SysEuAllergensAddTextRepository extends PagingAndSortingRepository<SysEuAllergensAddText, Long> {

	/**
	 * Get all SysEuAllergensAddText for a given language.
	 *
	 * @param sysLanguages the language.
	 * @return the found {@link SysEuAllergensAddText}
	 */
	List<SysEuAllergensAddText> findBySysLanguagesOrderByNsortAsc(SysLanguages sysLanguages);

}
