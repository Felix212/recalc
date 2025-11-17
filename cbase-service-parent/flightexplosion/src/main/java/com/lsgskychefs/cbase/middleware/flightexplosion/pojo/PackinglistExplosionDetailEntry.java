/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (packinglist-explosion-detail-query.sql)
 *
 * @author Dirk Bunk - U200035
 */
public class PackinglistExplosionDetailEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	private long npackinglistIndexKey;

	private long ndetailKey;

	private long npackinglistKey;

	private String ckind;

	private String ctext;

	private String ccustomerPl;

	private String ccustomerText;

	private String cdefStorageLocation;

	private long npackingListLevel;

	private long npackinglistDetailKey;

	private BigDecimal nquantity;

	private String cunit;

	private long nreckoning;

	private Integer nnumberPackages;

	private String csalesRel;

	private String cgoodsRecipient;

	private String cplText;

	private String cplTextShort;

	private String cplTextShort2;

	private Integer nuseReserve;

	private String cprodCatText;

	private String cpackinglist;

	private Long nplKindKey;

	private Long nmaterialIndexKey;

	private Long nworkstationKey;

	private Long nareaKey;

	private Long nplAreaKey;

	private String caccount;

	private Long naccountKey;

	private Long npltimeframeIndex;

	private Integer nbatch;

	private Integer noffset;

	private Long nworkscheduleIndex;

	private Integer nflightOffset;

	private Long nflightWorkscheduleIndex;

	private Long npltfFlightIndexGroup;

	private Long npltfFlightIndex;

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
	 * Get npackinglistKey
	 *
	 * @return the npackinglistKey
	 */
	public long getNpackinglistKey() {
		return npackinglistKey;
	}

	/**
	 * set npackinglistKey
	 *
	 * @param npackinglistKey the npackinglistKey to set
	 */
	public void setNpackinglistKey(final long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	/**
	 * Get ckind
	 *
	 * @return the ckind
	 */
	public String getCkind() {
		return ckind;
	}

	/**
	 * set ckind
	 *
	 * @param ckind the ckind to set
	 */
	public void setCkind(final String ckind) {
		this.ckind = ckind;
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
	 * Get cdefStorageLocation
	 *
	 * @return the cdefStorageLocation
	 */
	public String getCdefStorageLocation() {
		return cdefStorageLocation;
	}

	/**
	 * set cdefStorageLocation
	 *
	 * @param cdefStorageLocation the cdefStorageLocation to set
	 */
	public void setCdefStorageLocation(final String cdefStorageLocation) {
		this.cdefStorageLocation = cdefStorageLocation;
	}

	/**
	 * Get npackingListLevel
	 *
	 * @return the npackingListLevel
	 */
	public long getNpackingListLevel() {
		return npackingListLevel;
	}

	/**
	 * set npackingListLevel
	 *
	 * @param npackingListLevel the npackingListLevel to set
	 */
	public void setNpackingListLevel(final long npackingListLevel) {
		this.npackingListLevel = npackingListLevel;
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
	 * Get nreckoning
	 *
	 * @return the nreckoning
	 */
	public long getNreckoning() {
		return nreckoning;
	}

	/**
	 * set nreckoning
	 *
	 * @param nreckoning the nreckoning to set
	 */
	public void setNreckoning(final long nreckoning) {
		this.nreckoning = nreckoning;
	}

	/**
	 * Get nnumberPackages
	 *
	 * @return the nnumberPackages
	 */
	public Integer getNnumberPackages() {
		return nnumberPackages;
	}

	/**
	 * set nnumberPackages
	 *
	 * @param nnumberPackages the nnumberPackages to set
	 */
	public void setNnumberPackages(final Integer nnumberPackages) {
		this.nnumberPackages = nnumberPackages;
	}

	/**
	 * Get csalesRel
	 *
	 * @return the csalesRel
	 */
	public String getCsalesRel() {
		return csalesRel;
	}

	/**
	 * set csalesRel
	 *
	 * @param csalesRel the csalesRel to set
	 */
	public void setCsalesRel(final String csalesRel) {
		this.csalesRel = csalesRel;
	}

	/**
	 * Get cgoodsRecipient
	 *
	 * @return the cgoodsRecipient
	 */
	public String getCgoodsRecipient() {
		return cgoodsRecipient;
	}

	/**
	 * set cgoodsRecipient
	 *
	 * @param cgoodsRecipient the cgoodsRecipient to set
	 */
	public void setCgoodsRecipient(final String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

	/**
	 * Get cplText
	 *
	 * @return the cplText
	 */
	public String getCplText() {
		return cplText;
	}

	/**
	 * set cplText
	 *
	 * @param cplText the cplText to set
	 */
	public void setCplText(final String cplText) {
		this.cplText = cplText;
	}

	/**
	 * Get cplTextShort
	 *
	 * @return the cplTextShort
	 */
	public String getCplTextShort() {
		return cplTextShort;
	}

	/**
	 * set cplTextShort
	 *
	 * @param cplTextShort the cplTextShort to set
	 */
	public void setCplTextShort(final String cplTextShort) {
		this.cplTextShort = cplTextShort;
	}

	/**
	 * Get cplTextShort2
	 *
	 * @return the cplTextShort2
	 */
	public String getCplTextShort2() {
		return cplTextShort2;
	}

	/**
	 * set cplTextShort2
	 *
	 * @param cplTextShort2 the cplTextShort2 to set
	 */
	public void setCplTextShort2(final String cplTextShort2) {
		this.cplTextShort2 = cplTextShort2;
	}

	/**
	 * Get nuseReserve
	 *
	 * @return the nuseReserve
	 */
	public Integer getNuseReserve() {
		return nuseReserve;
	}

	/**
	 * set nuseReserve
	 *
	 * @param nuseReserve the nuseReserve to set
	 */
	public void setNuseReserve(final Integer nuseReserve) {
		this.nuseReserve = nuseReserve;
	}

	/**
	 * Get cprodCatText
	 *
	 * @return the cprodCatText
	 */
	public String getCprodCatText() {
		return cprodCatText;
	}

	/**
	 * set cprodCatText
	 *
	 * @param cprodCatText the cprodCatText to set
	 */
	public void setCprodCatText(final String cprodCatText) {
		this.cprodCatText = cprodCatText;
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
	 * Get nplAreaKey
	 *
	 * @return the nplAreaKey
	 */
	public Long getNplAreaKey() {
		return nplAreaKey;
	}

	/**
	 * set nplAreaKey
	 *
	 * @param nplAreaKey the nplAreaKey to set
	 */
	public void setNplAreaKey(final Long nplAreaKey) {
		this.nplAreaKey = nplAreaKey;
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
	 * Get npltimeframeIndex
	 *
	 * @return the npltimeframeIndex
	 */
	public Long getNpltimeframeIndex() {
		return npltimeframeIndex;
	}

	/**
	 * set npltimeframeIndex
	 *
	 * @param npltimeframeIndex the npltimeframeIndex to set
	 */
	public void setNpltimeframeIndex(final Long npltimeframeIndex) {
		this.npltimeframeIndex = npltimeframeIndex;
	}

	/**
	 * Get nbatch
	 *
	 * @return the nbatch
	 */
	public Integer getNbatch() {
		return nbatch;
	}

	/**
	 * set nbatch
	 *
	 * @param nbatch the nbatch to set
	 */
	public void setNbatch(final Integer nbatch) {
		this.nbatch = nbatch;
	}

	/**
	 * Get noffset
	 *
	 * @return the noffset
	 */
	public Integer getNoffset() {
		return noffset;
	}

	/**
	 * set noffset
	 *
	 * @param noffset the noffset to set
	 */
	public void setNoffset(final Integer noffset) {
		this.noffset = noffset;
	}

	/**
	 * Get nworkscheduleIndex
	 *
	 * @return the nworkscheduleIndex
	 */
	public Long getNworkscheduleIndex() {
		return nworkscheduleIndex;
	}

	/**
	 * set nworkscheduleIndex
	 *
	 * @param nworkscheduleIndex the nworkscheduleIndex to set
	 */
	public void setNworkscheduleIndex(final Long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	/**
	 * Get nflightOffset
	 *
	 * @return the nflightOffset
	 */
	public Integer getNflightOffset() {
		return nflightOffset;
	}

	/**
	 * set nflightOffset
	 *
	 * @param nflightOffset the nflightOffset to set
	 */
	public void setNflightOffset(final Integer nflightOffset) {
		this.nflightOffset = nflightOffset;
	}

	/**
	 * Get nflightWorkscheduleIndex
	 *
	 * @return the nflightWorkscheduleIndex
	 */
	public Long getNflightWorkscheduleIndex() {
		return nflightWorkscheduleIndex;
	}

	/**
	 * set nflightWorkscheduleIndex
	 *
	 * @param nflightWorkscheduleIndex the nflightWorkscheduleIndex to set
	 */
	public void setNflightWorkscheduleIndex(final Long nflightWorkscheduleIndex) {
		this.nflightWorkscheduleIndex = nflightWorkscheduleIndex;
	}

	/**
	 * Get npltfFlightIndexGroup
	 *
	 * @return the npltfFlightIndexGroup
	 */
	public Long getNpltfFlightIndexGroup() {
		return npltfFlightIndexGroup;
	}

	/**
	 * set npltfFlightIndexGroup
	 *
	 * @param npltfFlightIndexGroup the npltfFlightIndexGroup to set
	 */
	public void setNpltfFlightIndexGroup(final Long npltfFlightIndexGroup) {
		this.npltfFlightIndexGroup = npltfFlightIndexGroup;
	}

	/**
	 * Get npltfFlightIndex
	 *
	 * @return the npltfFlightIndex
	 */
	public Long getNpltfFlightIndex() {
		return npltfFlightIndex;
	}

	/**
	 * set npltfFlightIndex
	 *
	 * @param npltfFlightIndex the npltfFlightIndex to set
	 */
	public void setNpltfFlightIndex(final Long npltfFlightIndex) {
		this.npltfFlightIndex = npltfFlightIndex;
	}
}
