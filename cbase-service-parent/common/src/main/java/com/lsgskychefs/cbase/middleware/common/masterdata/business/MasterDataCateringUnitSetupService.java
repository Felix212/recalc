/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.masterdata.business;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenProductGroup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitProdRanges;
import com.lsgskychefs.cbase.middleware.persistence.general.CenProductGroupRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitProdRangesRepository;

/**
 * Service class for the catering unit setup masterdata part of the common component.
 *
 * @author Paola Lera - U116198
 */
@Service
public class MasterDataCateringUnitSetupService extends AbstractCbaseMiddlewareService {

	/** Repository for {@link LocUnitProdRanges} entity. */
	@Autowired
	private LocUnitProdRangesRepository locUnitProdRangesRepository;

	@Autowired
	private CenProductGroupRepository cenProductGroupRepository;

	/**
	 * Find Prod Ranges for a specific unit and a client
	 * 
	 * @param cclient, the client
	 * @param cunit, the chosen unit
	 * @return list of {@link LocUnitProdRanges}
	 */
	public List<LocUnitProdRanges> getProductionRanges(final String cclient, final String cunit) {
		return locUnitProdRangesRepository.findByCclientAndCunitOrderByNsortAsc(cclient, cunit);
	}

	/**
	 * Get all Product Groups
	 * 
	 * @return List<CenProductGroup>
	 */
	public List<CenProductGroup> getProductGroups() {
		return findAll(CenProductGroup.class);
	}

	/**
	 * Get all assigned Product Groups for a given App
	 * 
	 * @param capp
	 * @return List<CenProductGroup>
	 */
	public List<CenProductGroup> getProductGroupsForApp(final String capp) {
		return cenProductGroupRepository.findForApp(capp);
	}

}
