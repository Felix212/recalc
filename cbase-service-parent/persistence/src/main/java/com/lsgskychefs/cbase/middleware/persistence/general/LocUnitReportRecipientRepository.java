/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitReportRecipient;

/**
 * Repository class for {@link LocUnitReportRecipient}
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitReportRecipientRepository extends PagingAndSortingRepository<LocUnitReportRecipient, Long> {

}
