/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Tour Label Barcode [sample] < 0 0 9 > 0 0 0 0 0 0 0 0 1 4 5 7
 *
 * @author Kostadin Kostov - U140907
 */
public class TourLabelBarcode extends CbaseMiddlewareBarcode2 {

	/** Tour Key */
	private Long nppmTourKey;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		this.setNppmTourKey(CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nppmTourKey", 0, 12));
	}

	/**
	 * @return the nppmTourKey
	 */
	public Long getNppmTourKey() {
		return nppmTourKey;
	}

	/**
	 * @param nppmTourKey the nppmTourKey to set
	 */
	public void setNppmTourKey(Long nppmTourKey) {
		this.nppmTourKey = nppmTourKey;
	}

}
