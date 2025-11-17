/*
 *
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.masterdata.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lsgskychefs.cbase.middleware.base.rest.AbstractCbaseMiddlewareController;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseCollection;
import com.lsgskychefs.cbase.middleware.common.masterdata.business.MasterDataCateringUnitSetupService;
import com.lsgskychefs.cbase.middleware.common.rest.CommonInterfaceRoot;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenProductGroup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitProdRanges;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitProdRanges_;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

/**
 * This class provides a REST interface for interacting with the {@link MasterDataCateringUnitSetupService}.
 *
 * @author Paola Lera - U116198
 */
@RestController
@RequestMapping(CommonInterfaceRoot.COMMON_API_ROOT)

public class MasterDataCateringUnitSetupController extends AbstractCbaseMiddlewareController {

	/** The {@link MasterDataCateringUnitSetupService} that interacts with the underlying repositories */
	@Autowired
	private MasterDataCateringUnitSetupService masterDataCateringUnitSetupService;

	/**
	 * Find Prod Ranges for a specific unit and a client
	 * 
	 * @param client, the client
	 * @param unit, the chosen unit
	 * @return ResponseCollection
	 */
	@ApiOperation(value = "Find prod ranges for a specific unit and client", code = 200)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PROD_RANGES)
	public ResponseCollection getProductionRanges(@ApiParam("the client") @RequestParam final String client,
			@ApiParam("the chosen unit") @RequestParam final String unit) {
		final ResponseCollection result = new ResponseCollection();
		final List<LocUnitProdRanges> prodRanges = masterDataCateringUnitSetupService.getProductionRanges(client, unit);

		for (final LocUnitProdRanges prodRange : prodRanges) {
			final String computeText = new StringBuilder(prodRange.getCrange())
					.append((prodRange.getCdescription() != null) ? (" - " + prodRange.getCdescription()) : "").toString();

			result.creatAndAdd()
					.put("compute_text", computeText)
					.put(prodRange, LocUnitProdRanges_.nrangeKey,
							LocUnitProdRanges_.crange,
							LocUnitProdRanges_.cdescription,
							LocUnitProdRanges_.nsort,
							LocUnitProdRanges_.cunit,
							LocUnitProdRanges_.cclient);
		}

		return result;
	}

	/**
	 * Get all Product Groups
	 * 
	 * @return List<CenProductGroup>
	 */
	@ApiOperation(value = "Find all Product Groups", code = 200)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PRODUCT_GROUPS)
	public List<CenProductGroup> getProductGroups() {
		return masterDataCateringUnitSetupService.getProductGroups();
	}

	/**
	 * Get all assigned Product Groups for a given App
	 * 
	 * @param capp
	 * @return List<CenProductGroup>
	 */

	@ApiOperation(value = "Find all Product Groups for an given app", code = 200)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PRODUCT_GROUPS_APP)
	public List<CenProductGroup> getProductGroupsForApp(@ApiParam("the app name") @RequestParam final String capp) {
		return masterDataCateringUnitSetupService.getProductGroupsForApp(capp);
	}

}
