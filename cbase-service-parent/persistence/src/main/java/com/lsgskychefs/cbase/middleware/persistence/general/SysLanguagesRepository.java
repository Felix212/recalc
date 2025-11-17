/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLanguages;

/**
 * Repository class for {@link SysLanguages} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface SysLanguagesRepository extends PagingAndSortingRepository<SysLanguages, Long> {

	/**
	 * Get a Language by standard ISO 639-1 code.
	 *
	 * @param clangCode language code, usually ISO 639-1 code
	 * @return language
	 */
	SysLanguages findByClangCodeIgnoreCase(final String clangCode);

}
