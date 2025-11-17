/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;
import java.util.Date;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query flight-meals-query.sql.
 *
 * @author Ingo Rietzschel - U125742
 */
public class FlightMealsGroupedEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** ntransaction */
	private long ntransaction;

	/** nresultKey */
	private long nresultKey;

	/** ncoverKey */
	private long ncoverKey;

	/** ccoverText */
	private String ccoverText;

	/** nclassNumber */
	private long nclassNumber;

	/** cclass */
	private String cclass;

	/** nreserveQuantity */
	private int nreserveQuantity;

	/** nreserveType */
	private int nreserveType;

	/** ntopoffQuantity */
	private int ntopoffQuantity;

	/** ntopoffType */
	private int ntopoffType;

	/** nmoduleType */
	private int nmoduleType;

	/** npackinglistIndexKey */
	private long npackinglistIndexKey;

	/** cpackinglist */
	private String cpackinglist;

	/** cunit */
	private String cunit;

	/** cproductionText */
	private String cproductionText;

	/** nquantityGroup */
	private Integer nquantityGroup;

	/** cremark */
	private String cremark;

	/** npax */
	private int npax;

	/** npaxManual */
	private int npaxManual;

	/** nquantity */
	private BigDecimal nquantity;

	/** nquantityOld */
	private BigDecimal nquantityOld;

	/** nmanualInput */
	private int nmanualInput;

	/** nmanualProcessing */
	private int nmanualProcessing;

	/** dtimestamp */
	private Date dtimestamp;

	/** nstatus */
	private int nstatus;

	/** cdescription */
	private String cdescription;

	/** nquantity1 */
	private BigDecimal nquantity1;

	/** nquantity2 */
	private BigDecimal nquantity2;

	/** nquantity3 */
	private BigDecimal nquantity3;

	/** nquantity4 */
	private BigDecimal nquantity4;

	/** nquantity5 */
	private BigDecimal nquantity5;

	/** nquantity6 */
	private BigDecimal nquantity6;

	/** nquantity7 */
	private BigDecimal nquantity7;

	/** nspmlQuantity */
	private int nspmlQuantity;

	/** npltypeKey */
	private Long npltypeKey;

	/** nplKindKey */
	private Long nplKindKey;

	/** npackinglistKey */
	private Long npackinglistKey;

	/** npackinglistDetailKey */
	private Long npackinglistDetailKey;

	/** ctext */
	private String ctext;

	/** ccustomerPl */
	private String ccustomerPl;

	/** ccustomerText */
	private String ccustomerText;

	/** npictureIndexKey */
	private Long npictureIndexKey;

	/** ctextShort */
	private String ctextShort;

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
	 * Get ncoverKey
	 *
	 * @return the ncoverKey
	 */
	public long getNcoverKey() {
		return ncoverKey;
	}

	/**
	 * set ncoverKey
	 *
	 * @param ncoverKey the ncoverKey to set
	 */
	public void setNcoverKey(final long ncoverKey) {
		this.ncoverKey = ncoverKey;
	}

	/**
	 * Get ccoverText
	 *
	 * @return the ccoverText
	 */
	public String getCcoverText() {
		return ccoverText;
	}

	/**
	 * set ccoverText
	 *
	 * @param ccoverText the ccoverText to set
	 */
	public void setCcoverText(final String ccoverText) {
		this.ccoverText = ccoverText;
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
	 * Get nreserveQuantity
	 *
	 * @return the nreserveQuantity
	 */
	public int getNreserveQuantity() {
		return nreserveQuantity;
	}

	/**
	 * set nreserveQuantity
	 *
	 * @param nreserveQuantity the nreserveQuantity to set
	 */
	public void setNreserveQuantity(final int nreserveQuantity) {
		this.nreserveQuantity = nreserveQuantity;
	}

	/**
	 * Get nreserveType
	 *
	 * @return the nreserveType
	 */
	public int getNreserveType() {
		return nreserveType;
	}

	/**
	 * set nreserveType
	 *
	 * @param nreserveType the nreserveType to set
	 */
	public void setNreserveType(final int nreserveType) {
		this.nreserveType = nreserveType;
	}

	/**
	 * Get ntopoffQuantity
	 *
	 * @return the ntopoffQuantity
	 */
	public int getNtopoffQuantity() {
		return ntopoffQuantity;
	}

	/**
	 * set ntopoffQuantity
	 *
	 * @param ntopoffQuantity the ntopoffQuantity to set
	 */
	public void setNtopoffQuantity(final int ntopoffQuantity) {
		this.ntopoffQuantity = ntopoffQuantity;
	}

	/**
	 * Get ntopoffType
	 *
	 * @return the ntopoffType
	 */
	public int getNtopoffType() {
		return ntopoffType;
	}

	/**
	 * set ntopoffType
	 *
	 * @param ntopoffType the ntopoffType to set
	 */
	public void setNtopoffType(final int ntopoffType) {
		this.ntopoffType = ntopoffType;
	}

	/**
	 * Get nmoduleType
	 *
	 * @return the nmoduleType
	 */
	public int getNmoduleType() {
		return nmoduleType;
	}

	/**
	 * set nmoduleType
	 *
	 * @param nmoduleType the nmoduleType to set
	 */
	public void setNmoduleType(final int nmoduleType) {
		this.nmoduleType = nmoduleType;
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
	 * Get nquantityGroup
	 *
	 * @return the nquantityGroup
	 */
	public Integer getNquantityGroup() {
		return nquantityGroup;
	}

	/**
	 * set nquantityGroup
	 *
	 * @param nquantityGroup the nquantityGroup to set
	 */
	public void setNquantityGroup(final Integer nquantityGroup) {
		this.nquantityGroup = nquantityGroup;
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
	 * Get npax
	 *
	 * @return the npax
	 */
	public int getNpax() {
		return npax;
	}

	/**
	 * set npax
	 *
	 * @param npax the npax to set
	 */
	public void setNpax(final int npax) {
		this.npax = npax;
	}

	/**
	 * Get npaxManual
	 *
	 * @return the npaxManual
	 */
	public int getNpaxManual() {
		return npaxManual;
	}

	/**
	 * set npaxManual
	 *
	 * @param npaxManual the npaxManual to set
	 */
	public void setNpaxManual(final int npaxManual) {
		this.npaxManual = npaxManual;
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
	 * Get nmanualProcessing
	 *
	 * @return the nmanualProcessing
	 */
	public int getNmanualProcessing() {
		return nmanualProcessing;
	}

	/**
	 * set nmanualProcessing
	 *
	 * @param nmanualProcessing the nmanualProcessing to set
	 */
	public void setNmanualProcessing(final int nmanualProcessing) {
		this.nmanualProcessing = nmanualProcessing;
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
	public int getNstatus() {
		return nstatus;
	}

	/**
	 * set nstatus
	 *
	 * @param nstatus the nstatus to set
	 */
	public void setNstatus(final int nstatus) {
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
	 * Get nquantity1
	 *
	 * @return the nquantity1
	 */
	public BigDecimal getNquantity1() {
		return nquantity1;
	}

	/**
	 * set nquantity1
	 *
	 * @param nquantity1 the nquantity1 to set
	 */
	public void setNquantity1(final BigDecimal nquantity1) {
		this.nquantity1 = nquantity1;
	}

	/**
	 * Get nquantity2
	 *
	 * @return the nquantity2
	 */
	public BigDecimal getNquantity2() {
		return nquantity2;
	}

	/**
	 * set nquantity2
	 *
	 * @param nquantity2 the nquantity2 to set
	 */
	public void setNquantity2(final BigDecimal nquantity2) {
		this.nquantity2 = nquantity2;
	}

	/**
	 * Get nquantity3
	 *
	 * @return the nquantity3
	 */
	public BigDecimal getNquantity3() {
		return nquantity3;
	}

	/**
	 * set nquantity3
	 *
	 * @param nquantity3 the nquantity3 to set
	 */
	public void setNquantity3(final BigDecimal nquantity3) {
		this.nquantity3 = nquantity3;
	}

	/**
	 * Get nquantity4
	 *
	 * @return the nquantity4
	 */
	public BigDecimal getNquantity4() {
		return nquantity4;
	}

	/**
	 * set nquantity4
	 *
	 * @param nquantity4 the nquantity4 to set
	 */
	public void setNquantity4(final BigDecimal nquantity4) {
		this.nquantity4 = nquantity4;
	}

	/**
	 * Get nquantity5
	 *
	 * @return the nquantity5
	 */
	public BigDecimal getNquantity5() {
		return nquantity5;
	}

	/**
	 * set nquantity5
	 *
	 * @param nquantity5 the nquantity5 to set
	 */
	public void setNquantity5(final BigDecimal nquantity5) {
		this.nquantity5 = nquantity5;
	}

	/**
	 * Get nquantity6
	 *
	 * @return the nquantity6
	 */
	public BigDecimal getNquantity6() {
		return nquantity6;
	}

	/**
	 * set nquantity6
	 *
	 * @param nquantity6 the nquantity6 to set
	 */
	public void setNquantity6(final BigDecimal nquantity6) {
		this.nquantity6 = nquantity6;
	}

	/**
	 * Get nquantity7
	 *
	 * @return the nquantity7
	 */
	public BigDecimal getNquantity7() {
		return nquantity7;
	}

	/**
	 * Set nquantity7
	 * 
	 * @param nquantity7 the nquantity7 to set
	 */
	public void setNquantity7(final BigDecimal nquantity7) {
		this.nquantity7 = nquantity7;
	}

	/**
	 * Get nspmlQuantity
	 *
	 * @return the nspmlQuantity
	 */
	public int getNspmlQuantity() {
		return nspmlQuantity;
	}

	/**
	 * Set nspmlQuantity
	 * 
	 * @param nspmlQuantity the nspmlQuantity to set
	 */
	public void setNspmlQuantity(final int nspmlQuantity) {
		this.nspmlQuantity = nspmlQuantity;
	}

	/**
	 * Get npltypeKey
	 *
	 * @return the npltypeKey
	 */
	public Long getNpltypeKey() {
		return npltypeKey;
	}

	/**
	 * Set npltypeKey
	 * 
	 * @param npltypeKey the npltypeKey to set
	 */
	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
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
	 * Set nplKindKey
	 * 
	 * @param nplKindKey the nplKindKey to set
	 */
	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
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
	 * Set npackinglistKey
	 * 
	 * @param npackinglistKey the npackinglistKey to set
	 */
	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
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
	 * Set npackinglistDetailKey
	 * 
	 * @param npackinglistDetailKey the npackinglistDetailKey to set
	 */
	public void setNpackinglistDetailKey(final Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
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
	 * Set ctext
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
	 * Set ccustomerPl
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
	 * Set ccustomerText
	 * 
	 * @param ccustomerText the ccustomerText to set
	 */
	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
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
	 * Set npictureIndexKey
	 * 
	 * @param npictureIndexKey the npictureIndexKey to set
	 */
	public void setNpictureIndexKey(final Long npictureIndexKey) {
		this.npictureIndexKey = npictureIndexKey;
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
	 * Set ctextShort
	 * 
	 * @param ctextShort the ctextShort to set
	 */
	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

}
