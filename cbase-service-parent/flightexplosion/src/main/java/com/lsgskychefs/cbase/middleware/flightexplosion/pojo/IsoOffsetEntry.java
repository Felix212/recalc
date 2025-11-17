/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.pojo;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query (iso-offset-query.sql)
 *
 * @author Dirk Bunk - U200035
 */
public class IsoOffsetEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	private int isoOffset;

	/**
	 * Get isoOffset
	 *
	 * @return the isoOffset
	 */
	public int getIsoOffset() {
		return isoOffset;
	}

	/**
	 * set isoOffset
	 *
	 * @param isoOffset the isoOffset to set
	 */
	public void setIsoOffset(final int isoOffset) {
		this.isoOffset = isoOffset;
	}
}
