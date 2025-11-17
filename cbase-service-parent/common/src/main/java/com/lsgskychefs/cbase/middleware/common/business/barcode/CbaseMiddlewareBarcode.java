/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;

/**
 * Version Model 1 of CBASE-Barcode Format. see http://cbasealm.ads.dlh.de/plugins/mediawiki/wiki/lsy/index.php/CBASE_Barcodes.
 *
 * @author Ingo Rietzschel - U125742
 */
public class CbaseMiddlewareBarcode extends AbstractPojo {

	/** barcodeType */
	protected CbaseMiddlewareBarcodeType barcodeType;
	/** npackinglistIndexKey */
	protected Long npackinglistIndexKey;
	/** referenceDate */
	protected Date referenceDate;
	/** nresultKey - flightKey */
	protected Long nresultKey;
	/** nstowageKey */
	protected Long nstowageKey;
	/** nquantity */
	protected BigDecimal nquantity;
	/** ncontainerKey */
	protected Long ncontainerKey;
	/** barcodeString */
	protected String barcodeString;
	/** base64 QR-Code 'png' image String */
	protected String qrCodeImgString;
	/** base64 DataMatrix 'png' image String */
	protected String dataMatrixImgString;

	/**
	 * Get barcodeType
	 *
	 * @return the barcodeType
	 */
	public CbaseMiddlewareBarcodeType getBarcodeType() {
		return barcodeType;
	}

	/**
	 * set barcodeType
	 *
	 * @param barcodeType the barcodeType to set
	 */
	public void setBarcodeType(final CbaseMiddlewareBarcodeType barcodeType) {
		this.barcodeType = barcodeType;
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
	 * Get referenceDate
	 *
	 * @return the referenceDate
	 */
	public Date getReferenceDate() {
		return referenceDate;
	}

	/**
	 * set referenceDate
	 *
	 * @param referenceDate the referenceDate to set
	 */
	public void setReferenceDate(final Date referenceDate) {
		this.referenceDate = referenceDate;
	}

	/**
	 * Get nresultKey
	 *
	 * @return the nresultKey
	 */
	public Long getNresultKey() {
		return nresultKey;
	}

	/**
	 * set nresultKey
	 *
	 * @param nresultKey the nresultKey to set
	 */
	public void setNresultKey(final Long nresultKey) {
		this.nresultKey = nresultKey;
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
	 * Get ncontainerKey
	 *
	 * @return the ncontainerKey
	 */
	public Long getNcontainerKey() {
		return ncontainerKey;
	}

	/**
	 * set ncontainerKey
	 *
	 * @param ncontainerKey the ncontainerKey to set
	 */
	public void setNcontainerKey(final Long ncontainerKey) {
		this.ncontainerKey = ncontainerKey;
	}

	/**
	 * Get barcodeString
	 *
	 * @return the barcodeString
	 */
	public String getBarcodeString() {
		return barcodeString;
	}

	/**
	 * set barcodeString
	 *
	 * @param barcodeString the barcodeString to set
	 */
	public void setBarcodeString(final String barcodeString) {
		this.barcodeString = barcodeString;
	}

	/**
	 * Get qrCodeImgString (base64 QR-Code 'png' image String)
	 *
	 * @return the qrCodeImgString
	 */
	public String getQrCodeImgString() {
		return qrCodeImgString;
	}

	/**
	 * set qrCodeImgString(base64 QR-Code 'png' image String)
	 *
	 * @param qrCodeImgString the qrCodeImgString to set
	 */
	public void setQrCodeImgString(final String qrCodeImgString) {
		this.qrCodeImgString = qrCodeImgString;
	}

	/**
	 * Get dataMatrixImgString(base64 DataMatrix 'png' image String)
	 *
	 * @return the dataMatrixImgString
	 */
	public String getDataMatrixImgString() {
		return dataMatrixImgString;
	}

	/**
	 * set dataMatrixImgString(base64 DataMatrix 'png' image String)
	 *
	 * @param dataMatrixImgString the dataMatrixImgString to set
	 */
	public void setDataMatrixImgString(final String dataMatrixImgString) {
		this.dataMatrixImgString = dataMatrixImgString;
	}

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
