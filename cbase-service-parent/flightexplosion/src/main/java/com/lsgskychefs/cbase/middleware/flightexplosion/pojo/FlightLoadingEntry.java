/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.pojo;

import java.math.BigDecimal;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query flight-loading-query.sql.
 *
 * @author Dirk Bunk - U200035
 */
public class FlightLoadingEntry extends AbstractPojo implements CbaseMiddlewareEntry {
	private String cenAirCaccount;

	private String cenGalCgalley;

	private Integer cenGalNsort;

	private String cenLlIdxCloadinglist;

	private Long cenLlIdxNloadinglistKey;

	private String cenLlCactioncode;

	private String cenLlCaddOnText;

	private String cenLlCclass;

	private String cenLlCgoodsRecipient;

	private String cenLlCsalesRel;

	private Long cenLlNbellyContainer;

	private Long cenLlNloadinglistDetailKey;

	private Long cenLlNloadinglistIndexKey;

	private BigDecimal cenLlNquantity;

	private Long cenLlNreckoning;

	private String cenPlIdxCpackinglist;

	private Long cenPlIdxNplIndexKey;

	private Long cenPlIdxNplKindKey;

	private String cenPlCcustomerPl;

	private String cenPlCcustomerText;

	private String cenPlCdefStorageLocation;

	private String cenPlCtext;

	private String cenPlCtextShort;

	private String cenPlCunit;

	private Long cenPlNaccountKey;

	private Long cenPlNpackinglistDetailKey;

	private Long cenPlNpackinglistKey;

	private String cenStowCplace;

	private String cenStowCstowage;

	private Integer cenStowNpage;

	private Long cenStowNstowageKey;

	private Integer cenStowNsort;

	private String sysProdCprodCatText;

	private String computeOnloadText;

	/**
	 * Get cenAirCaccount
	 *
	 * @return the cenAirCaccount
	 */
	public String getCenAirCaccount() {
		return cenAirCaccount;
	}

	/**
	 * set cenAirCaccount
	 *
	 * @param cenAirCaccount the cenAirCaccount to set
	 */
	public void setCenAirCaccount(final String cenAirCaccount) {
		this.cenAirCaccount = cenAirCaccount;
	}

	/**
	 * Get cenGalCgalley
	 *
	 * @return the cenGalCgalley
	 */
	public String getCenGalCgalley() {
		return cenGalCgalley;
	}

	/**
	 * set cenGalCgalley
	 *
	 * @param cenGalCgalley the cenGalCgalley to set
	 */
	public void setCenGalCgalley(final String cenGalCgalley) {
		this.cenGalCgalley = cenGalCgalley;
	}

	/**
	 * Get cenGalNsort
	 *
	 * @return the cenGalNsort
	 */
	public Integer getCenGalNsort() {
		return cenGalNsort;
	}

	/**
	 * set cenGalNsort
	 *
	 * @param cenGalNsort the cenGalNsort to set
	 */
	public void setCenGalNsort(final Integer cenGalNsort) {
		this.cenGalNsort = cenGalNsort;
	}

	/**
	 * Get cenLlIdxCloadinglist
	 *
	 * @return the cenLlIdxCloadinglist
	 */
	public String getCenLlIdxCloadinglist() {
		return cenLlIdxCloadinglist;
	}

	/**
	 * set cenLlIdxCloadinglist
	 *
	 * @param cenLlIdxCloadinglist the cenLlIdxCloadinglist to set
	 */
	public void setCenLlIdxCloadinglist(final String cenLlIdxCloadinglist) {
		this.cenLlIdxCloadinglist = cenLlIdxCloadinglist;
	}

	/**
	 * Get cenLlIdxNloadinglistKey
	 *
	 * @return the cenLlIdxNloadinglistKey
	 */
	public Long getCenLlIdxNloadinglistKey() {
		return cenLlIdxNloadinglistKey;
	}

	/**
	 * set cenLlIdxNloadinglistKey
	 *
	 * @param cenLlIdxNloadinglistKey the cenLlIdxNloadinglistKey to set
	 */
	public void setCenLlIdxNloadinglistKey(final Long cenLlIdxNloadinglistKey) {
		this.cenLlIdxNloadinglistKey = cenLlIdxNloadinglistKey;
	}

	/**
	 * Get cenLlCactioncode
	 *
	 * @return the cenLlCactioncode
	 */
	public String getCenLlCactioncode() {
		return cenLlCactioncode;
	}

	/**
	 * set cenLlCactioncode
	 *
	 * @param cenLlCactioncode the cenLlCactioncode to set
	 */
	public void setCenLlCactioncode(final String cenLlCactioncode) {
		this.cenLlCactioncode = cenLlCactioncode;
	}

