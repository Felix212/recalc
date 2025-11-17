/*
 * WorkorderService.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.common.business;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.base.business.AbstractCbaseMiddlewareService;
import com.lsgskychefs.cbase.middleware.base.business.CbaseRole;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;
import com.lsgskychefs.cbase.middleware.common.business.barcode.CbaseMiddlewareBarcode;
import com.lsgskychefs.cbase.middleware.common.business.barcode.CbaseMiddlewareBarcodeParser;
import com.lsgskychefs.cbase.middleware.common.business.barcode.CbaseMiddlewareBarcodeType;
import com.lsgskychefs.cbase.middleware.common.persistence.CommonRepository;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPpsCateringOrder;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetupId;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSupplier;
import com.lsgskychefs.cbase.middleware.persistence.domain.GttParameter;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPpsProdBom;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitAreas;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitWorkstation;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLanguages;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRemotePrinter;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitAreasRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.LocUnitWorkstationRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysLoginRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysRemotePrinterRepository;
import com.lsgskychefs.cbase.middleware.persistence.general.SysUnitsRepository;
import com.lsgskychefs.cbase.middleware.persistence.pojo.Translation;

/**
 * Service class for the common component.
 *
 * @author Andreas Morgenstern
 */
@Service
public class CommonService extends AbstractCbaseMiddlewareService {

	/** Repository for <code>LocUnitAreas</code> entity. */
	@Autowired
	private LocUnitAreasRepository locUnitAreasRepository;

	/** Repository for {@link SysRemotePrinterRepository} entities. */
	@Autowired
	private SysRemotePrinterRepository sysRemotePrinterRepository;

	/** Repository for {@link LocUnitWorkstation} entities. */
	@Autowired
	private LocUnitWorkstationRepository locUnitWorkstationsRepository;

	@Autowired
	private SysUnitsRepository sysUnitsRepository;

	/** Common repository class */
	@Autowired
	private CommonRepository commonRepository;

	/** Repository for {@link SysLogin} entities. */
	@Autowired
	private SysLoginRepository sysLoginRepository;

	/** The Barcode parser. */
	@Autowired
	private CbaseMiddlewareBarcodeParser parser;

	/**
	 * Finds and returns a <code>CenSupplier</code> object by primary key.
	 *
	 * @param nsupplierKey the primary key value.
	 * @return The <code>CenSupplier</code> object with the primary key.
	 * @throws CbaseMiddlewareBusinessException if no CenSupplier is found {@link CbaseMiddlewareBusinessExceptionType#UNKNOWN_ID}
	 */
	@Transactional(readOnly = true)
	public CenSupplier getSupplierById(final Long nsupplierKey) throws CbaseMiddlewareBusinessException {
		return findOne(CenSupplier.class, nsupplierKey);
	}

	/**
	 * Finds and returns a <code>List</code> of <code>LocUnitAreas</code> objects by the <code>cunit</code> attribute.
	 *
	 * @param cunit the attribute value used as search parameter.
	 * @param cclient the client value used as search parameter.
	 * @return The <code>List<LocUnitAreas></code> found using the given attribute value.
	 */
	@Transactional(readOnly = true)
	public List<LocUnitAreas> getLocUnitAreas(final String cunit, final String cclient) {
		return locUnitAreasRepository.findByCunitAndCclient(cunit, cclient);
	}

	/**
	 * Finds and returns a <code>List</code> of <code>LocUnitAreas</code> objects by a collection of <code>nareaKey</code> attribute.
	 *
	 * @param nareaKeys Collection of nareaKeys.
	 * @return The <code>List<LocUnitAreas></code> found using the given attribute value.
	 */
	@Transactional(readOnly = true)
	public List<LocUnitWorkstation> getLocUnitWorkstations(final List<Long> nareaKeys) {
		return locUnitWorkstationsRepository.findByNareaKeyIn(nareaKeys);
	}

	/**
	 * Search the setup value.<br>
	 * n_setup#of_profilestring
	 *
	 * @param id the id for searched value
	 * @param defaultValue the default value is added when no value was found
	 * @return the found value or the default value
	 */
	public CenSetup getCenSetup(final CenSetupId id, final String defaultValue) {
		CenSetup cenSetup = cbaseMiddlewareRepository.findOne(CenSetup.class, id);
		if (cenSetup == null) {
			cenSetup = new CenSetup(id, defaultValue, null, null);
		}
		return cenSetup;
	}

	/**
	 * Return the translation for given language.
	 *
	 * @param languageColumnPosition the language column position to select
	 * @return the translation for given language.
	 */
	public List<Translation> getTranlations(final int languageColumnPosition) {
		return commonRepository.getTranlations(languageColumnPosition);

	}

	/**
	 * The units of current context(current user, client, supplier and given role)
	 *
	 * @param nroleId role to specify the context(app role)
	 * @return the list of {@link SysUnits}
	 */
	public List<SysUnits> getUnitsByContext(final int nroleId) {
		return commonRepository.findUnityByContext(getClient(), getSupplier(), getLoginUser().getLogin().getNuserId(), nroleId);
	}

