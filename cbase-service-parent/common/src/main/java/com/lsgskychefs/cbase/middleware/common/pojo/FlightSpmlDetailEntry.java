/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;
import java.util.Date;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpml;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutSpmlDetail;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglistPictures;
import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (flight-spml-details-query.sql) {@link CenOutSpml} {@link CenOutSpmlDetail}
 * {@link CenPackinglistPictures} .
 *
 * @author Ingo Rietzschel - U125742
 */
public class FlightSpmlDetailEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** nmasterKey */
	private long nmasterKey;

	/** ntransaction */
	private long ntransaction;

	/** nresultKey */
	private long nresultKey;

	/** nclassNumber */
	private long nclassNumber;

	/** cclass */
	private String cclass;

	/** nprio */
	private int nprio;

	/** nspmlKey */
	private long nspmlKey;

	/** cspml */
	private String cspml;

	/** cname */
	private String cname;

	/** caddText */
	private String caddText;

	/** cremark */
	private String cremark;

	/** nquantity */
	private BigDecimal nquantity;

	/** nquantityOld */
	private BigDecimal nquantityOld;

	/** nmanualInput */
	private int nmanualInput;

	/** ndeduction */
	private int ndeduction;

	/** dtimestamp */
	private Date dtimestamp;

	/** nstatus */
	private long nstatus;

	/** cdescription */
	private String cdescription;

	/** ntopoff */
	private Integer ntopoff;

	/** nstationentry */
	private Integer nstationentry;

	/** cseat */
	private String cseat;

	/** cpackinglist */
	private String cpackinglist;

	/** cmealControlCode */
	private String cmealControlCode;

	/** cproductionText */
	private String cproductionText;

	/** ctext */
	private String ctext;

	/** detailNquantity */
	private BigDecimal detailNquantity;

	/** npictureIndexKey */
	private Long npictureIndexKey;

	/** npackinglistIndexKey */
	private Long npackinglistIndexKey;

	/** npackinglistDetailKey */
	private Long npackinglistDetailKey;

	/**
	 * Get nmasterKey
	 *
	 * @return the nmasterKey
	 */
	public long getNmasterKey() {
		return nmasterKey;
	}

	/**
	 * set nmasterKey
	 *
	 * @param nmasterKey the nmasterKey to set
	 */
	public void setNmasterKey(final long nmasterKey) {
		this.nmasterKey = nmasterKey;
	}

	/**
	 * Get ntransaction
	 *
	 * @return the ntransaction
	 */
	public long getNtransaction() {
		return ntransaction;
	}

	/**
	 * set ntransaction
	 *
	 * @param ntransaction the ntransaction to set
	 */
	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	/**
	 * Get nresultKey
	 *
	 * @return the nresultKey
	 */
	public long getNresultKey() {
		return nresultKey;
	}

	/**
	 * set nresultKey
	 *
	 * @param nresultKey the nresultKey to set
	 */
	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	/**
	 * Get nclassNumber
	 *
	 * @return the nclassNumber
	 */
	public long getNclassNumber() {
		return nclassNumber;
	}

	/**
	 * set nclassNumber
	 *
	 * @param nclassNumber the nclassNumber to set
	 */
	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
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
	 * Get nprio
	 *
	 * @return the nprio
	 */
	public int getNprio() {
		return nprio;
	}

	/**
	 * set nprio
	 *
	 * @param nprio the nprio to set
	 */
	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	/**
	 * Get nspmlKey
	 *
	 * @return the nspmlKey
	 */
	public long getNspmlKey() {
		return nspmlKey;
	}

	/**
	 * set nspmlKey
	 *
	 * @param nspmlKey the nspmlKey to set
	 */
	public void setNspmlKey(final long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	/**
	 * Get cspml
	 *
	 * @return the cspml
	 */
	public String getCspml() {
		return cspml;
	}

	/**
	 * set cspml
	 *
	 * @param cspml the cspml to set
	 */
	public void setCspml(final String cspml) {
		this.cspml = cspml;
	}

	/**
	 * Get cname
	 *
	 * @return the cname
	 */
	public String getCname() {
		return cname;
	}

	/**
	 * set cname
	 *
	 * @param cname the cname to set
	 */
	public void setCname(final String cname) {
		this.cname = cname;
	}

	/**
	 * Get caddText
	 *
	 * @return the caddText
	 */
	public String getCaddText() {
		return caddText;
	}

	/**
	 * set caddText
	 *
	 * @param caddText the caddText to set
	 */
	public void setCaddText(final String caddText) {
		this.caddText = caddText;
	}

	/**
	 * Get cremark
	 *
	 * @return the cremark
	 */
	public String getCremark() {
		return cremark;
	}

	/**
	 * set cremark
	 *
	 * @param cremark the cremark to set
	 */
	public void setCremark(final String cremark) {
		this.cremark = cremark;
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
	 * Get nquantityOld
	 *
	 * @return the nquantityOld
	 */
	public BigDecimal getNquantityOld() {
		return nquantityOld;
	}

	/**
	 * set nquantityOld
	 *
	 * @param nquantityOld the nquantityOld to set
	 */
	public void setNquantityOld(final BigDecimal nquantityOld) {
		this.nquantityOld = nquantityOld;
	}

	/**
	 * Get nmanualInput
	 *
	 * @return the nmanualInput
	 */
	public int getNmanualInput() {
		return nmanualInput;
	}

	/**
	 * set nmanualInput
	 *
	 * @param nmanualInput the nmanualInput to set
	 */
	public void setNmanualInput(final int nmanualInput) {
		this.nmanualInput = nmanualInput;
	}

	/**
	 * Get ndeduction
	 *
	 * @return the ndeduction
	 */
	public int getNdeduction() {
		return ndeduction;
	}

	/**
	 * set ndeduction
	 *
	 * @param ndeduction the ndeduction to set
	 */
	public void setNdeduction(final int ndeduction) {
		this.ndeduction = ndeduction;
	}

	/**
	 * Get dtimestamp
	 *
	 * @return the dtimestamp
	 */
	public Date getDtimestamp() {
		return dtimestamp;
	}

	/**
	 * set dtimestamp
	 *
	 * @param dtimestamp the dtimestamp to set
	 */
	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	/**
	 * Get nstatus
	 *
	 * @return the nstatus
	 */
	public long getNstatus() {
		return nstatus;
	}

	/**
	 * set nstatus
	 *
	 * @param nstatus the nstatus to set
	 */
	public void setNstatus(final long nstatus) {
		this.nstatus = nstatus;
	}

	/**
	 * Get cdescription
	 *
	 * @return the cdescription
	 */
	public String getCdescription() {
		return cdescription;
	}

	/**
	 * set cdescription
	 *
	 * @param cdescription the cdescription to set
	 */
	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	/**
	 * Get ntopoff
	 *
	 * @return the ntopoff
	 */
	public Integer getNtopoff() {
		return ntopoff;
	}

	/**
	 * set ntopoff
	 *
	 * @param ntopoff the ntopoff to set
	 */
	public void setNtopoff(final Integer ntopoff) {
		this.ntopoff = ntopoff;
	}

	/**
	 * Get nstationentry
	 *
	 * @return the nstationentry
	 */
	public Integer getNstationentry() {
		return nstationentry;
	}

	/**
	 * set nstationentry
	 *
	 * @param nstationentry the nstationentry to set
	 */
	public void setNstationentry(final Integer nstationentry) {
		this.nstationentry = nstationentry;
	}

	/**
	 * Get cseat
	 *
	 * @return the cseat
	 */
	public String getCseat() {
		return cseat;
	}

	/**
	 * set cseat
	 *
	 * @param cseat the cseat to set
	 */
	public void setCseat(final String cseat) {
		this.cseat = cseat;
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
	 * Get cproductionText
	 *
	 * @return the cproductionText
	 */
	public String getCproductionText() {
		return cproductionText;
	}

	/**
	 * set cproductionText
	 *
	 * @param cproductionText the cproductionText to set
	 */
	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
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
	 * Get detailNquantity
	 *
	 * @return the detailNquantity
	 */
	public BigDecimal getDetailNquantity() {
		return detailNquantity;
	}

	/**
	 * set detailNquantity
	 *
	 * @param detailNquantity the detailNquantity to set
	 */
	public void setDetailNquantity(final BigDecimal detailNquantity) {
		this.detailNquantity = detailNquantity;
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

}
