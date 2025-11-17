/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (flight-stowage-md-co-query.sql and flight-stowage-packinglist-detail-query.sql).
 *
 * @author Ingo Rietzschel - U125742
 */
public class FlightStowageContentEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** cpackinglist */
	private String cpackinglist;

	/** ctext */
	private String ctext;

	/** nquantity */
	private BigDecimal nquantity;

	/** cclass */
	private String cclass;

	/** cmealControlCode */
	private String cmealControlCode;

	/** npictureIndexKey */
	private Long npictureIndexKey;

	/** nmealFlag */
	private int nmealFlag;

	/** npackinglistIndexKey */
	private long npackinglistIndexKey;

	/** npackinglistDetailKey */
	private long npackinglistDetailKey;

	/** ctextShort */
	private String ctextShort;

	/**
	 * Get cpackinglist
	 *
	 * @return the cpackinglist
	 */
	public String getCpackinglist() {
		return cpackinglist;
	}

	/**
	 * set cpackinglist
	 *
	 * @param cpackinglist the cpackinglist to set
	 */
	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
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
	 * Get nquantity
	 *
	 * @return the nquantity
	 */
	public BigDecimal getNquantity() {
		return nquantity;
	}

	/**
	 * set nquantity
	 *
	 * @param nquantity the nquantity to set
	 */
	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	/**
	 * Get cclass
	 *
	 * @return the cclass
	 */
	public String getCclass() {
		return cclass;
	}

	/**
	 * set cclass
	 *
	 * @param cclass the cclass to set
	 */
	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	/**
	 * Get cmealControlCode
	 *
	 * @return the cmealControlCode
	 */
	public String getCmealControlCode() {
		return cmealControlCode;
	}

	/**
	 * set cmealControlCode
	 *
	 * @param cmealControlCode the cmealControlCode to set
	 */
	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	/**
	 * Get npictureIndexKey
	 *
	 * @return the npictureIndexKey
	 */
	public Long getNpictureIndexKey() {
		return npictureIndexKey;
	}

	/**
	 * set npictureIndexKey
	 *
	 * @param npictureIndexKey the npictureIndexKey to set
	 */
	public void setNpictureIndexKey(final Long npictureIndexKey) {
		this.npictureIndexKey = npictureIndexKey;
	}

	/**
	 * Get nmealFlag
	 *
	 * @return the nmealFlag
	 */
	public int getNmealFlag() {
		return nmealFlag;
	}

	/**
	 * set nmealFlag
	 *
	 * @param nmealFlag the nmealFlag to set
	 */
	public void setNmealFlag(final int nmealFlag) {
		this.nmealFlag = nmealFlag;
	}

	/**
	 * Get npackinglistIndexKey
	 *
	 * @return the npackinglistIndexKey
	 */
	public long getNpackinglistIndexKey() {
		return npackinglistIndexKey;
	}

	/**
	 * set npackinglistIndexKey
	 *
	 * @param npackinglistIndexKey the npackinglistIndexKey to set
	 */
	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	/**
	 * Get npackinglistDetailKey
	 *
	 * @return the npackinglistDetailKey
	 */
	public long getNpackinglistDetailKey() {
		return npackinglistDetailKey;
	}

	/**
	 * set npackinglistDetailKey
	 *
	 * @param npackinglistDetailKey the npackinglistDetailKey to set
	 */
	public void setNpackinglistDetailKey(final long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	/**
	 * Get ctextShort
	 *
	 * @return the ctextShort
	 */
	public String getCtextShort() {
		return ctextShort;
	}

	/**
	 * set ctextShort
	 *
	 * @param ctextShort the ctextShort to set
	 */
	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}
}
