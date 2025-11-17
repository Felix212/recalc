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
public class FlightMealsEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** ndetailKey */
	/** ndetailKey */
	private long ndetailKey;

	/** ntransaction */
	private long ntransaction;

	/** nresultKey */
	private long nresultKey;

	/** nhandlingKey */
	private long nhandlingKey;

	/** nhandlingDetailKey */
	private long nhandlingDetailKey;

	/** chandlingText */
	private String chandlingText;

	/** ncoverKey */
	private long ncoverKey;

	/** ccoverText */
	private String ccoverText;

	/** ncoverPrio */
	private int ncoverPrio;

	/** nhandlingMealKey */
	private long nhandlingMealKey;

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

	/** nrotationKey */
	private long nrotationKey;

	/** nrotationNameKey */
	private long nrotationNameKey;

	/** crotation */
	private String crotation;

	/** nmoduleType */
	private int nmoduleType;

	/** nprio */
	private int nprio;

	/** npackinglistIndexKey */
	private long npackinglistIndexKey;

	/** cpackinglist */
	private String cpackinglist;

	/** cunit */
	private String cunit;

	/** cmealControlCode */
	private String cmealControlCode;

	/** cproductionText */
	private String cproductionText;

	/** ncomponentGroup */
	private int ncomponentGroup;

	/** nforeignObject */
	private Long nforeignObject;

	/** nforeignGroup */
	private Integer nforeignGroup;

	/** nask4passenger */
	private int nask4passenger;

	/** cquestionText */
	private String cquestionText;

	/** npassengerGroup */
	private int npassengerGroup;

	/** nquantityGroup */
	private Integer nquantityGroup;

	/** cremark */
	private String cremark;

	/** naccountKey */
	private Long naccountKey;

	/** caccount */
	private String caccount;

	/** nbillingStatus */
	private int nbillingStatus;

	/** ncalcId */
	private long ncalcId;

	/** ncalcDetailKey */
	private Long ncalcDetailKey;

	/** npercentage */
	private int npercentage;

	/** nvalue */
	private BigDecimal nvalue;

	/** nspmlDeduction */
	private int nspmlDeduction;

	/** nacTransfer */
	private int nacTransfer;

	/** npax */
	private int npax;

	/** npaxManual */
	private int npaxManual;

	/** ncalcBasis */
	private int ncalcBasis;

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

	/** careaHost */
	private String careaHost;

	/** ceffortHost */
	private String ceffortHost;

	/** cadditionalAccount */
	private String cadditionalAccount;

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

	/** ndistribute */
	private Integer ndistribute;

	/** npostingType */
	private Integer npostingType;

	/** nsalesPrice */
	private BigDecimal nsalesPrice;

	/** ndeliveryNote */
	private Integer ndeliveryNote;

	/** cdeliverySnr */
	private String cdeliverySnr;

	/** cdeliveryText */
	private String cdeliveryText;

	/** ncontrolling */
	private Integer ncontrolling;

	/** nsysaccountKey */
	private Long nsysaccountKey;

	/** ccode */
	private String ccode;

	/** nremittanceprice */
	private BigDecimal nremittanceprice;

	/** ndiscount */
	private BigDecimal ndiscount;

	/** nportfee */
	private BigDecimal nportfee;

	/** nvatValue */
	private BigDecimal nvatValue;

	/** ninvoiceCycleKey */
	private Long ninvoiceCycleKey;

	/** ncostPrice */
	private BigDecimal ncostPrice;

	/** ninvoiceStatus */
	private Integer ninvoiceStatus;

	/** cclasses */
	private String cclasses;

	/** nsalesPriceModified */
	private Integer nsalesPriceModified;

	/** npriceCalcType */
	private Long npriceCalcType;

	/** ncosttype */
	private Long ncosttype;

	/** ctaxcode */
	private String ctaxcode;

	/** nbillingPrice */
	private BigDecimal nbillingPrice;

	/** nreleaseExclusion */
	private Integer nreleaseExclusion;

	/** nstationentry */
	private Integer nstationentry;

	/** ccustomerPl */
	private String ccustomerPl;

	/** ccustomerText */
	private String ccustomerText;

	/** nquantityRecalc */
	private BigDecimal nquantityRecalc;

	/** nsalesPriceRecalc */
	private BigDecimal nsalesPriceRecalc;

	/** nbillingPriceRecalc */
	private BigDecimal nbillingPriceRecalc;

	/** ncostPriceRecalc */
	private BigDecimal ncostPriceRecalc;

	/** nremittencepriceRecalc */
	private BigDecimal nremittencepriceRecalc;

	/** nvatValueRecalc */
	private BigDecimal nvatValueRecalc;

	/** ndiscountRecalc */
	private BigDecimal ndiscountRecalc;

	/** nportfeeRecalc */
	private BigDecimal nportfeeRecalc;

	/** ncalcBasisRecalc */
	private Integer ncalcBasisRecalc;

	/** nimportFromBob */
	private Integer nimportFromBob;

	/** nvatValuePortfee */
	private BigDecimal nvatValuePortfee;

	/** nvatKey */
	private Long nvatKey;

	/** nvatKeyPortfee */
	private Long nvatKeyPortfee;

	/** npictureIndexKey */
	private Long npictureIndexKey;

	/** ctextShort */
	private String ctextShort;

	/**
	 * Get ndetailKey
	 *
	 * @return the ndetailKey
	 */
	public long getNdetailKey() {
		return ndetailKey;
	}

	/**
	 * set ndetailKey
	 *
	 * @param ndetailKey the ndetailKey to set
	 */
	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
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
	 * Get nhandlingKey
	 *
	 * @return the nhandlingKey
	 */
	public long getNhandlingKey() {
		return nhandlingKey;
	}

	/**
	 * set nhandlingKey
	 *
	 * @param nhandlingKey the nhandlingKey to set
	 */
	public void setNhandlingKey(final long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	/**
	 * Get nhandlingDetailKey
	 *
	 * @return the nhandlingDetailKey
	 */
	public long getNhandlingDetailKey() {
		return nhandlingDetailKey;
	}

	/**
	 * set nhandlingDetailKey
	 *
	 * @param nhandlingDetailKey the nhandlingDetailKey to set
	 */
	public void setNhandlingDetailKey(final long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	/**
	 * Get chandlingText
	 *
	 * @return the chandlingText
	 */
	public String getChandlingText() {
		return chandlingText;
	}

	/**
	 * set chandlingText
	 *
	 * @param chandlingText the chandlingText to set
	 */
	public void setChandlingText(final String chandlingText) {
		this.chandlingText = chandlingText;
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
	 * Get ncoverPrio
	 *
	 * @return the ncoverPrio
	 */
	public int getNcoverPrio() {
		return ncoverPrio;
	}

	/**
	 * set ncoverPrio
	 *
	 * @param ncoverPrio the ncoverPrio to set
	 */
	public void setNcoverPrio(final int ncoverPrio) {
		this.ncoverPrio = ncoverPrio;
	}

	/**
	 * Get nhandlingMealKey
	 *
	 * @return the nhandlingMealKey
	 */
	public long getNhandlingMealKey() {
		return nhandlingMealKey;
	}

	/**
	 * set nhandlingMealKey
	 *
	 * @param nhandlingMealKey the nhandlingMealKey to set
	 */
	public void setNhandlingMealKey(final long nhandlingMealKey) {
		this.nhandlingMealKey = nhandlingMealKey;
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
	 * Get nrotationKey
	 *
	 * @return the nrotationKey
	 */
	public long getNrotationKey() {
		return nrotationKey;
	}

	/**
	 * set nrotationKey
	 *
	 * @param nrotationKey the nrotationKey to set
	 */
	public void setNrotationKey(final long nrotationKey) {
		this.nrotationKey = nrotationKey;
	}

	/**
	 * Get nrotationNameKey
	 *
	 * @return the nrotationNameKey
	 */
	public long getNrotationNameKey() {
		return nrotationNameKey;
	}

	/**
	 * set nrotationNameKey
	 *
	 * @param nrotationNameKey the nrotationNameKey to set
	 */
	public void setNrotationNameKey(final long nrotationNameKey) {
		this.nrotationNameKey = nrotationNameKey;
	}

	/**
	 * Get crotation
	 *
	 * @return the crotation
	 */
	public String getCrotation() {
		return crotation;
	}

	/**
	 * set crotation
	 *
	 * @param crotation the crotation to set
	 */
	public void setCrotation(final String crotation) {
		this.crotation = crotation;
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
	 * Get ncomponentGroup
	 *
	 * @return the ncomponentGroup
	 */
	public int getNcomponentGroup() {
		return ncomponentGroup;
	}

	/**
	 * set ncomponentGroup
	 *
	 * @param ncomponentGroup the ncomponentGroup to set
	 */
	public void setNcomponentGroup(final int ncomponentGroup) {
		this.ncomponentGroup = ncomponentGroup;
	}

	/**
	 * Get nforeignObject
	 *
	 * @return the nforeignObject
	 */
	public Long getNforeignObject() {
		return nforeignObject;
	}

	/**
	 * set nforeignObject
	 *
	 * @param nforeignObject the nforeignObject to set
	 */
	public void setNforeignObject(final Long nforeignObject) {
		this.nforeignObject = nforeignObject;
	}

	/**
	 * Get nforeignGroup
	 *
	 * @return the nforeignGroup
	 */
	public Integer getNforeignGroup() {
		return nforeignGroup;
	}

	/**
	 * set nforeignGroup
	 *
	 * @param nforeignGroup the nforeignGroup to set
	 */
	public void setNforeignGroup(final Integer nforeignGroup) {
		this.nforeignGroup = nforeignGroup;
	}

	/**
	 * Get nask4passenger
	 *
	 * @return the nask4passenger
	 */
	public int getNask4passenger() {
		return nask4passenger;
	}

	/**
	 * set nask4passenger
	 *
	 * @param nask4passenger the nask4passenger to set
	 */
	public void setNask4passenger(final int nask4passenger) {
		this.nask4passenger = nask4passenger;
	}

	/**
	 * Get cquestionText
	 *
	 * @return the cquestionText
	 */
	public String getCquestionText() {
		return cquestionText;
	}

	/**
	 * set cquestionText
	 *
	 * @param cquestionText the cquestionText to set
	 */
	public void setCquestionText(final String cquestionText) {
		this.cquestionText = cquestionText;
	}

	/**
	 * Get npassengerGroup
	 *
	 * @return the npassengerGroup
	 */
	public int getNpassengerGroup() {
		return npassengerGroup;
	}

	/**
	 * set npassengerGroup
	 *
	 * @param npassengerGroup the npassengerGroup to set
	 */
	public void setNpassengerGroup(final int npassengerGroup) {
		this.npassengerGroup = npassengerGroup;
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
	 * Get naccountKey
	 *
	 * @return the naccountKey
	 */
	public Long getNaccountKey() {
		return naccountKey;
	}

	/**
	 * set naccountKey
	 *
	 * @param naccountKey the naccountKey to set
	 */
	public void setNaccountKey(final Long naccountKey) {
		this.naccountKey = naccountKey;
	}

	/**
	 * Get caccount
	 *
	 * @return the caccount
	 */
	public String getCaccount() {
		return caccount;
	}

	/**
	 * set caccount
	 *
	 * @param caccount the caccount to set
	 */
	public void setCaccount(final String caccount) {
		this.caccount = caccount;
	}

	/**
	 * Get nbillingStatus
	 *
	 * @return the nbillingStatus
	 */
	public int getNbillingStatus() {
		return nbillingStatus;
	}

	/**
	 * set nbillingStatus
	 *
	 * @param nbillingStatus the nbillingStatus to set
	 */
	public void setNbillingStatus(final int nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	/**
	 * Get ncalcId
	 *
	 * @return the ncalcId
	 */
	public long getNcalcId() {
		return ncalcId;
	}

	/**
	 * set ncalcId
	 *
	 * @param ncalcId the ncalcId to set
	 */
	public void setNcalcId(final long ncalcId) {
		this.ncalcId = ncalcId;
	}

	/**
	 * Get ncalcDetailKey
	 *
	 * @return the ncalcDetailKey
	 */
	public Long getNcalcDetailKey() {
		return ncalcDetailKey;
	}

	/**
	 * set ncalcDetailKey
	 *
	 * @param ncalcDetailKey the ncalcDetailKey to set
	 */
	public void setNcalcDetailKey(final Long ncalcDetailKey) {
		this.ncalcDetailKey = ncalcDetailKey;
	}

	/**
	 * Get npercentage
	 *
	 * @return the npercentage
	 */
	public int getNpercentage() {
		return npercentage;
	}

	/**
	 * set npercentage
	 *
	 * @param npercentage the npercentage to set
	 */
	public void setNpercentage(final int npercentage) {
		this.npercentage = npercentage;
	}

	/**
	 * Get nvalue
	 *
	 * @return the nvalue
	 */
	public BigDecimal getNvalue() {
		return nvalue;
	}

	/**
	 * set nvalue
	 *
	 * @param nvalue the nvalue to set
	 */
	public void setNvalue(final BigDecimal nvalue) {
		this.nvalue = nvalue;
	}

	/**
	 * Get nspmlDeduction
	 *
	 * @return the nspmlDeduction
	 */
	public int getNspmlDeduction() {
		return nspmlDeduction;
	}

	/**
	 * set nspmlDeduction
	 *
	 * @param nspmlDeduction the nspmlDeduction to set
	 */
	public void setNspmlDeduction(final int nspmlDeduction) {
		this.nspmlDeduction = nspmlDeduction;
	}

	/**
	 * Get nacTransfer
	 *
	 * @return the nacTransfer
	 */
	public int getNacTransfer() {
		return nacTransfer;
	}

	/**
	 * set nacTransfer
	 *
	 * @param nacTransfer the nacTransfer to set
	 */
	public void setNacTransfer(final int nacTransfer) {
		this.nacTransfer = nacTransfer;
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
	 * Get ncalcBasis
	 *
	 * @return the ncalcBasis
	 */
	public int getNcalcBasis() {
		return ncalcBasis;
	}

	/**
	 * set ncalcBasis
	 *
	 * @param ncalcBasis the ncalcBasis to set
	 */
	public void setNcalcBasis(final int ncalcBasis) {
		this.ncalcBasis = ncalcBasis;
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
	 * set nquantity7
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
	 * set nspmlQuantity
	 *
	 * @param nspmlQuantity the nspmlQuantity to set
	 */
	public void setNspmlQuantity(final int nspmlQuantity) {
		this.nspmlQuantity = nspmlQuantity;
	}

	/**
	 * Get careaHost
	 *
	 * @return the careaHost
	 */
	public String getCareaHost() {
		return careaHost;
	}

	/**
	 * set careaHost
	 *
	 * @param careaHost the careaHost to set
	 */
	public void setCareaHost(final String careaHost) {
		this.careaHost = careaHost;
	}

	/**
	 * Get ceffortHost
	 *
	 * @return the ceffortHost
	 */
	public String getCeffortHost() {
		return ceffortHost;
	}

	/**
	 * set ceffortHost
	 *
	 * @param ceffortHost the ceffortHost to set
	 */
	public void setCeffortHost(final String ceffortHost) {
		this.ceffortHost = ceffortHost;
	}

	/**
	 * Get cadditionalAccount
	 *
	 * @return the cadditionalAccount
	 */
	public String getCadditionalAccount() {
		return cadditionalAccount;
	}

	/**
	 * set cadditionalAccount
	 *
	 * @param cadditionalAccount the cadditionalAccount to set
	 */
	public void setCadditionalAccount(final String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
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
	 * set npltypeKey
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
	 * set nplKindKey
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
	 * set npackinglistKey
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
	 * set npackinglistDetailKey
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
	 * set ctext
	 *
	 * @param ctext the ctext to set
	 */
	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	/**
	 * Get ndistribute
	 *
	 * @return the ndistribute
	 */
	public Integer getNdistribute() {
		return ndistribute;
	}

	/**
	 * set ndistribute
	 *
	 * @param ndistribute the ndistribute to set
	 */
	public void setNdistribute(final Integer ndistribute) {
		this.ndistribute = ndistribute;
	}

	/**
	 * Get npostingType
	 *
	 * @return the npostingType
	 */
	public Integer getNpostingType() {
		return npostingType;
	}

	/**
	 * set npostingType
	 *
	 * @param npostingType the npostingType to set
	 */
	public void setNpostingType(final Integer npostingType) {
		this.npostingType = npostingType;
	}

	/**
	 * Get nsalesPrice
	 *
	 * @return the nsalesPrice
	 */
	public BigDecimal getNsalesPrice() {
		return nsalesPrice;
	}

	/**
	 * set nsalesPrice
	 *
	 * @param nsalesPrice the nsalesPrice to set
	 */
	public void setNsalesPrice(final BigDecimal nsalesPrice) {
		this.nsalesPrice = nsalesPrice;
	}

	/**
	 * Get ndeliveryNote
	 *
	 * @return the ndeliveryNote
	 */
	public Integer getNdeliveryNote() {
		return ndeliveryNote;
	}

	/**
	 * set ndeliveryNote
	 *
	 * @param ndeliveryNote the ndeliveryNote to set
	 */
	public void setNdeliveryNote(final Integer ndeliveryNote) {
		this.ndeliveryNote = ndeliveryNote;
	}

	/**
	 * Get cdeliverySnr
	 *
	 * @return the cdeliverySnr
	 */
	public String getCdeliverySnr() {
		return cdeliverySnr;
	}

	/**
	 * set cdeliverySnr
	 *
	 * @param cdeliverySnr the cdeliverySnr to set
	 */
	public void setCdeliverySnr(final String cdeliverySnr) {
		this.cdeliverySnr = cdeliverySnr;
	}

	/**
	 * Get cdeliveryText
	 *
	 * @return the cdeliveryText
	 */
	public String getCdeliveryText() {
		return cdeliveryText;
	}

	/**
	 * set cdeliveryText
	 *
	 * @param cdeliveryText the cdeliveryText to set
	 */
	public void setCdeliveryText(final String cdeliveryText) {
		this.cdeliveryText = cdeliveryText;
	}

	/**
	 * Get ncontrolling
	 *
	 * @return the ncontrolling
	 */
	public Integer getNcontrolling() {
		return ncontrolling;
	}

	/**
	 * set ncontrolling
	 *
	 * @param ncontrolling the ncontrolling to set
	 */
	public void setNcontrolling(final Integer ncontrolling) {
		this.ncontrolling = ncontrolling;
	}

	/**
	 * Get nsysaccountKey
	 *
	 * @return the nsysaccountKey
	 */
	public Long getNsysaccountKey() {
		return nsysaccountKey;
	}

	/**
	 * set nsysaccountKey
	 *
	 * @param nsysaccountKey the nsysaccountKey to set
	 */
	public void setNsysaccountKey(final Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	/**
	 * Get ccode
	 *
	 * @return the ccode
	 */
	public String getCcode() {
		return ccode;
	}

	/**
	 * set ccode
	 *
	 * @param ccode the ccode to set
	 */
	public void setCcode(final String ccode) {
		this.ccode = ccode;
	}

	/**
	 * Get nremittanceprice
	 *
	 * @return the nremittanceprice
	 */
	public BigDecimal getNremittanceprice() {
		return nremittanceprice;
	}

	/**
	 * set nremittanceprice
	 *
	 * @param nremittanceprice the nremittanceprice to set
	 */
	public void setNremittanceprice(final BigDecimal nremittanceprice) {
		this.nremittanceprice = nremittanceprice;
	}

	/**
	 * Get ndiscount
	 *
	 * @return the ndiscount
	 */
	public BigDecimal getNdiscount() {
		return ndiscount;
	}

	/**
	 * set ndiscount
	 *
	 * @param ndiscount the ndiscount to set
	 */
	public void setNdiscount(final BigDecimal ndiscount) {
		this.ndiscount = ndiscount;
	}

	/**
	 * Get nportfee
	 *
	 * @return the nportfee
	 */
	public BigDecimal getNportfee() {
		return nportfee;
	}

	/**
	 * set nportfee
	 *
	 * @param nportfee the nportfee to set
	 */
	public void setNportfee(final BigDecimal nportfee) {
		this.nportfee = nportfee;
	}

	/**
	 * Get nvatValue
	 *
	 * @return the nvatValue
	 */
	public BigDecimal getNvatValue() {
		return nvatValue;
	}

	/**
	 * set nvatValue
	 *
	 * @param nvatValue the nvatValue to set
	 */
	public void setNvatValue(final BigDecimal nvatValue) {
		this.nvatValue = nvatValue;
	}

	/**
	 * Get ninvoiceCycleKey
	 *
	 * @return the ninvoiceCycleKey
	 */
	public Long getNinvoiceCycleKey() {
		return ninvoiceCycleKey;
	}

	/**
	 * set ninvoiceCycleKey
	 *
	 * @param ninvoiceCycleKey the ninvoiceCycleKey to set
	 */
	public void setNinvoiceCycleKey(final Long ninvoiceCycleKey) {
		this.ninvoiceCycleKey = ninvoiceCycleKey;
	}

	/**
	 * Get ncostPrice
	 *
	 * @return the ncostPrice
	 */
	public BigDecimal getNcostPrice() {
		return ncostPrice;
	}

	/**
	 * set ncostPrice
	 *
	 * @param ncostPrice the ncostPrice to set
	 */
	public void setNcostPrice(final BigDecimal ncostPrice) {
		this.ncostPrice = ncostPrice;
	}

	/**
	 * Get ninvoiceStatus
	 *
	 * @return the ninvoiceStatus
	 */
	public Integer getNinvoiceStatus() {
		return ninvoiceStatus;
	}

	/**
	 * set ninvoiceStatus
	 *
	 * @param ninvoiceStatus the ninvoiceStatus to set
	 */
	public void setNinvoiceStatus(final Integer ninvoiceStatus) {
		this.ninvoiceStatus = ninvoiceStatus;
	}

	/**
	 * Get cclasses
	 *
	 * @return the cclasses
	 */
	public String getCclasses() {
		return cclasses;
	}

	/**
	 * set cclasses
	 *
	 * @param cclasses the cclasses to set
	 */
	public void setCclasses(final String cclasses) {
		this.cclasses = cclasses;
	}

	/**
	 * Get nsalesPriceModified
	 *
	 * @return the nsalesPriceModified
	 */
	public Integer getNsalesPriceModified() {
		return nsalesPriceModified;
	}

	/**
	 * set nsalesPriceModified
	 *
	 * @param nsalesPriceModified the nsalesPriceModified to set
	 */
	public void setNsalesPriceModified(final Integer nsalesPriceModified) {
		this.nsalesPriceModified = nsalesPriceModified;
	}

	/**
	 * Get npriceCalcType
	 *
	 * @return the npriceCalcType
	 */
	public Long getNpriceCalcType() {
		return npriceCalcType;
	}

	/**
	 * set npriceCalcType
	 *
	 * @param npriceCalcType the npriceCalcType to set
	 */
	public void setNpriceCalcType(final Long npriceCalcType) {
		this.npriceCalcType = npriceCalcType;
	}

	/**
	 * Get ncosttype
	 *
	 * @return the ncosttype
	 */
	public Long getNcosttype() {
		return ncosttype;
	}

	/**
	 * set ncosttype
	 *
	 * @param ncosttype the ncosttype to set
	 */
	public void setNcosttype(final Long ncosttype) {
		this.ncosttype = ncosttype;
	}

	/**
	 * Get ctaxcode
	 *
	 * @return the ctaxcode
	 */
	public String getCtaxcode() {
		return ctaxcode;
	}

	/**
	 * set ctaxcode
	 *
	 * @param ctaxcode the ctaxcode to set
	 */
	public void setCtaxcode(final String ctaxcode) {
		this.ctaxcode = ctaxcode;
	}

	/**
	 * Get nbillingPrice
	 *
	 * @return the nbillingPrice
	 */
	public BigDecimal getNbillingPrice() {
		return nbillingPrice;
	}

	/**
	 * set nbillingPrice
	 *
	 * @param nbillingPrice the nbillingPrice to set
	 */
	public void setNbillingPrice(final BigDecimal nbillingPrice) {
		this.nbillingPrice = nbillingPrice;
	}

	/**
	 * Get nreleaseExclusion
	 *
	 * @return the nreleaseExclusion
	 */
	public Integer getNreleaseExclusion() {
		return nreleaseExclusion;
	}

	/**
	 * set nreleaseExclusion
	 *
	 * @param nreleaseExclusion the nreleaseExclusion to set
	 */
	public void setNreleaseExclusion(final Integer nreleaseExclusion) {
		this.nreleaseExclusion = nreleaseExclusion;
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
	 * Get nquantityRecalc
	 *
	 * @return the nquantityRecalc
	 */
	public BigDecimal getNquantityRecalc() {
		return nquantityRecalc;
	}

	/**
	 * set nquantityRecalc
	 *
	 * @param nquantityRecalc the nquantityRecalc to set
	 */
	public void setNquantityRecalc(final BigDecimal nquantityRecalc) {
		this.nquantityRecalc = nquantityRecalc;
	}

	/**
	 * Get nsalesPriceRecalc
	 *
	 * @return the nsalesPriceRecalc
	 */
	public BigDecimal getNsalesPriceRecalc() {
		return nsalesPriceRecalc;
	}

	/**
	 * set nsalesPriceRecalc
	 *
	 * @param nsalesPriceRecalc the nsalesPriceRecalc to set
	 */
	public void setNsalesPriceRecalc(final BigDecimal nsalesPriceRecalc) {
		this.nsalesPriceRecalc = nsalesPriceRecalc;
	}

	/**
	 * Get nbillingPriceRecalc
	 *
	 * @return the nbillingPriceRecalc
	 */
	public BigDecimal getNbillingPriceRecalc() {
		return nbillingPriceRecalc;
	}

	/**
	 * set nbillingPriceRecalc
	 *
	 * @param nbillingPriceRecalc the nbillingPriceRecalc to set
	 */
	public void setNbillingPriceRecalc(final BigDecimal nbillingPriceRecalc) {
		this.nbillingPriceRecalc = nbillingPriceRecalc;
	}

	/**
	 * Get ncostPriceRecalc
	 *
	 * @return the ncostPriceRecalc
	 */
	public BigDecimal getNcostPriceRecalc() {
		return ncostPriceRecalc;
	}

	/**
	 * set ncostPriceRecalc
	 *
	 * @param ncostPriceRecalc the ncostPriceRecalc to set
	 */
	public void setNcostPriceRecalc(final BigDecimal ncostPriceRecalc) {
		this.ncostPriceRecalc = ncostPriceRecalc;
	}

	/**
	 * Get nremittencepriceRecalc
	 *
	 * @return the nremittencepriceRecalc
	 */
	public BigDecimal getNremittencepriceRecalc() {
		return nremittencepriceRecalc;
	}

	/**
	 * set nremittencepriceRecalc
	 *
	 * @param nremittencepriceRecalc the nremittencepriceRecalc to set
	 */
	public void setNremittencepriceRecalc(final BigDecimal nremittencepriceRecalc) {
		this.nremittencepriceRecalc = nremittencepriceRecalc;
	}

	/**
	 * Get nvatValueRecalc
	 *
	 * @return the nvatValueRecalc
	 */
	public BigDecimal getNvatValueRecalc() {
		return nvatValueRecalc;
	}

	/**
	 * set nvatValueRecalc
	 *
	 * @param nvatValueRecalc the nvatValueRecalc to set
	 */
	public void setNvatValueRecalc(final BigDecimal nvatValueRecalc) {
		this.nvatValueRecalc = nvatValueRecalc;
	}

	/**
	 * Get ndiscountRecalc
	 *
	 * @return the ndiscountRecalc
	 */
	public BigDecimal getNdiscountRecalc() {
		return ndiscountRecalc;
	}

	/**
	 * set ndiscountRecalc
	 *
	 * @param ndiscountRecalc the ndiscountRecalc to set
	 */
	public void setNdiscountRecalc(final BigDecimal ndiscountRecalc) {
		this.ndiscountRecalc = ndiscountRecalc;
	}

	/**
	 * Get nportfeeRecalc
	 *
	 * @return the nportfeeRecalc
	 */
	public BigDecimal getNportfeeRecalc() {
		return nportfeeRecalc;
	}

	/**
	 * set nportfeeRecalc
	 *
	 * @param nportfeeRecalc the nportfeeRecalc to set
	 */
	public void setNportfeeRecalc(final BigDecimal nportfeeRecalc) {
		this.nportfeeRecalc = nportfeeRecalc;
	}

	/**
	 * Get ncalcBasisRecalc
	 *
	 * @return the ncalcBasisRecalc
	 */
	public Integer getNcalcBasisRecalc() {
		return ncalcBasisRecalc;
	}

	/**
	 * set ncalcBasisRecalc
	 *
	 * @param ncalcBasisRecalc the ncalcBasisRecalc to set
	 */
	public void setNcalcBasisRecalc(final Integer ncalcBasisRecalc) {
		this.ncalcBasisRecalc = ncalcBasisRecalc;
	}

	/**
	 * Get nimportFromBob
	 *
	 * @return the nimportFromBob
	 */
	public Integer getNimportFromBob() {
		return nimportFromBob;
	}

	/**
	 * set nimportFromBob
	 *
	 * @param nimportFromBob the nimportFromBob to set
	 */
	public void setNimportFromBob(final Integer nimportFromBob) {
		this.nimportFromBob = nimportFromBob;
	}

	/**
	 * Get nvatValuePortfee
	 *
	 * @return the nvatValuePortfee
	 */
	public BigDecimal getNvatValuePortfee() {
		return nvatValuePortfee;
	}

	/**
	 * set nvatValuePortfee
	 *
	 * @param nvatValuePortfee the nvatValuePortfee to set
	 */
	public void setNvatValuePortfee(final BigDecimal nvatValuePortfee) {
		this.nvatValuePortfee = nvatValuePortfee;
	}

	/**
	 * Get nvatKey
	 *
	 * @return the nvatKey
	 */
	public Long getNvatKey() {
		return nvatKey;
	}

	/**
	 * set nvatKey
	 *
	 * @param nvatKey the nvatKey to set
	 */
	public void setNvatKey(final Long nvatKey) {
		this.nvatKey = nvatKey;
	}

	/**
	 * Get nvatKeyPortfee
	 *
	 * @return the nvatKeyPortfee
	 */
	public Long getNvatKeyPortfee() {
		return nvatKeyPortfee;
	}

	/**
	 * set nvatKeyPortfee
	 *
	 * @param nvatKeyPortfee the nvatKeyPortfee to set
	 */
	public void setNvatKeyPortfee(final Long nvatKeyPortfee) {
		this.nvatKeyPortfee = nvatKeyPortfee;
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
