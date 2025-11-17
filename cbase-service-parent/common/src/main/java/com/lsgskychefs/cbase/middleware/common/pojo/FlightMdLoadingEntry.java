/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query flight-loading-md-lo-query.sql.
 *
 * @author Ingo Rietzschel - U125742
 */
public class FlightMdLoadingEntry extends AbstractPojo implements CbaseMiddlewareEntry {
	/** cgalley */
	private String cgalley;

	/** cstowage */
	private String cstowage;

	/** cplace */
	private String cplace;

	/** cclass */
	private String cclass;

	/** cpackinglist */
	private String cpackinglist;

	/** cloadinglist */
	private String cloadinglist;

	/** ctextPckl */
	private String ctextPckl;

	/** cunit */
	private String cunit;

	/** nquantity */
	private Integer nquantity;

	/** nbellyContainer */
	private Integer nbellyContainer;

	/** mdCoCpackinglist */
	private String mdCoCpackinglist;

	/** mdCoNquantity */
	private BigDecimal mdCoNquantity;

	/** mdCoCtext */
	private String mdCoCtext;

	/** mdCoCremark */
	private String mdCoCremark;

	/** mdCoCplType */
	private String mdCoCplType;

	/** mdCoCclass */
	private String mdCoCclass;

	/** mdCoCmealControlCode */
	private String mdCoCmealControlCode;

	/** mdCoNspml */
	private Long mdCoNspml;

	/** nstowageKey */
	private Long nstowageKey;

	/** npackinglistIndexKey */
	private Long npackinglistIndexKey;

	/** npackinglistDetailKey */
	private Long npackinglistDetailKey;

	/** npictureIndexKey */
	private Long npictureIndexKey;

	/** napproved */
	private Long napproved;

	/** ctextShort */
	private String ctextShort;

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
	 * Get cloadinglist
	 *
	 * @return the cloadinglist
	 */
	public String getCloadinglist() {
		return cloadinglist;
	}

	/**
	 * set cloadinglist
	 *
	 * @param cloadinglist the cloadinglist to set
	 */
	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	/**
	 * Get ctextPckl
	 *
	 * @return the ctextPckl
	 */
	public String getCtextPckl() {
		return ctextPckl;
	}

	/**
	 * set ctextPckl
	 *
	 * @param ctextPckl the ctextPckl to set
	 */
	public void setCtextPckl(final String ctextPckl) {
		this.ctextPckl = ctextPckl;
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
	 * Get nquantity
	 *
	 * @return the nquantity
	 */
	public Integer getNquantity() {
		return nquantity;
	}

	/**
	 * set nquantity
	 *
	 * @param nquantity the nquantity to set
	 */
	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	/**
	 * Get nbellyContainer
	 *
	 * @return the nbellyContainer
	 */
	public Integer getNbellyContainer() {
		return nbellyContainer;
	}

	/**
	 * set nbellyContainer
	 *
	 * @param nbellyContainer the nbellyContainer to set
	 */
	public void setNbellyContainer(final Integer nbellyContainer) {
		this.nbellyContainer = nbellyContainer;
	}

	/**
	 * Get mdCoCpackinglist
	 *
	 * @return the mdCoCpackinglist
	 */
	public String getMdCoCpackinglist() {
		return mdCoCpackinglist;
	}

	/**
	 * set mdCoCpackinglist
	 *
	 * @param mdCoCpackinglist the mdCoCpackinglist to set
	 */
	public void setMdCoCpackinglist(final String mdCoCpackinglist) {
		this.mdCoCpackinglist = mdCoCpackinglist;
	}

	/**
	 * Get mdCoNquantity
	 *
	 * @return the mdCoNquantity
	 */
	public BigDecimal getMdCoNquantity() {
		return mdCoNquantity;
	}

	/**
	 * set mdCoNquantity
	 *
	 * @param mdCoNquantity the mdCoNquantity to set
	 */
	public void setMdCoNquantity(final BigDecimal mdCoNquantity) {
		this.mdCoNquantity = mdCoNquantity;
	}

	/**
	 * Get mdCoCtext
	 *
	 * @return the mdCoCtext
	 */
	public String getMdCoCtext() {
		return mdCoCtext;
	}

	/**
	 * set mdCoCtext
	 *
	 * @param mdCoCtext the mdCoCtext to set
	 */
	public void setMdCoCtext(final String mdCoCtext) {
		this.mdCoCtext = mdCoCtext;
	}

	/**
	 * Get mdCoCremark
	 *
	 * @return the mdCoCremark
	 */
	public String getMdCoCremark() {
		return mdCoCremark;
	}

	/**
	 * set mdCoCremark
	 *
	 * @param mdCoCremark the mdCoCremark to set
	 */
	public void setMdCoCremark(final String mdCoCremark) {
		this.mdCoCremark = mdCoCremark;
	}

	/**
	 * Get mdCoCplType
	 *
	 * @return the mdCoCplType
	 */
	public String getMdCoCplType() {
		return mdCoCplType;
	}

	/**
	 * set mdCoCplType
	 *
	 * @param mdCoCplType the mdCoCplType to set
	 */
	public void setMdCoCplType(final String mdCoCplType) {
		this.mdCoCplType = mdCoCplType;
	}

	/**
	 * Get mdCoCclass
	 *
	 * @return the mdCoCclass
	 */
	public String getMdCoCclass() {
		return mdCoCclass;
	}

	/**
	 * set mdCoCclass
	 *
	 * @param mdCoCclass the mdCoCclass to set
	 */
	public void setMdCoCclass(final String mdCoCclass) {
		this.mdCoCclass = mdCoCclass;
	}

	/**
	 * Get mdCoCmealControlCode
	 *
	 * @return the mdCoCmealControlCode
	 */
	public String getMdCoCmealControlCode() {
		return mdCoCmealControlCode;
	}

	/**
	 * set mdCoCmealControlCode
	 *
	 * @param mdCoCmealControlCode the mdCoCmealControlCode to set
	 */
	public void setMdCoCmealControlCode(final String mdCoCmealControlCode) {
		this.mdCoCmealControlCode = mdCoCmealControlCode;
	}

	/**
	 * Get mdCoNspml
	 *
	 * @return the mdCoNspml
	 */
	public Long getMdCoNspml() {
		return mdCoNspml;
	}

	/**
	 * set mdCoNspml
	 *
	 * @param mdCoNspml the mdCoNspml to set
	 */
	public void setMdCoNspml(final Long mdCoNspml) {
		this.mdCoNspml = mdCoNspml;
	}

	/**
	 * Get nstowageKey
	 *
	 * @return the nstowageKey
	 */
	public Long getNstowageKey() {
		return nstowageKey;
	}

	/**
	 * set nstowageKey
	 *
	 * @param nstowageKey the nstowageKey to set
	 */
	public void setNstowageKey(final Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

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
	 * Get napproved
	 *
	 * @return the napproved
	 */
	public Long getNapproved() {
		return napproved;
	}

	/**
	 * set napproved
	 *
	 * @param napproved the napproved to set
	 */
	public void setNapproved(final Long napproved) {
		this.napproved = napproved;
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
