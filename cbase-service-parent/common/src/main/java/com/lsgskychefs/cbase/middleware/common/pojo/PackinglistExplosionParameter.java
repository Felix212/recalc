/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.NotNull;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddelwareParameter;

/**
 * Parameter object for packinglist explosions
 *
 * @author Ingo Rietzschel - U125742
 */
public class PackinglistExplosionParameter extends AbstractPojo implements CbaseMiddelwareParameter {

	/** index */
	private long index;

	/** date */
	private Date date;

	/** includeSelf */
	private Integer includeSelf;

	/** csc */
	private String csc;

	/** quantity */
	@NotNull
	private BigDecimal quantity;

	/** billingOnly */
	private Integer billingOnly;

	/** reckoning */
	private Integer reckoning;

	/** time */
	private String time;

	/** With 'Z' IL */
	private Integer withZ = 0;

	/**
	 * Get index
	 *
	 * @return the index
	 */
	public long getIndex() {
		return index;
	}

	/**
	 * set index
	 *
	 * @param index the index to set
	 * @return this
	 */
	public PackinglistExplosionParameter setIndex(final long index) {
		this.index = index;
		return this;
	}

	/**
	 * Get date
	 *
	 * @return the date
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * set date
	 *
	 * @param date the date to set
	 * @return this
	 */
	public PackinglistExplosionParameter setDate(final Date date) {
		this.date = date;
		return this;
	}

	/**
	 * Get includeSelf
	 *
	 * @return the includeSelf
	 */
	public Integer getIncludeSelf() {
		return includeSelf;
	}

	/**
	 * set includeSelf
	 *
	 * @param includeSelf the includeSelf to set
	 * @return this
	 */
	public PackinglistExplosionParameter setIncludeSelf(final Integer includeSelf) {
		this.includeSelf = includeSelf;
		return this;
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
	 * @return this
	 */
	public PackinglistExplosionParameter setCsc(final String csc) {
		this.csc = csc;
		return this;
	}

	/**
	 * Get quantity
	 *
	 * @return the quantity
	 */
	public BigDecimal getQuantity() {
		return quantity;
	}

	/**
	 * set quantity
	 *
	 * @param quantity the quantity to set
	 * @return this
	 */
	public PackinglistExplosionParameter setQuantity(final BigDecimal quantity) {
		this.quantity = quantity;
		return this;
	}

	/**
	 * Get billingOnly
	 *
	 * @return the billingOnly
	 */
	public Integer getBillingOnly() {
		return billingOnly;
	}

	/**
	 * set billingOnly
	 *
	 * @param billingOnly the billingOnly to set
	 * @return this
	 */
	public PackinglistExplosionParameter setBillingOnly(final Integer billingOnly) {
		this.billingOnly = billingOnly;
		return this;
	}

	/**
	 * Get reckoning
	 *
	 * @return the reckoning
	 */
	public Integer getReckoning() {
		return reckoning;
	}

	/**
	 * set reckoning
	 *
	 * @param reckoning the reckoning to set
	 * @return this
	 */
	public PackinglistExplosionParameter setReckoning(final Integer reckoning) {
		this.reckoning = reckoning;
		return this;
	}

	/**
	 * Get time
	 *
	 * @return the time
	 */
	public String getTime() {
		return time;
	}

	/**
	 * set time
	 *
	 * @param time the time to set
	 * @return this
	 */
	public PackinglistExplosionParameter setTime(final String time) {
		this.time = time;
		return this;
	}

	/**
	 * @return withZ
	 */
	public Integer getWithZ() {
		return withZ;
	}

	/**
	 * set withZ
	 * 
	 * @param withZ
	 */
	public void setWithZ(final Integer withZ) {
		this.withZ = withZ;
	}
}
