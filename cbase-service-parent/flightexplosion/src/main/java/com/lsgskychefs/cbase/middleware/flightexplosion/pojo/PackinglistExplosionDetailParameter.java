/*
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightexplosion.pojo;

import java.util.Date;
import java.util.List;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddelwareParameter;

/**
 * Parameter object for packinglist explosion details
 *
 * @author Dirk Bunk - U200035
 */
public class PackinglistExplosionDetailParameter extends AbstractPojo implements CbaseMiddelwareParameter {

	private List<Long> indexKeys;

	private long resultKey;

	private long airlineKey;

	private Date refDate;

	private String csc;

	private Date calcDate;

	private String calcTime;

	private int isoOffset;

	private boolean checkBoardingUnit;

	/**
	 * Get indexKeys
	 *
	 * @return the indexKeys
	 */
	public List<Long> getIndexKeys() {
		return indexKeys;
	}

	/**
	 * set indexKeys
	 *
	 * @param indexKeys the indexKeys to set
	 */
	public void setIndexKeys(final List<Long> indexKeys) {
		this.indexKeys = indexKeys;
	}

	/**
	 * Get resultKey
	 *
	 * @return the resultKey
	 */
	public long getResultKey() {
		return resultKey;
	}

	/**
	 * set resultKey
	 *
	 * @param resultKey the resultKey to set
	 */
	public void setResultKey(final long resultKey) {
		this.resultKey = resultKey;
	}

	/**
	 * Get airlineKey
	 *
	 * @return the airlineKey
	 */
	public long getAirlineKey() {
		return airlineKey;
	}

	/**
	 * set airlineKey
	 *
	 * @param airlineKey the airlineKey to set
	 */
	public void setAirlineKey(final long airlineKey) {
		this.airlineKey = airlineKey;
	}

	/**
	 * Get refDate
	 *
	 * @return the refDate
	 */
	public Date getRefDate() {
		return refDate;
	}

	/**
	 * set refDate
	 *
	 * @param refDate the refDate to set
	 */
	public void setRefDate(final Date refDate) {
		this.refDate = refDate;
	}

	/**
	 * Get csc
	 *
	 * @return the csc
	 */
	public String getCsc() {
		return csc;
	}

	/**
	 * set csc
	 *
	 * @param csc the csc to set
	 */
	public void setCsc(final String csc) {
		this.csc = csc;
	}

	/**
	 * Get calcDate
	 *
	 * @return the calcDate
	 */
	public Date getCalcDate() {
		return calcDate;
	}

	/**
	 * set calcDate
	 *
	 * @param calcDate the calcDate to set
	 */
	public void setCalcDate(final Date calcDate) {
		this.calcDate = calcDate;
	}

	/**
	 * Get calcTime
	 *
	 * @return the calcTime
	 */
	public String getCalcTime() {
		return calcTime;
	}

	/**
	 * set calcTime
	 *
	 * @param calcTime the calcTime to set
	 */
	public void setCalcTime(final String calcTime) {
		this.calcTime = calcTime;
	}

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

	/**
	 * Get checkBoardingUnit
	 *
	 * @return the checkBoardingUnit
	 */
	public boolean isCheckBoardingUnit() {
		return checkBoardingUnit;
	}

	/**
	 * set checkBoardingUnit
	 *
	 * @param checkBoardingUnit the checkBoardingUnit to set
	 */
	public void setCheckBoardingUnit(final boolean checkBoardingUnit) {
		this.checkBoardingUnit = checkBoardingUnit;
	}
}
