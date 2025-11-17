/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;

/**
 * Contain a key section pair and the default value.
 *
 * @see CenSetup, CenSetupId
 * @author Ingo Rietzschel - U125742
 */
public enum CenSetupKeySection {

	PPM_ALERT_MINUTES("nminutes", "PPM", "AlertMinutes", "15"),
	PPM_COLOR_WARNING("ncolor_warning", "PPM", "ColorWarning", "65535"),
	PPM_COLOR_ALERT("ncolor_alert", "PPM", "ColorAlert", "255"),
	DOCUMENT_ENGINE_ENABELE_CHANGE_CENTER_QUEUE("enable_change_center_queue", "DocumentEngine", "EnableChangeCenterQueue", "0"),
	TRACELEVEL("tracelevel", "PPM", "Tracelevel", "1"),
	PPM_CONTAINER_UNITS("container_units", "PPM", "ContainerUnits", ""),
	PPM_CONTAINER_KINDS("container_kinds", "PPM", "ContainerKinds", "PAL"),
	PPM_PARENT_PLACE_IDENTIFIER("parent_place_identifier", "PPM", "ParentPlaceIdentifier", "!"),
	PPM_CHILD_PLACE_IDENTIFIER("child_place_identifier", "PPM", "ChildPlaceIdentifier", "*");

	/** JSON response mappingName */
	private String mappingName;

	/** ckey */
	private String ckey;

	/** csection */
	private String csection;

	/** defaultValue */
	private String defaultValue;

	/** The logger. */
	private static final Logger LOGGER = LoggerFactory.getLogger(CenSetupKeySection.class);

	CenSetupKeySection(final String mappingName, final String csection, final String ckey, final String defaultValue) {
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
