/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitSetup;

/**
 * Contain a key section pair and the default value.
 *
 * @see LocUnitSetup
 * @author Alex Schaab
 */
public enum LocUnitSetupKeySection {

	SFTP_SAP_HOST("", CbaseMiddlewareDbConstants.DEFAULT, "HostProduction", ""),
	SFTP_SAP_USER("", CbaseMiddlewareDbConstants.DEFAULT, "UserProduction", ""),
	SFTP_SAP_PWD("", CbaseMiddlewareDbConstants.DEFAULT, "PasswordProduction", ""),
	SFTP_SAP_PATH("", CbaseMiddlewareDbConstants.DEFAULT, "RootProduction", ""),
	/** Some kind of Prevention Flag to skip unnecessary jobs where departure time is to far in future */
	OFFSET_AREA_ALLOC("noffsetAreaAlloc", CbaseMiddlewareDbConstants.DEFAULT, "Offset_area_alloc", "-1");

	/** JSON response mappingName */
	private String mappingName;

	/** ckey */
	private String ckey;

	/** csection */
	private String csection;

	/** defaultValue */
	private String defaultValue;

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(LocUnitSetupKeySection.class);

	LocUnitSetupKeySection(final String mappingName, final String csection, final String ckey, final String defaultValue) {
		this.mappingName = mappingName;
		this.csection = csection;
		this.ckey = ckey;
		this.defaultValue = defaultValue;
	}

	/**
	 * Get ckey
	 *
	 * @return the ckey
	 */
	public String getCkey() {
		return ckey;
	}

	/**
	 * Get csection
	 *
	 * @return the csection
	 */
	public String getCsection() {
		return csection;
	}

	/**
	 * Get defaultValue
	 *
	 * @return the defaultValue
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/**
	 * Get mappingName
	 *
	 * @return the mappingName
	 */
	public String getMappingName() {
		return mappingName;
	}

	/**
	 * Helper function to check if {@link CenSetup} values are simple booleans
	 *
	 * @param value typically a String value containing a number.
	 * @return true for "1" otherwise false
	 */
	public boolean isKeyEnabled(final String value) {
		try {
			return Integer.parseInt(value) == 1;

		} catch (final NumberFormatException e) {
			LOGGER.warn("Error on parsing String to Boolean: {} - msg: {}" + value, e.getMessage());
			return false;
		}
	}
}
