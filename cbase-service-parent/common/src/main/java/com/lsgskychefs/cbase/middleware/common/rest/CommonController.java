/*
 * WorkorderController.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.rest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

import org.apache.commons.beanutils.BeanComparator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.base.business.CbaseRole;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;
import com.lsgskychefs.cbase.middleware.base.rest.AbstractCbaseMiddlewareController;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseCollection;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement;
import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement.ElementAttribute;
import com.lsgskychefs.cbase.middleware.common.business.CommonService;
import com.lsgskychefs.cbase.middleware.common.business.barcode.CbaseMiddlewareBarcode;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSupplier;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSupplier_;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWorkstation;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLanguages;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRemotePrinter;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysThreeLetterCodes_;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits_;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Translation;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

/**
 * This class provides a REST interface for interacting with the {@link CommonService}.
 *
 * @author Andreas Morgenstern
 */
@RestController
@RequestMapping(CommonInterfaceRoot.COMMON_API_ROOT)
public class CommonController extends AbstractCbaseMiddlewareController {

	/**
	 * The {@link CommonService} that interacts with the underlying database repositories
	 */
	@Autowired
	private CommonService commonService;

	/**
	 * Call this method to request a list of units for a given supplier from the repository
	 *
	 * @param nsupplierKey The ID of the {@link CenSupplier} to find the {@link SysUnits} for
	 * @param nnonsky used to filter units according to its value
	 * @param filter specified the desired fields
	 * @return The requested area data
	 * @throws CbaseMiddlewareBusinessException if no CenSupplier is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.UNITS_BY_SUPPLIER)
	public ResponseCollection getUnitListBySupplier(
			@PathVariable final Long nsupplierKey,
			@RequestParam(required = false) final Integer nnonsky,
			@RequestParam(required = false) final String... filter) throws CbaseMiddlewareBusinessException {

		final CenSupplier cenSupplier = commonService.getSupplierById(nsupplierKey);

		final ResponseCollection result = new ResponseCollection();
		final List<SysUnits> sortedSysUnits = new ArrayList<>(cenSupplier.getSysUnitses());

		if (nnonsky != null) {
			sortedSysUnits.removeIf((final SysUnits units) -> !units.getNnonSky().equals(nnonsky));
		}
		sortedSysUnits.sort(Comparator.comparing(a -> a.getCtext()));

		for (final SysUnits sysUnits : sortedSysUnits) {
			result.creatAndAdd(filter)
					.put(cenSupplier,
							CenSupplier_.csupplier,
							CenSupplier_.nsupplierKey)
					.put(sysUnits,
							SysUnits_.cunit,
							SysUnits_.ctext,
							SysUnits_.camosUnit)
					.put(sysUnits.getSysThreeLetterCodes(), SysThreeLetterCodes_.ntlcKey);
		}

		return result;
	}

	/**
	 * Call this method to request a list of units assigned to the given RoleID
	 * 
	 * @param role The Role as ID or Name
	 * @param filter
	 * @return The requested Units
	 * @throws CbaseMiddlewareBusinessException
	 */
	@Transactional(readOnly = true)
	@ApiOperation(value = "Get the list of units", notes = "Restrictions will be included", code = 200)
	@ApiResponses(value = { @ApiResponse(code = 409, message = "role is unknown by server") })
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.UNITS_BY_ROLE)
	public ResponseCollection getUnitListByRole(@ApiParam(value = "The CbaseRole name or ID") @RequestParam final String role,
			@RequestParam(required = false) final String... filter) throws CbaseMiddlewareBusinessException {

		final CbaseRole cbaseRole = CbaseRole.getByStringOrId(role);
		if (cbaseRole == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"The specified role is unknown");
		}

		final ResponseCollection result = new ResponseCollection();

		final List<SysUnits> sysUnits = commonService.getUnitListByRoleId(Long.valueOf(cbaseRole.getRoleId()));

		sysUnits.sort(Comparator.comparing(a -> a.getCtext()));

		for (final SysUnits sysUnit : sysUnits) {
			result.creatAndAdd(filter)
					.put(sysUnit.getCenSupplier(),
							CenSupplier_.csupplier,
							CenSupplier_.nsupplierKey)
					.put(sysUnit,
							SysUnits_.cunit,
							SysUnits_.ctext,
							SysUnits_.camosUnit)
					.put(sysUnit.getSysThreeLetterCodes(), SysThreeLetterCodes_.ntlcKey);
		}

		return result;

	}

	/**
	 * Call this method to request a list of areas for a given unit from the repository
	 *
	 * @param cunit The ID of the {@link SysUnits} to find the {@link LocUnitAreas} for
	 * @param cclient client number
	 * @param filter specified the desired fields
	 * @return The requested unit data (List of {@link LocUnitAreas})
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.AREAS_BY_UNIT)
	public ResponseCollection getAreas(
			@PathVariable final String cunit,
			@RequestParam final String cclient,
			@RequestParam(required = false) final String... filter) {
		return buildResponseCollectionDO(commonService.getLocUnitAreas(cunit, cclient), filter);
	}

	/**
	 * Call this method to request a list of workstations for given nareaKeys from the repository
	 *
	 * @param nareaKeys The IDs of the {@link LocUnitAreas} to find the {@link LocUnitWorkstation} for
	 * @param filter specified the desired fields
	 * @return the desired fields of {@link LocUnitWorkstation}
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.WORKSTATIONS_BY_AREAS)
	public ResponseCollection getWorkstationByAreas(
			@RequestParam final List<Long> nareaKeys,
			@RequestParam(required = false) final String... filter) {
		return buildResponseCollectionDO(commonService.getLocUnitWorkstations(nareaKeys), filter);
	}

	/**
	 * Get the version number of current application.
	 *
	 * @return the application version number
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.VERSION)
	public ResponseElement getVersion() {
		return new ResponseElement()
				.put(ElementAttribute.APPLICATION_VERSION, getVersionNumber())
				.put(ElementAttribute.APPLICATION_NAME, getApplicationName())
				.put(ElementAttribute.DATABASE_INFO, commonService.getDatabaseInfo())
				.put(ElementAttribute.INSTANCE, getJvmRoute());
	}

	/**
	 * Get a random SAP UID.
	 * 
	 * @return the SAP UID
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.SAPUID)
	public String getSapUID() {
		final String lsUID = UUID.randomUUID().toString();
		String lsReturn = lsUID.substring(0, 8);

		lsReturn = lsReturn.concat(lsUID.substring(9, 13));
		lsReturn = lsReturn.concat(lsUID.substring(14, 18));
		lsReturn = lsReturn.concat(lsUID.substring(19, 23));
		lsReturn = lsReturn.concat(lsUID.substring(24));

		return lsReturn;
	}

	/**
	 * Return the translation for given language.<br>
	 * cbase_data_layer#of_get_translation
	 *
	 * @param language the language to select
	 * @param filter specified the desired fields
	 * @return the translation for given language. (List of {@link Translation})
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.TRANSLATION)
	public ResponseCollection getTranslation(
			@PathVariable final int language,
			@RequestParam(required = false) final String... filter) {
		return buildResponseCollectionPojo(commonService.getTranlations(language), filter);
	}

	/**
	 * Get all {@link SysLanguages}
	 *
	 * @return all {@link SysLanguages}
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.ALL_LANGUAGES)
	public ResponseCollection getAllLanguges() {
		return buildResponseCollectionDO(commonService.getAllLanguages());
	}

	/**
	 * Parse, prepare and return the given barcode as {@link CbaseMiddlewareBarcode}.
	 *
	 * @param barcodeString the barcode numbers as String
	 * @return the parsed and prepared barcode as {@link CbaseMiddlewareBarcode}
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} - on wrong barcode string(min size is 2) or PPL data
	 *             error
	 *             </ul>
	 * @throws CbaseMiddlewareParsingException
	 *             <ul>
	 *             <li>{@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length or wrong format
	 *             </ul>
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, value = CommonInterfaceRoot.PARSE_BARCODE)
	public ResponseElement parseBarcode(@RequestParam final String barcodeString)
			throws CbaseMiddlewareBusinessException {
		return new ResponseElement().putAll(commonService.parseBarcode(barcodeString));
	}

	/**
	 * Get all {@link SysRemotePrinter} for the given unit
	 * 
	 * @param cunit the unit as String
	 * @param filter specified the desired fields
	 * @throws CbaseMiddlewareBusinessException
	 * @return all {@link SysRemotePrinter}
	 */
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.UNIT_REMOTE_PRINTERS)
	public ResponseCollection getUnitRemotePrinters(
			@PathVariable final String cunit,
			@RequestParam(required = false) final String... filter) throws CbaseMiddlewareBusinessException {
		final List<SysRemotePrinter> sysRemotePrinter = commonService.sysRemotePrinterGet(cunit);
		return buildResponseCollectionDO(sysRemotePrinter, filter);
	}

	/**
	 * load all users that are authorized for a specific role
	 *
	 * @param appRole the role id or text
	 * @return List of users
	 * @throws CbaseMiddlewareBusinessException
	 *             <ul>
	 *             <li>CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT - if the app role is not registered.
	 *             </ul>
	 */
	@ApiOperation(value = "load all users that are authorized for a specific role", code = 200)
	@ApiResponses(value = {
			@ApiResponse(code = 409, message = "if the app role is not registered!")
	})
	@JsonView(View.Simple.class)
	@Transactional(readOnly = true)
	@RequestMapping(method = RequestMethod.GET, path = CommonInterfaceRoot.USERS)
	public List<SysLogin> getUsersByAppRoleId(@ApiParam(value = "text OR id") @RequestParam final String appRole)
			throws CbaseMiddlewareBusinessException {
		return commonService.getUsersByRoleId(appRole);
	}

	// @RequestMapping(method = RequestMethod.GET, path = "runcrystal")
	// public void runCrystal(final HttpServletResponse response) throws ParseException {
	// cRJavaHelperService.test(response);
	// }

	// @RequestMapping(method = RequestMethod.GET, path = "runcrystalspawn")
	// public void runCrystalSpawn(final HttpServletResponse response) throws ParseException, IOException, InterruptedException {
	// CRJavaHelperService.exec();
	// }

	// @RequestMapping(method = RequestMethod.GET, path = "runjasper")
	// public void runJasper(final HttpServletResponse response) throws CbaseMiddlewareBusinessException, ParseException, IOException {
	// cRJavaHelperService.test2(response);
	// }
}
