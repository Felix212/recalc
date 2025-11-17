/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * The Class AircraftEntry contains the values for native query 'aircraft-config-by-registration-query.sql'.
 *
 * @author Ingo Rietzschel - U125742
 */
public class AircraftEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** The cairline. */
	private String cairline;

	/** The cactype. */
	private String cactype;

	/** The cgalleyversion. */
	private String cgalleyversion;

	/** The naircraft key. */
	private Integer naircraftKey;

	/** The nairline owner key. */
	private Integer nairlineOwnerKey;

	/** The ngroup key. */
	private Integer ngroupKey;

	/** The ndefault. */
	private Integer ndefault;

	/** The comp configuration. */
	private String compConfiguration;

	/**
	 * Get cairline
	 *
	 * @return the cairline
	 */
	public String getCairline() {
		return cairline;
	}

	/**
	 * set cairline
	 *
	 * @param cairline the cairline to set
	 */
	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	/**
	 * Get cactype
	 *
	 * @return the cactype
	 */
	public String getCactype() {
		return cactype;
	}

	/**
	 * set cactype
	 *
	 * @param cactype the cactype to set
	 */
	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	/**
	 * Get cgalleyversion
	 *
	 * @return the cgalleyversion
	 */
	public String getCgalleyversion() {
		return cgalleyversion;
	}

	/**
	 * set cgalleyversion
	 *
	 * @param cgalleyversion the cgalleyversion to set
	 */
	public void setCgalleyversion(final String cgalleyversion) {
		this.cgalleyversion = cgalleyversion;
	}

	/**
	 * Get naircraftKey
	 *
	 * @return the naircraftKey
	 */
	public Integer getNaircraftKey() {
		return naircraftKey;
	}

	/**
	 * set naircraftKey
	 *
	 * @param naircraftKey the naircraftKey to set
	 */
	public void setNaircraftKey(final Integer naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	/**
	 * Get nairlineOwnerKey
	 *
	 * @return the nairlineOwnerKey
	 */
	public Integer getNairlineOwnerKey() {
		return nairlineOwnerKey;
	}

	/**
	 * set nairlineOwnerKey
	 *
	 * @param nairlineOwnerKey the nairlineOwnerKey to set
	 */
	public void setNairlineOwnerKey(final Integer nairlineOwnerKey) {
		this.nairlineOwnerKey = nairlineOwnerKey;
	}

	/**
	 * Get ngroupKey
	 *
	 * @return the ngroupKey
	 */
	public Integer getNgroupKey() {
		return ngroupKey;
	}

	/**
	 * set ngroupKey
	 *
	 * @param ngroupKey the ngroupKey to set
	 */
	public void setNgroupKey(final Integer ngroupKey) {
		this.ngroupKey = ngroupKey;
	}

	/**
	 * Get ndefault
	 *
	 * @return the ndefault
	 */
	public Integer getNdefault() {
		return ndefault;
	}

	/**
	 * set ndefault
	 *
	 * @param ndefault the ndefault to set
	 */
	public void setNdefault(final Integer ndefault) {
		this.ndefault = ndefault;
	}

	/**
	 * Get compConfiguration
	 *
	 * @return the compConfiguration
	 */
	public String getCompConfiguration() {
		return compConfiguration;
	}

	/**
	 * set compConfiguration
	 *
	 * @param compConfiguration the compConfiguration to set
	 */
	public void setCompConfiguration(final String compConfiguration) {
		this.compConfiguration = compConfiguration;
	}

}
