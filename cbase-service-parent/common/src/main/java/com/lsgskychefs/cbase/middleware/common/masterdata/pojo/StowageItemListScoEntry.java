/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * The Class StowageItemListEntry contains the values for native query 'stowage-itemlist-query.sql'.
 *
 * @author Heiko Rothenbach
 */
public class StowageItemListScoEntry implements CbaseMiddlewareEntry {

	/** ngalleyKey */
	private Integer ngalleyKey;

	/** nstowageKey */
	private Integer nstowageKey;

	/** cgalley */
	private String cgalley;

	/** cstowage */
	private String cstowage;

	/** cplace */
	private String cplace;

	private String cstowageClass;

	/** cplInStowage */
	private String cplInStowage;

	/** ctextStowage */
	private String ctextStowage;

	/** nquantity */
	private BigDecimal nquantity;

	/** cclass */
	private String cclass;

	/** nclassNumber */
	private Integer nclassNumber;

	/** ctype */
	private String ctype;

	/** nppmDetailKey */
	private Long nppmDetailKey;

	/** nmealInside */
	private boolean nmealInside;

	private int ncsoStatus;

	public Integer getNgalleyKey() {
		return ngalleyKey;
	}

	public void setNgalleyKey(final Integer ngalleyKey) {
		this.ngalleyKey = ngalleyKey;
	}

	public Integer getNstowageKey() {
		return nstowageKey;
	}

	public void setNstowageKey(final Integer nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	public String getCgalley() {
		return cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	public String getCstowage() {
		return cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	public String getCplace() {
		return cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	/**
	 * @return the cstowage_class
	 */
	public String getCstowageClass() {
		return cstowageClass;
	}

	/**
	 * @param cstowage_class the cstowage_class to set
	 */
	public void setCstowageClass(final String cstowageClass) {
		this.cstowageClass = cstowageClass;
	}

	public String getCplInStowage() {
		return cplInStowage;
	}

	public void setCplInStowage(final String cplInStowage) {
		this.cplInStowage = cplInStowage;
	}

	public String getCtextStowage() {
		return ctextStowage;
	}

	public void setCtextStowage(final String ctextStowage) {
		this.ctextStowage = ctextStowage;
	}

	public BigDecimal getNquantity() {
		return nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	public String getCclass() {
		return cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	public Integer getNclassNumber() {
		return nclassNumber;
	}

	public void setNclassNumber(final Integer nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	public String getCtype() {
		return ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	public Long getNppmDetailKey() {
		return nppmDetailKey;
	}

	public void setNppmDetailKey(final Long nppmDetailKey) {
		this.nppmDetailKey = nppmDetailKey;
	}

	public boolean isNmealInside() {
		return nmealInside;
	}

	public void setNmealInside(final boolean nmealInside) {
		this.nmealInside = nmealInside;
	}

	/**
	 * @return the ncsoStatus
	 */
	public int getNcsoStatus() {
		return ncsoStatus;
	}

	/**
	 * @param ncsoStatus the ncsoStatus to set
	 */
	public void setNcsoStatus(final int ncsoStatus) {
		this.ncsoStatus = ncsoStatus;
	}

}
