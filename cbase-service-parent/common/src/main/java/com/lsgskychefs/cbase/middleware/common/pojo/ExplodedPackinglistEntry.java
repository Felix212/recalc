/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (packinglist-general-explosion-query.sql)
 *
 * @author Alex Schaab - U524036
 */
public class ExplodedPackinglistEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** The npackinglist index key. */
	private Long npackinglistIndexKey;

	/** The npackinglist detail key. */
	private Long npackinglistDetailKey;

	/** The cpackinglist. */
	private String cpackinglist;

	/** The ctext. */
	private String ctext;

	/** All child packinglists */
	private List<ExplodedPackinglistEntry> children = new ArrayList<>();

	/** The nquantity. */
	private BigDecimal nquantity;

	/** The ctype. */
	private String ctype;

	/** The npackinglist key. */
	private Long npackinglistKey;

	/** The nlevel. */
	@JsonIgnore
	private Integer nlevel;

	/** The clevel. */
	@JsonIgnore
	private String clevel;

	/** The nsort. */
	@JsonIgnore
	private int nsort;

	/** The cunit. */
	@JsonIgnore
	private String cunit;

	/** The nquantity cal. */
	@JsonIgnore
	private BigDecimal nquantityCal;

	/** The nreckoning. */
	@JsonIgnore
	private Long nreckoning;

	/** The nworkstation key. */
	@JsonIgnore
	private Long nworkstationKey;

	/** The narea key. */
	@JsonIgnore
	private Long nareaKey;

	/**
	 * Get npackinglistIndexKey
	 *
	 * @return the npackinglistIndexKey
	 */
	public Long getNpackinglistIndexKey() {
		return npackinglistIndexKey;
	}

	/**
	 * set npackinglistIndexKey
	 *
	 * @param npackinglistIndexKey the npackinglistIndexKey to set
	 */
	public void setNpackinglistIndexKey(final Long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	/**
	 * Get npackinglistDetailKey
	 *
	 * @return the npackinglistDetailKey
	 */
	public Long getNpackinglistDetailKey() {
		return npackinglistDetailKey;
	}

	/**
	 * set npackinglistDetailKey
	 *
	 * @param npackinglistDetailKey the npackinglistDetailKey to set
	 */
	public void setNpackinglistDetailKey(final Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

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
	 * Get nlevel
	 *
	 * @return the nlevel
	 */
	public Integer getNlevel() {
		return nlevel;
	}

	/**
	 * set nlevel
	 *
	 * @param nlevel the nlevel to set
	 */
	public void setNlevel(final Integer nlevel) {
		this.nlevel = nlevel;
	}

	/**
	 * Get npackinglistKey
	 *
	 * @return the npackinglistKey
	 */
	public Long getNpackinglistKey() {
		return npackinglistKey;
	}

	/**
	 * set npackinglistKey
	 *
	 * @param npackinglistKey the npackinglistKey to set
	 */
	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	/**
	 * Get clevel
	 *
	 * @return the clevel
	 */
	public String getClevel() {
		return clevel;
	}

	/**
	 * set clevel
	 *
	 * @param clevel the clevel to set
	 */
	public void setClevel(final String clevel) {
		this.clevel = clevel;
	}

	/**
	 * Get ctype
	 *
	 * @return the ctype
	 */
	public String getCtype() {
		return ctype;
	}

	/**
	 * set ctype
	 *
	 * @param ctype the ctype to set
	 */
	public void setCtype(final String ctype) {
		this.ctype = ctype;
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
	 * Get cunit
	 *
	 * @return the cunit
	 */
	public String getCunit() {
		return cunit;
	}

	/**
	 * set cunit
	 *
	 * @param cunit the cunit to set
	 */
	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	/**
	 * Get nquantityCal
	 *
	 * @return the nquantityCal
	 */
	public BigDecimal getNquantityCal() {
		return nquantityCal;
	}

	/**
	 * set nquantityCal
	 *
	 * @param nquantityCal the nquantityCal to set
	 */
	public void setNquantityCal(final BigDecimal nquantityCal) {
		this.nquantityCal = nquantityCal;
	}

	/**
	 * Get nreckoning
	 *
	 * @return the nreckoning
	 */
	public Long getNreckoning() {
		return nreckoning;
	}

	/**
	 * set nreckoning
	 *
	 * @param nreckoning the nreckoning to set
	 */
	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	/**
	 * Get nworkstationKey
	 *
	 * @return the nworkstationKey
	 */
	public Long getNworkstationKey() {
		return nworkstationKey;
	}

	/**
	 * set nworkstationKey
	 *
	 * @param nworkstationKey the nworkstationKey to set
	 */
	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	/**
	 * Get nareaKey
	 *
	 * @return the nareaKey
	 */
	public Long getNareaKey() {
		return nareaKey;
	}

	/**
	 * set nareaKey
	 *
	 * @param nareaKey the nareaKey to set
	 */
	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
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
	 * Get children
	 *
	 * @return the children
	 */
	@Transient
	public List<ExplodedPackinglistEntry> getChildren() {
		return children;
	}

	/**
	 * Set children
	 * 
	 * @param children the children to set
	 */
	public void setChildren(final List<ExplodedPackinglistEntry> children) {
		this.children = children;
	}

}
