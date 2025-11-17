/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysEuAllergensText;

/**
 * Repository class for {@link SysEuAllergensText} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface SysEuAllergensTextRepository extends PagingAndSortingRepository<SysEuAllergensText, Long> {

	/**
	 * Get all allergen text translations for a certain language.
	 *
	 * @param nlangKey the language key
	 * @return Translated Allergen Texts
	 */
	List<SysEuAllergensText> findBySysLanguagesNlangKey(final Long nlangKey);

}
