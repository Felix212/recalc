/*
 * Copyright (c) 2015-2017 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Trolley Label Barcode [sample] < 0 0 5 > 0 0 0 0 0 0 0 0 1 4 2 5
 *
 * @author Alex Schaab - U524036
 */
public class TrolleyLabelBarcode extends CbaseMiddlewareBarcode2 {

	/** Trolley Key */
	private Long nppmTrolleyKey;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		this.nppmTrolleyKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nppmTrolleyKey", 0, 12);
	}

	/**
	 * Get nppmTrolleyKey
	 *
	 * @return the nppmTrolleyKey
	 */
	public Long getNppmTrolleyKey() {
		return nppmTrolleyKey;
	}

	/**
	 * Set nppmTrolleyKey
	 * 
	 * @param nppmTrolleyKey the nppmTrolleyKey to set
	 */
	public void setNppmTrolleyKey(final Long nppmTrolleyKey) {
		this.nppmTrolleyKey = nppmTrolleyKey;
	}
}
