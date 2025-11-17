/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;

/**
 * Chiller Bin Label Barcode [sample] < 0 0 8 > 1 2 3 4 5 6 7 8 9 0 1 2
 *
 * @author Paola Lera - U116198
 */
public class ChillerBinLabelBarcode extends CbaseMiddlewareBarcode2 {
	
	private Long nstorageBinKey;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		this.nstorageBinKey = CbaseMiddlewareBarcodeParser.parseLongValue(barcodeValue, "nstorageBinKey", 0, 12);
	}

	/**
	 * Get nstorageBinKey
	 * 
	 * @return the nstorageBinKey
	 */
	public Long getNstorageBinKey() {
		return nstorageBinKey;
	}

	/**
	 * Set nstorageBinKey
	 * 
	 * @param nstorageBinKey the nstorageBinKey to set
	 */
	public void setNstorageBinKey(final Long nstorageBinKey) {
		this.nstorageBinKey = nstorageBinKey;
	}

}
