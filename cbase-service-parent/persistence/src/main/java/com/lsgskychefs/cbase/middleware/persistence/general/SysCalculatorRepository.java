/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysCalculator;

/**
 * Repository class for {@link SysCalculator} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface SysCalculatorRepository extends PagingAndSortingRepository<SysCalculator, Long> {

}
