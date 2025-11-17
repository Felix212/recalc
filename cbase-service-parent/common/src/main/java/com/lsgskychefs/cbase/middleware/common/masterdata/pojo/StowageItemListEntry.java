/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * The Class StowageItemListEntry contains the values for native query 'stowage-itemlist-query.sql'.
 *
 * @author Ingo Rietzschel - U125742
 */
public class StowageItemListEntry extends AbstractPojo implements CbaseMiddlewareEntry {

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
	/** cplInStowage */
	private String cplInStowage;
	/** pointer to top of current (meal-component)tree. (packinglistMealHeader) */
	private String cplMealHeader;
	/** ctextStowage */
	private String ctextStowage;
	/** nquantity */
	private BigDecimal nquantity;
	/** nquantityAct - actual CBASE quantity (already summed) for a cpakcinglist on a flight */
	private BigDecimal nquantityAct;
	/** cpackinglist */
	private String cpackinglist;
	/** ctextContent */
	private String ctextContent;
	/** nlevel */
	private Integer nlevel;
	/** ctype */
	private String ctype;
	/** npackinglistKey */
	private Long npackinglistKey;
	/** clevel */
	private String clevel;
	/** ctype */
	private String cpackinglistType;
	/** cclass */
	private String cclass;
	/** nclassNumber */
	private Integer nclassNumber;

	/**
	 * Get ngalleyKey
	 *
	 * @return the ngalleyKey
	 */
	public Integer getNgalleyKey() {
		return ngalleyKey;
	}

	/**
	 * set ngalleyKey
	 *
	 * @param ngalleyKey the ngalleyKey to set
	 */
	public void setNgalleyKey(final Integer ngalleyKey) {
		this.ngalleyKey = ngalleyKey;
	}

	/**
	 * Get nstowageKey
	 *
	 * @return the nstowageKey
	 */
	public Integer getNstowageKey() {
		return nstowageKey;
	}

	/**
	 * set nstowageKey
	 *
	 * @param nstowageKey the nstowageKey to set
	 */
	public void setNstowageKey(final Integer nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

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
	 * Get cplInStowage
	 *
	 * @return the cplInStowage
	 */
	public String getCplInStowage() {
		return cplInStowage;
	}

	/**
	 * set cplInStowage
	 *
	 * @param cplInStowage the cplInStowage to set
	 */
	public void setCplInStowage(final String cplInStowage) {
		this.cplInStowage = cplInStowage;
	}

	/**
	 * Get ctextStowage
	 *
	 * @return the ctextStowage
	 */
	public String getCtextStowage() {
		return ctextStowage;
	}

	/**
	 * set ctextStowage
	 *
	 * @param ctextStowage the ctextStowage to set
	 */
	public void setCtextStowage(final String ctextStowage) {
		this.ctextStowage = ctextStowage;
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
	 * Get nquantityAct
	 *
	 * @return the nquantityAct
	 */
	public BigDecimal getNquantityAct() {
		return nquantityAct;
	}

	/**
	 * Set nquantityAct
	 * 
	 * @param nquantityAct the nquantityAct to set
	 */
	public void setNquantityAct(final BigDecimal nquantityAct) {
		this.nquantityAct = nquantityAct;
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
	 * Get ctextContent
	 *
	 * @return the ctextContent
	 */
	public String getCtextContent() {
		return ctextContent;
	}

	/**
	 * set ctextContent
	 *
	 * @param ctextContent the ctextContent to set
	 */
	public void setCtextContent(final String ctextContent) {
		this.ctextContent = ctextContent;
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
	 * Get cpackinglistType
	 *
	 * @return the cpackinglistType
	 */
	public String getCpackinglistType() {
		return cpackinglistType;
	}

	/**
	 * set cpackinglistType
	 *
	 * @param cpackinglistType the cpackinglistType to set
	 */
	public void setCpackinglistType(final String cpackinglistType) {
		this.cpackinglistType = cpackinglistType;
	}

	/**
	 * Get cplMealHeader
	 *
	 * @return the cplMealHeader
	 */
	public String getCplMealHeader() {
		return cplMealHeader;
	}

	/**
	 * set cplMealHeader
	 *
	 * @param cplMealHeader the cplMealHeader to set
	 */
	public void setCplMealHeader(final String cplMealHeader) {
		this.cplMealHeader = cplMealHeader;
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
	 * Get nclassNumber
	 *
	 * @return the nclassNumber
	 */
	public Integer getNclassNumber() {
		return nclassNumber;
	}

	/**
	 * set nclassNumber
	 *
	 * @param nclassNumber the nclassNumber to set
	 */
	public void setNclassNumber(final Integer nclassNumber) {
		this.nclassNumber = nclassNumber;
	}
}
