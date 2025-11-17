/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.pojo;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenObjectEquipment;
import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareResponse;

/**
 * Response object for stowage data.
 *
 * @author Ingo Rietzschel - U125742
 */
public class StowageResponse extends AbstractPojo implements CbaseMiddlewareResponse {

	/** nstowageKey */
	private long nstowageKey;
	/** cstowage */
	private String cstowage;
	/** cplace */
	private String cplace;
	/** nbelly */
	private int nbelly;
	/** nsort */
	private int nsort;
	/** npage */
	private int npage;
	/** nxpos */
	private int nxpos;
	/** nypos */
	private int nypos;
	/** ctext */
	private String ctext;
	/** objectEquipment */
	private CenObjectEquipment objectEquipment;

	/**
	 * Get nstowageKey
	 *
	 * @return the nstowageKey
	 */
	public long getNstowageKey() {
		return nstowageKey;
	}

	/**
	 * set nstowageKey
	 *
	 * @param nstowageKey the nstowageKey to set
	 */
	public void setNstowageKey(final long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	/**
	 * Get cstowage
	 *
	 * @return the cstowage
	 */
	public String getCstowage() {
		return cstowage;
	}

	/**
	 * set cstowage
	 *
	 * @param cstowage the cstowage to set
	 */
	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	/**
	 * Get cplace
	 *
	 * @return the cplace
	 */
	public String getCplace() {
		return cplace;
	}

	/**
	 * set cplace
	 *
	 * @param cplace the cplace to set
	 */
	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	/**
	 * Get nbelly
	 *
	 * @return the nbelly
	 */
	public int getNbelly() {
		return nbelly;
	}

	/**
	 * set nbelly
	 *
	 * @param nbelly the nbelly to set
	 */
	public void setNbelly(final int nbelly) {
		this.nbelly = nbelly;
	}

	/**
	 * Get nsort
	 *
	 * @return the nsort
	 */
	public int getNsort() {
		return nsort;
	}

	/**
	 * set nsort
	 *
	 * @param nsort the nsort to set
	 */
	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	/**
	 * Get npage
	 *
	 * @return the npage
	 */
	public int getNpage() {
		return npage;
	}

	/**
	 * set npage
	 *
	 * @param npage the npage to set
	 */
	public void setNpage(final int npage) {
		this.npage = npage;
	}

	/**
	 * Get nxpos
	 *
	 * @return the nxpos
	 */
	public int getNxpos() {
		return nxpos;
	}

	/**
	 * set nxpos
	 *
	 * @param nxpos the nxpos to set
	 */
	public void setNxpos(final int nxpos) {
		this.nxpos = nxpos;
	}

	/**
	 * Get nypos
	 *
	 * @return the nypos
	 */
	public int getNypos() {
		return nypos;
	}

	/**
	 * set nypos
	 *
	 * @param nypos the nypos to set
	 */
	public void setNypos(final int nypos) {
		this.nypos = nypos;
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
	 * Get objectEquipment
	 *
	 * @return the objectEquipment
	 */
	public CenObjectEquipment getObjectEquipment() {
		return objectEquipment;
	}

	/**
	 * set objectEquipment
	 *
	 * @param objectEquipment the objectEquipment to set
	 */
	public void setObjectEquipment(final CenObjectEquipment objectEquipment) {
		this.objectEquipment = objectEquipment;
	}
}
