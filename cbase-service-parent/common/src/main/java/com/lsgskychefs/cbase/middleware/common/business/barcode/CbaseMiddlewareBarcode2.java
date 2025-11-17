/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareBusinessException.CbaseMiddlewareBusinessExceptionType;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Version Model 2 of CBASE-Barcode Format. see http://cbasealm.ads.dlh.de/plugins/mediawiki/wiki/lsy/index.php/CBASE_Barcodes.
 *
 * @author Alex Schaab - U524036
 */
public class CbaseMiddlewareBarcode2 extends CbaseMiddlewareBarcode {

	/** barcodeId */
	private String barcodeId;

	/**
	 * Get barcodeId
	 *
	 * @return the barcodeId
	 */
	public String getBarcodeId() {
		return barcodeId;
	}

	/**
	 * set barcodeId
	 *
	 * @param barcodeId the barcodeId to set
	 */
	public void setBarcodeId(final String barcodeId) {
		this.barcodeId = barcodeId;
	}

	/**
	 * Individual parsing is done in inherited classes
	 * 
	 * @param barcodeValue the barcode without the barcodeId
	 * @throws CbaseMiddlewareParsingException {@link CbaseMiddlewareBusinessExceptionType#ILLEGAL_ARGUMENT} Parse error
	 */
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		// Individual parsing is done in inherited classes
	}

}
