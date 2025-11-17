/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitFloorplan;

/**
 * @author Xhon Vrushi - U185182
 */
public interface LocUnitFloorplanRepository extends PagingAndSortingRepository<LocUnitFloorplan, Long> {

}