	/**
	 * Get the current database instance name.
	 *
	 * @return the current database instance name.
	 */
	public String getDatabaseInfo() {
		return commonRepository.getDBInfo();
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
	public CbaseMiddlewareBarcode parseBarcode(final String barcodeString) throws CbaseMiddlewareBusinessException {
		// validation
		if (barcodeString.length() < 2) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"The barcode string is wrong (min size is 2)");
		}
		// parse barcode
		final CbaseMiddlewareBarcode barcode = parser.parse(barcodeString);
		// on PPS_LABEL: data from database will retrieve and set on barcode
		if (CbaseMiddlewareBarcodeType.PPS_LABEL == barcode.getBarcodeType()) {
			final Long ncontainerKey = barcode.getNcontainerKey();
			final CenPpsCateringOrder cateringOrder = commonRepository.findCenPpsCateringOrder(ncontainerKey);
			final LocPpsProdBom prodBom = commonRepository.findLocPpsProdBom(ncontainerKey);
			if (cateringOrder == null || prodBom == null) {
				throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
						String.format(
								"Error with PPS_LABEL code. No CenPpsCateringOrder or LocPpsProdBom on database found for given container key!  barcode: %s - CenPpsCateringOrder: %s - LocPpsProdBom: %s - ncontainerKey: %s ",
								barcodeString, cateringOrder, prodBom, ncontainerKey));
			}
			barcode.setReferenceDate(cateringOrder.getDdeparture());
			barcode.setNpackinglistIndexKey(prodBom.getNpackinglistIndexKey());
			return barcode;
		}
		return barcode;
	}

	/**
	 * Get all {@link SysLanguages}
	 * 
	 * @return all {@link SysLanguages}
	 */
	public List<SysLanguages> getAllLanguages() {
		return findAll(SysLanguages.class);
	}

	/**
	 * Get all {@link SysRemotePrinter} for the given unit
	 * 
	 * @param cunit the unit as String
	 * @return all {@link SysRemotePrinter}
	 */
	public List<SysRemotePrinter> sysRemotePrinterGet(final String cunit) throws CbaseMiddlewareBusinessException {
		final SysUnits sysUnit = findOne(SysUnits.class, cunit);
		return sysRemotePrinterRepository.findBySysUnitsOrderByCnameAsc(sysUnit);
	}

	/**
	 * Create new {@link GttParameter}s with given values.
	 *
	 * @param cparamName the parameter name
	 * @param paramValues a list of values
	 * @return the new {@link GttParameter}s
	 */
	public <T> List<GttParameter> createGttParameter(final String cparamName, final List<T> paramValues) {
		final List<GttParameter> gttParameters = new ArrayList<>();

		for (final T value : paramValues) {
			if (value.getClass() == String.class) {
				gttParameters.add(createGttParameter(cparamName, (String) value));
			} else if (value.getClass() == Long.class) {
				gttParameters.add(createGttParameter(cparamName, (Long) value));
			} else if (value.getClass() == Date.class) {
				gttParameters.add(createGttParameter(cparamName, (Date) value));
			}
		}

		return gttParameters;
	}

	/**
	 * Create a new {@link GttParameter} with given values.
	 *
	 * @param cparamName name of parameter
	 * @param paramValue value of parameter
	 * @return the new GttParameter instance.
	 */
	public GttParameter createGttParameter(final String cparamName, final long paramValue) {
		final GttParameter parameter = new GttParameter();
		parameter.setCparmName(cparamName);
		parameter.setNparmNumber(paramValue);
		return parameter;
	}

	/**
	 * Create a new {@link GttParameter} with given values.
	 *
	 * @param cparamName name of parameter
	 * @param paramValue value of parameter
	 * @return the new GttParameter instance.
	 */
	public GttParameter createGttParameter(final String cparamName, final String paramValue) {
		final GttParameter parameter = new GttParameter();
		parameter.setCparmName(cparamName);
		parameter.setCparmVarchar2(paramValue);
		return parameter;
	}

	/**
	 * Create a new {@link GttParameter} with given values.
	 *
	 * @param cparamName name of parameter
	 * @param paramValue value of parameter
	 * @return the new GttParameter instance.
	 */
	public GttParameter createGttParameter(final String cparamName, final Date paramValue) {
		final GttParameter parameter = new GttParameter();
		parameter.setCparmName(cparamName);
		parameter.setDparmDate(paramValue);

		return parameter;
	}

	/**
	 * Get the Units assigned to the RoleID
	 * 
	 * @param nroleId
	 * @return
	 */
	public List<SysUnits> getUnitListByRoleId(final Long nroleId) {

		final SysLogin login = getLoginUser().getLogin();

		return sysUnitsRepository.getSysUnitsByRoleId(nroleId, Long.valueOf(login.getNuserId()));
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
	public List<SysLogin> getUsersByRoleId(final String appRole) throws CbaseMiddlewareBusinessException {
		final CbaseRole cbaseRole = CbaseRole.getByStringOrId(appRole);
		if (cbaseRole == null) {
			throw new CbaseMiddlewareBusinessException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					"The specified role is unknown");
		}

		final List<SysLogin> userList = sysLoginRepository.findUsersByDirectRole(cbaseRole.getRoleId());

		for (final SysLogin user : sysLoginRepository.findUsersByGroupRole(cbaseRole.getRoleId())) {
			if (!userList.contains(user)) {
				userList.add(user);
			}
		}

		return userList;
	}
}