	/**
	 * Get cenLlCaddOnText
	 *
	 * @return the cenLlCaddOnText
	 */
	public String getCenLlCaddOnText() {
		return cenLlCaddOnText;
	}

	/**
	 * set cenLlCaddOnText
	 *
	 * @param cenLlCaddOnText the cenLlCaddOnText to set
	 */
	public void setCenLlCaddOnText(final String cenLlCaddOnText) {
		this.cenLlCaddOnText = cenLlCaddOnText;
	}

	/**
	 * Get cenLlCclass
	 *
	 * @return the cenLlCclass
	 */
	public String getCenLlCclass() {
		return cenLlCclass;
	}

	/**
	 * set cenLlCclass
	 *
	 * @param cenLlCclass the cenLlCclass to set
	 */
	public void setCenLlCclass(final String cenLlCclass) {
		this.cenLlCclass = cenLlCclass;
	}

	/**
	 * Get cenLlCgoodsRecipient
	 *
	 * @return the cenLlCgoodsRecipient
	 */
	public String getCenLlCgoodsRecipient() {
		return cenLlCgoodsRecipient;
	}

	/**
	 * set cenLlCgoodsRecipient
	 *
	 * @param cenLlCgoodsRecipient the cenLlCgoodsRecipient to set
	 */
	public void setCenLlCgoodsRecipient(final String cenLlCgoodsRecipient) {
		this.cenLlCgoodsRecipient = cenLlCgoodsRecipient;
	}

	/**
	 * Get cenLlCsalesRel
	 *
	 * @return the cenLlCsalesRel
	 */
	public String getCenLlCsalesRel() {
		return cenLlCsalesRel;
	}

	/**
	 * set cenLlCsalesRel
	 *
	 * @param cenLlCsalesRel the cenLlCsalesRel to set
	 */
	public void setCenLlCsalesRel(final String cenLlCsalesRel) {
		this.cenLlCsalesRel = cenLlCsalesRel;
	}

	/**
	 * Get cenLlNbellyContainer
	 *
	 * @return the cenLlNbellyContainer
	 */
	public Long getCenLlNbellyContainer() {
		return cenLlNbellyContainer;
	}

	/**
	 * set cenLlNbellyContainer
	 *
	 * @param cenLlNbellyContainer the cenLlNbellyContainer to set
	 */
	public void setCenLlNbellyContainer(final Long cenLlNbellyContainer) {
		this.cenLlNbellyContainer = cenLlNbellyContainer;
	}

	/**
	 * Get cenLlNloadinglistDetailKey
	 *
	 * @return the cenLlNloadinglistDetailKey
	 */
	public Long getCenLlNloadinglistDetailKey() {
		return cenLlNloadinglistDetailKey;
	}

	/**
	 * set cenLlNloadinglistDetailKey
	 *
	 * @param cenLlNloadinglistDetailKey the cenLlNloadinglistDetailKey to set
	 */
	public void setCenLlNloadinglistDetailKey(final Long cenLlNloadinglistDetailKey) {
		this.cenLlNloadinglistDetailKey = cenLlNloadinglistDetailKey;
	}

	/**
	 * Get cenLlNloadinglistIndexKey
	 *
	 * @return the cenLlNloadinglistIndexKey
	 */
	public Long getCenLlNloadinglistIndexKey() {
		return cenLlNloadinglistIndexKey;
	}

	/**
	 * set cenLlNloadinglistIndexKey
	 *
	 * @param cenLlNloadinglistIndexKey the cenLlNloadinglistIndexKey to set
	 */
	public void setCenLlNloadinglistIndexKey(final Long cenLlNloadinglistIndexKey) {
		this.cenLlNloadinglistIndexKey = cenLlNloadinglistIndexKey;
	}

	/**
	 * Get cenLlNquantity
	 *
	 * @return the cenLlNquantity
	 */
	public BigDecimal getCenLlNquantity() {
		return cenLlNquantity;
	}

	/**
	 * set cenLlNquantity
	 *
	 * @param cenLlNquantity the cenLlNquantity to set
	 */
	public void setCenLlNquantity(final BigDecimal cenLlNquantity) {
		this.cenLlNquantity = cenLlNquantity;
	}

	/**
	 * Get cenLlNreckoning
	 *
	 * @return the cenLlNreckoning
	 */
	public Long getCenLlNreckoning() {
		return cenLlNreckoning;
	}

	/**
	 * set cenLlNreckoning
	 *
	 * @param cenLlNreckoning the cenLlNreckoning to set
	 */
	public void setCenLlNreckoning(final Long cenLlNreckoning) {
		this.cenLlNreckoning = cenLlNreckoning;
	}

