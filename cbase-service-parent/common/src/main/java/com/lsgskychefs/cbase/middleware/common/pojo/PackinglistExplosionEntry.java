/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (packinglist-explosion-query.sql)
 *
 * @author Ingo Rietzschel - U125742
 */
public class PackinglistExplosionEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** The npackinglist index key. */
	private Long npackinglistIndexKey;
	/** The npackinglist detail key. */
	private Long npackinglistDetailKey;
	/** The cpackinglist. */
	private String cpackinglist;
	/** The nlevel. */
	private Integer nlevel;
	/** The npackinglist key. */
	private Long npackinglistKey;
	/** The clevel. */
	private String clevel;
	/** The ctype. */
	private String ctype;
	/** The nsort. */
	private int nsort;
	/** The nquantity. */
	private BigDecimal nquantity;
	/** The cunit. */
	private String cunit;
	/** The nquantity cal. */
	private BigDecimal nquantityCal;
	/** The nreckoning. */
	private Long nreckoning;
	/** The nworkstation key. */
	private Long nworkstationKey;
	/** The narea key. */
	private Long nareaKey;
	/** The ctext. */
	private String ctext;
	/** The ccustomer pl. */
	private String ccustomerPl;
	/** The ccustomer text. */
	private String ccustomerText;
	/** The nreserve. */
	private BigDecimal nreserve;
	/** The npercent. */
	private Integer npercent;
	/** The nancestor pl index key. */
	private Long nancestorPlIndexKey;
	/** The nancestor pl detail key. */
	private Long nancestorPlDetailKey;
	/** The nmaster index key. */
	private Long nmasterIndexKey;
	/** The npl kind key. */
	private Long nplKindKey;
	/** The npl type key. */
	private Long nplTypeKey;
	/** The nmaterial index key. */
	private Long nmaterialIndexKey;
	/** The npicture index key. */
	private Long npictureIndexKey;
	/** The ntext flag. */
	private Long ntextFlag;
	/** The cadd on text. */
	private String caddOnText;
	/** The ctext short. */
	private String ctextShort;
	/** The ctextPlProdLabel. */
	private String ctextPlProdLabel;

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
	 * Get ccustomerPl
	 *
	 * @return the ccustomerPl
	 */
	public String getCcustomerPl() {
		return ccustomerPl;
	}

	/**
	 * set ccustomerPl
	 *
	 * @param ccustomerPl the ccustomerPl to set
	 */
	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	/**
	 * Get ccustomerText
	 *
	 * @return the ccustomerText
	 */
	public String getCcustomerText() {
		return ccustomerText;
	}

	/**
	 * set ccustomerText
	 *
	 * @param ccustomerText the ccustomerText to set
	 */
	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	/**
	 * Get nreserve
	 *
	 * @return the nreserve
	 */
	public BigDecimal getNreserve() {
		return nreserve;
	}

	/**
	 * set nreserve
	 *
	 * @param nreserve the nreserve to set
	 */
	public void setNreserve(final BigDecimal nreserve) {
		this.nreserve = nreserve;
	}

	/**
	 * Get npercent
	 *
	 * @return the npercent
	 */
	public Integer getNpercent() {
		return npercent;
	}

	/**
	 * set npercent
	 *
	 * @param npercent the npercent to set
	 */
	public void setNpercent(final Integer npercent) {
		this.npercent = npercent;
	}

	/**
	 * Get nancestorPlIndexKey
	 *
	 * @return the nancestorPlIndexKey
	 */
	public Long getNancestorPlIndexKey() {
		return nancestorPlIndexKey;
	}

	/**
	 * set nancestorPlIndexKey
	 *
	 * @param nancestorPlIndexKey the nancestorPlIndexKey to set
	 */
	public void setNancestorPlIndexKey(final Long nancestorPlIndexKey) {
		this.nancestorPlIndexKey = nancestorPlIndexKey;
	}

	/**
	 * Get nancestorPlDetailKey
	 *
	 * @return the nancestorPlDetailKey
	 */
	public Long getNancestorPlDetailKey() {
		return nancestorPlDetailKey;
	}

	/**
	 * set nancestorPlDetailKey
	 *
	 * @param nancestorPlDetailKey the nancestorPlDetailKey to set
	 */
	public void setNancestorPlDetailKey(final Long nancestorPlDetailKey) {
		this.nancestorPlDetailKey = nancestorPlDetailKey;
	}

	/**
	 * Get nmasterIndexKey
	 *
	 * @return the nmasterIndexKey
	 */
	public Long getNmasterIndexKey() {
		return nmasterIndexKey;
	}

	/**
	 * set nmasterIndexKey
	 *
	 * @param nmasterIndexKey the nmasterIndexKey to set
	 */
	public void setNmasterIndexKey(final Long nmasterIndexKey) {
		this.nmasterIndexKey = nmasterIndexKey;
	}

	/**
	 * Get nplKindKey
	 *
	 * @return the nplKindKey
	 */
	public Long getNplKindKey() {
		return nplKindKey;
	}

	/**
	 * set nplKindKey
	 *
	 * @param nplKindKey the nplKindKey to set
	 */
	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	/**
	 * Get nplTypeKey
	 *
	 * @return the nplTypeKey
	 */
	public Long getNplTypeKey() {
		return nplTypeKey;
	}

	/**
	 * set nplTypeKey
	 *
	 * @param nplTypeKey the nplTypeKey to set
	 */
	public void setNplTypeKey(final Long nplTypeKey) {
		this.nplTypeKey = nplTypeKey;
	}

	/**
	 * Get nmaterialIndexKey
	 *
	 * @return the nmaterialIndexKey
	 */
	public Long getNmaterialIndexKey() {
		return nmaterialIndexKey;
	}

	/**
	 * set nmaterialIndexKey
	 *
	 * @param nmaterialIndexKey the nmaterialIndexKey to set
	 */
	public void setNmaterialIndexKey(final Long nmaterialIndexKey) {
		this.nmaterialIndexKey = nmaterialIndexKey;
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
	 * Get ntextFlag
	 *
	 * @return the ntextFlag
	 */
	public Long getNtextFlag() {
		return ntextFlag;
	}

	/**
	 * set ntextFlag
	 *
	 * @param ntextFlag the ntextFlag to set
	 */
	public void setNtextFlag(final Long ntextFlag) {
		this.ntextFlag = ntextFlag;
	}

	/**
	 * Get caddOnText
	 *
	 * @return the caddOnText
	 */
	public String getCaddOnText() {
		return caddOnText;
	}

	/**
	 * set caddOnText
	 *
	 * @param caddOnText the caddOnText to set
	 */
	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
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

	/**
	 * @return the ctextPlProdLabel
	 */
	public String getCtextPlProdLabel() {
		return ctextPlProdLabel;
	}

	/**
	 * @param ctextPlProdLabel the ctextPlProdLabel to set
	 */
	public void setCtextPlProdLabel(final String ctextPlProdLabel) {
		this.ctextPlProdLabel = ctextPlProdLabel;
	}

}
