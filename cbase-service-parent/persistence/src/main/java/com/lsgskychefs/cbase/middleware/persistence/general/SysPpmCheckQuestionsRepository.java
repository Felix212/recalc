/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmCheckQuestions;

/**
 * Repository class for {@link SysPpmCheckQuestions} object/table.
 *
 * @author Dirk Bunk - U200035
 */
public interface SysPpmCheckQuestionsRepository extends PagingAndSortingRepository<SysPpmCheckQuestions, Long> {

	/**
	 * Gets all questions by nactive flag ordered by nsort
	 *
	 * @param nactive
	 * @return List<SysPpmCheckQuestions>
	 */
	List<SysPpmCheckQuestions> findAllByNactiveOrderByNsortAsc(final boolean nactive);

}