	/**
	 * Get cenPlIdxCpackinglist
	 *
	 * @return the cenPlIdxCpackinglist
	 */
	public String getCenPlIdxCpackinglist() {
		return cenPlIdxCpackinglist;
	}

	/**
	 * set cenPlIdxCpackinglist
	 *
	 * @param cenPlIdxCpackinglist the cenPlIdxCpackinglist to set
	 */
	public void setCenPlIdxCpackinglist(final String cenPlIdxCpackinglist) {
		this.cenPlIdxCpackinglist = cenPlIdxCpackinglist;
	}

	/**
	 * Get cenPlIdxNplIndexKey
	 *
	 * @return the cenPlIdxNplIndexKey
	 */
	public Long getCenPlIdxNplIndexKey() {
		return cenPlIdxNplIndexKey;
	}

	/**
	 * set cenPlIdxNplIndexKey
	 *
	 * @param cenPlIdxNplIndexKey the cenPlIdxNplIndexKey to set
	 */
	public void setCenPlIdxNplIndexKey(final Long cenPlIdxNplIndexKey) {
		this.cenPlIdxNplIndexKey = cenPlIdxNplIndexKey;
	}

	/**
	 * Get cenPlIdxNplKindKey
	 *
	 * @return the cenPlIdxNplKindKey
	 */
	public Long getCenPlIdxNplKindKey() {
		return cenPlIdxNplKindKey;
	}

	/**
	 * set cenPlIdxNplKindKey
	 *
	 * @param cenPlIdxNplKindKey the cenPlIdxNplKindKey to set
	 */
	public void setCenPlIdxNplKindKey(final Long cenPlIdxNplKindKey) {
		this.cenPlIdxNplKindKey = cenPlIdxNplKindKey;
	}

	/**
	 * Get cenPlCcustomerPl
	 *
	 * @return the cenPlCcustomerPl
	 */
	public String getCenPlCcustomerPl() {
		return cenPlCcustomerPl;
	}

	/**
	 * set cenPlCcustomerPl
	 *
	 * @param cenPlCcustomerPl the cenPlCcustomerPl to set
	 */
	public void setCenPlCcustomerPl(final String cenPlCcustomerPl) {
		this.cenPlCcustomerPl = cenPlCcustomerPl;
	}

	/**
	 * Get cenPlCcustomerText
	 *
	 * @return the cenPlCcustomerText
	 */
	public String getCenPlCcustomerText() {
		return cenPlCcustomerText;
	}

	/**
	 * set cenPlCcustomerText
	 *
	 * @param cenPlCcustomerText the cenPlCcustomerText to set
	 */
	public void setCenPlCcustomerText(final String cenPlCcustomerText) {
		this.cenPlCcustomerText = cenPlCcustomerText;
	}

	/**
	 * Get cenPlCdefStorageLocation
	 *
	 * @return the cenPlCdefStorageLocation
	 */
	public String getCenPlCdefStorageLocation() {
		return cenPlCdefStorageLocation;
	}

	/**
	 * set cenPlCdefStorageLocation
	 *
	 * @param cenPlCdefStorageLocation the cenPlCdefStorageLocation to set
	 */
	public void setCenPlCdefStorageLocation(final String cenPlCdefStorageLocation) {
		this.cenPlCdefStorageLocation = cenPlCdefStorageLocation;
	}

	/**
	 * Get cenPlCtext
	 *
	 * @return the cenPlCtext
	 */
	public String getCenPlCtext() {
		return cenPlCtext;
	}

	/**
	 * set cenPlCtext
	 *
	 * @param cenPlCtext the cenPlCtext to set
	 */
	public void setCenPlCtext(final String cenPlCtext) {
		this.cenPlCtext = cenPlCtext;
	}

	/**
	 * Get cenPlCtextShort
	 *
	 * @return the cenPlCtextShort
	 */
	public String getCenPlCtextShort() {
		return cenPlCtextShort;
	}

	/**
	 * set cenPlCtextShort
	 *
	 * @param cenPlCtextShort the cenPlCtextShort to set
	 */
	public void setCenPlCtextShort(final String cenPlCtextShort) {
		this.cenPlCtextShort = cenPlCtextShort;
	}

	/**
	 * Get cenPlCunit
	 *
	 * @return the cenPlCunit
	 */
	public String getCenPlCunit() {
		return cenPlCunit;
	}

	/**
	 * set cenPlCunit
	 *
	 * @param cenPlCunit the cenPlCunit to set
	 */
	public void setCenPlCunit(final String cenPlCunit) {
		this.cenPlCunit = cenPlCunit;
	}

