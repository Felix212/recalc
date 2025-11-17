/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Prod Label VPS Barcode [sample] <003>000002001931180420170000000012340000000019
 *
 * @author Alex Schaab - U524036
 */
public class ProdLabelVpsBarcode extends CbaseMiddlewareBarcode2 {

	/** ProdLabel Key */
	private Long nppmProdLabelKey;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		npackinglistIndexKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "npackingListKey", 0, 12);
		referenceDate = CbaseMiddlewareBarcodeParser.parseDate(barcodeValue, 12);
		nppmProdLabelKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nppmProdLabelKey", 20, 32);
		nquantity = CbaseMiddlewareBarcodeParser.parseBigDecimalValue(barcodeValue, "nquantity", 32, 42);
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
