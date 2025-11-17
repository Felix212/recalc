/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.pojo;

import java.util.List;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareResponse;

/**
 * Response object for galley data.
 *
 * @author Ingo Rietzschel - U125742
 */
public class GalleyResponse extends AbstractPojo implements CbaseMiddlewareResponse {

	/** cgalley */
	private String cgalley;
	/** ctext */
	private String ctext;
	/** nsort */
	private Integer nsort;
	/** stowages */
	private List<StowageResponse> stowages;

	/**
	 * Get cgalley
	 *
	 * @return the cgalley
	 */
	public String getCgalley() {
		return cgalley;
	}

	/**
	 * set cgalley
	 *
	 * @param cgalley the cgalley to set
	 */
	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	/**
	 * Get ctext
	 *
	 * @return the ctext
	 */
	public String getCtext() {
		return ctext;
	}

	/**
	 * set ctext
	 *
	 * @param ctext the ctext to set
	 */
	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	/**
	 * Get nsort
	 *
	 * @return the nsort
	 */
	public Integer getNsort() {
		return nsort;
	}

	/**
	 * set nsort
	 *
	 * @param nsort the nsort to set
	 */
	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	/**
	 * Get stowages
	 *
	 * @return the stowages
	 */
	public List<StowageResponse> getStowages() {
		return stowages;
	}

	/**
	 * set stowages
	 *
	 * @param stowages the stowages to set
	 */
	public void setStowages(final List<StowageResponse> stowages) {
		this.stowages = stowages;
	}
}
