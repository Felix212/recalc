/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * All supported barcode types.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum CbaseMiddlewareBarcodeType {
	// Format V1
	/** Flight label code. */
	FLIGHT_LABEL,
	/** Prod label code */
	PROD_LABEL,
	/** Packinglist label code contains reference date. Crystal reports can create this label type. */
	ITEM_LIST_LABEL,
	/** SPML label code */
	SPML_LABEL,
	/** PPS label code */
	PPS_LABEL,
	/** Unknown code, but the format is correct. */
	UNKNOWN,
	// Format V2
	/** flight label code */
	FLIGHT_LABEL_VPS(FlightLabelVpsBarcode.class, "%001%"),
	/** prod label vps code */
	PROD_LABEL_VPS(ProdLabelVpsBarcode.class, "%003%"),
	/** trolley label code */
	TROLLEY_LABEL(TrolleyLabelBarcode.class, "%005%"),
	/** SAP label code */
	SAP_LABEL(SapLabelBarcode.class, "%007%"),
	/** SAP label code */
	CHILLER_BIN_LABEL(ChillerBinLabelBarcode.class, "%008%"),
	/** tour label code */
	TOUR_LABEL(TourLabelBarcode.class, "%009%");

	/** The Barcode ID */
	private String barcodeId;

	/** The Class of Label */
	private Class<? extends CbaseMiddlewareBarcode2> barcodeClass;

	/**
	 * Constructor for BarcodesV1
	 */
	CbaseMiddlewareBarcodeType() {
	}

	/**
	 * Constructor for BarcodesV2
	 * 
	 * @param barcodeClass the java class for creating such a Barcode
	 * @param barcodeId the ID: e.g. <001>
	 */
	CbaseMiddlewareBarcodeType(final Class<? extends CbaseMiddlewareBarcode2> barcodeClass, final String barcodeId) {
		this.barcodeClass = barcodeClass;
		this.barcodeId = barcodeId;
	}

	/**
	 * Get barcodeId
	 *
	 * @return the barcodeId
	 */
	public String getBarcodeId() {
		return this.barcodeId;
	}

	/**
	 * Get the right LabelBarcode class with parsed results
	 * 
	 * @param barcodeValue the barcode value without barcodeId
	 * @return A {@link CbaseMiddlewareBarcode2} Label in {@link com.lsgskychefs.cbase.middleware.common.business.barcode.v2}
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error, wrong length
	 */
	public CbaseMiddlewareBarcode2 create(final String barcodeValue) throws CbaseMiddlewareParsingException {
		try {
			final CbaseMiddlewareBarcode2 barcode = this.barcodeClass.newInstance();
			barcode.parse(barcodeValue);
			barcode.setBarcodeId(this.barcodeId);
			barcode.setBarcodeType(this);
			return barcode;
		} catch (InstantiationException | IllegalAccessException e) {
			throw new CbaseMiddlewareParsingException(CbaseMiddlewareBusinessExceptionType.ILLEGAL_ARGUMENT,
					String.format("Could not parse the barcode [%s] due to a technical error: ", barcodeValue), e);
		}
	}

}
