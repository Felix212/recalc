/*
 * Copyright (c) 2018-2018 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business.barcode;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;

import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareParsingException;
import com.lsgskychefs.cbase.middleware.common.masterdata.business.MasterDataService;

/**
 * SAP Label Barcode [sample] % 0 0 7 % 1 7 0 9 1 8 0 R Y Y 0 3 5 6 1 1
 *
 * @author Heiko Rothenbach U009907
 */
public class SapLabelBarcode extends CbaseMiddlewareBarcode2 {

	@Autowired
	private MasterDataService masterDataService;

	private String cpackinglist;

	@Override
	public void parse(final String barcodeValue) throws CbaseMiddlewareParsingException {
		this.referenceDate = CbaseMiddlewareBarcodeParser.parseDateShort(barcodeValue, 0);
		this.cpackinglist = barcodeValue.substring(6);

		this.nquantity = BigDecimal.valueOf(1);
	}

	/**
	 * @return the cpackinglist
	 */
	public String getCpackinglist() {
		return cpackinglist;
	}

	/**
	 * @param cpackinglist the cpackinglist to set
	 */
	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

}
