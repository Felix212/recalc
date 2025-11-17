/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.RobLanguage;

/**
 * Repository class for {@link RobLanguage} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface RobLanguageRepository extends PagingAndSortingRepository<RobLanguage, Integer> {
	/**
	 * Find all order by clong asc.
	 *
	 * @return the list of {@link RobLanguage}
	 */
	List<RobLanguage> findAllByOrderByClongAsc();

	/**
	 * Finds the first default {@link RobLanguage} entity.
	 * 
	 * @return the entity of {@link RobLanguage}
	 */
	@Query("SELECT robLanguage FROM RobLanguage robLanguage "
			+ "WHERE robLanguage.ndefault = 1")
	RobLanguage findFirstDefault();
}
