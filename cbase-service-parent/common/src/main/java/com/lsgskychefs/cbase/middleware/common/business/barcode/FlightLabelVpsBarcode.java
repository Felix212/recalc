/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Flight Label VPS Barcode [sample] <001>00000200193118042017000023495158000008154711000008154711
 *
 * @author Kostadin Kostov - U140907
 */
public class FlightLabelVpsBarcode extends CbaseMiddlewareBarcode2 {

	/** ProdLabel Key */
	private Long nppmProdLabelKey;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		npackinglistIndexKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "npackingListKey", 0, 12);
		referenceDate = CbaseMiddlewareBarcodeParser.parseDate(barcodeValue, 12);
		nresultKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nresultKey", 20, 32);
		nstowageKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nstowageKey", 32, 44);
		nppmProdLabelKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nppmProdLabelKey", 44, 56);
	}

	/**
	 * Get nppmProdLabelKey
	 *
	 * @return the nppmProdLabelKey
	 */
	public Long getNppmProdLabelKey() {
		return nppmProdLabelKey;
	}

	/**
	 * Set nppmProdLabelKey
	 * 
	 * @param nppmProdLabelKey the nppmProdLabelKey to set
	 */
	public void setNppmProdLabelKey(final Long nppmProdLabelKey) {
		this.nppmProdLabelKey = nppmProdLabelKey;
	}

}