	/**
	 * Get cenPlNaccountKey
	 *
	 * @return the cenPlNaccountKey
	 */
	public Long getCenPlNaccountKey() {
		return cenPlNaccountKey;
	}

	/**
	 * set cenPlNaccountKey
	 *
	 * @param cenPlNaccountKey the cenPlNaccountKey to set
	 */
	public void setCenPlNaccountKey(final Long cenPlNaccountKey) {
		this.cenPlNaccountKey = cenPlNaccountKey;
	}

	/**
	 * Get cenPlNpackinglistDetailKey
	 *
	 * @return the cenPlNpackinglistDetailKey
	 */
	public Long getCenPlNpackinglistDetailKey() {
		return cenPlNpackinglistDetailKey;
	}

	/**
	 * set cenPlNpackinglistDetailKey
	 *
	 * @param cenPlNpackinglistDetailKey the cenPlNpackinglistDetailKey to set
	 */
	public void setCenPlNpackinglistDetailKey(final Long cenPlNpackinglistDetailKey) {
		this.cenPlNpackinglistDetailKey = cenPlNpackinglistDetailKey;
	}

	/**
	 * Get cenPlNpackinglistKey
	 *
	 * @return the cenPlNpackinglistKey
	 */
	public Long getCenPlNpackinglistKey() {
		return cenPlNpackinglistKey;
	}

	/**
	 * set cenPlNpackinglistKey
	 *
	 * @param cenPlNpackinglistKey the cenPlNpackinglistKey to set
	 */
	public void setCenPlNpackinglistKey(final Long cenPlNpackinglistKey) {
		this.cenPlNpackinglistKey = cenPlNpackinglistKey;
	}

	/**
	 * Get cenStowCplace
	 *
	 * @return the cenStowCplace
	 */
	public String getCenStowCplace() {
		return cenStowCplace;
	}

	/**
	 * set cenStowCplace
	 *
	 * @param cenStowCplace the cenStowCplace to set
	 */
	public void setCenStowCplace(final String cenStowCplace) {
		this.cenStowCplace = cenStowCplace;
	}

	/**
	 * Get cenStowCstowage
	 *
	 * @return the cenStowCstowage
	 */
	public String getCenStowCstowage() {
		return cenStowCstowage;
	}

	/**
	 * set cenStowCstowage
	 *
	 * @param cenStowCstowage the cenStowCstowage to set
	 */
	public void setCenStowCstowage(final String cenStowCstowage) {
		this.cenStowCstowage = cenStowCstowage;
	}

	/**
	 * Get cenStowNpage
	 *
	 * @return the cenStowNpage
	 */
	public Integer getCenStowNpage() {
		return cenStowNpage;
	}

	/**
	 * set cenStowNpage
	 *
	 * @param cenStowNpage the cenStowNpage to set
	 */
	public void setCenStowNpage(final Integer cenStowNpage) {
		this.cenStowNpage = cenStowNpage;
	}

	/**
	 * Get cenStowNstowageKey
	 *
	 * @return the cenStowNstowageKey
	 */
	public Long getCenStowNstowageKey() {
		return cenStowNstowageKey;
	}

	/**
	 * set cenStowNstowageKey
	 *
	 * @param cenStowNstowageKey the cenStowNstowageKey to set
	 */
	public void setCenStowNstowageKey(final Long cenStowNstowageKey) {
		this.cenStowNstowageKey = cenStowNstowageKey;
	}

	/**
	 * Get cenStowNsort
	 *
	 * @return the cenStowNsort
	 */
	public Integer getCenStowNsort() {
		return cenStowNsort;
	}

	/**
	 * set cenStowNsort
	 *
	 * @param cenStowNsort the cenStowNsort to set
	 */
	public void setCenStowNsort(final Integer cenStowNsort) {
		this.cenStowNsort = cenStowNsort;
	}

	/**
	 * Get sysProdCprodCatText
	 *
	 * @return the sysProdCprodCatText
	 */
	public String getSysProdCprodCatText() {
		return sysProdCprodCatText;
	}

	/**
	 * set sysProdCprodCatText
	 *
	 * @param sysProdCprodCatText the sysProdCprodCatText to set
	 */
	public void setSysProdCprodCatText(final String sysProdCprodCatText) {
		this.sysProdCprodCatText = sysProdCprodCatText;
	}

	/**
	 * Get computeOnloadText
	 *
	 * @return the computeOnloadText
	 */
	public String getComputeOnloadText() {
		return computeOnloadText;
	}

	/**
	 * set computeOnloadText
	 *
	 * @param computeOnloadText the computeOnloadText to set
	 */
	public void setComputeOnloadText(final String computeOnloadText) {
		this.computeOnloadText = computeOnloadText;
	}
}
