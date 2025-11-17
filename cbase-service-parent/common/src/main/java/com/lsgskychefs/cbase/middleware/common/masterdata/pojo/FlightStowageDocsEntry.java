/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.masterdata.pojo;

import javax.persistence.Transient;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenCateringUoPdf;
import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Contains the values for native query 'flight-stowage-docs-query.sql'.
 *
 * @author Ingo Rietzschel - U125742
 */
public class FlightStowageDocsEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** nprio */
	private int nprio;

	/** ccateringUoName */
	private String ccateringUoName;

	/** ncateringUserobjectId */
	private long ncateringUserobjectId;

	/** The domain object wich contains the pdf file */
	private CenCateringUoPdf pdf;

	/**
	 * Get nprio
	 *
	 * @return the nprio
	 */
	public int getNprio() {
		return nprio;
	}

	/**
	 * set nprio
	 *
	 * @param nprio the nprio to set
	 */
	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	/**
	 * Get ccateringUoName
	 *
	 * @return the ccateringUoName
	 */
	public String getCcateringUoName() {
		return ccateringUoName;
	}

	/**
	 * set ccateringUoName
	 *
	 * @param ccateringUoName the ccateringUoName to set
	 */
	public void setCcateringUoName(final String ccateringUoName) {
		this.ccateringUoName = ccateringUoName;
	}

	/**
	 * Get ncateringUserobjectId
	 *
	 * @return the ncateringUserobjectId
	 */
	public long getNcateringUserobjectId() {
		return ncateringUserobjectId;
	}

	/**
	 * set ncateringUserobjectId
	 *
	 * @param ncateringUserobjectId the ncateringUserobjectId to set
	 */
	public void setNcateringUserobjectId(final long ncateringUserobjectId) {
		this.ncateringUserobjectId = ncateringUserobjectId;
	}

	/**
	 * Get pdf
	 *
	 * @return the pdf
	 */
	@Transient
	public CenCateringUoPdf getPdf() {
		return pdf;
	}

	/**
	 * set pdf
	 *
	 * @param pdf the pdf to set
	 */
	public void setPdf(final CenCateringUoPdf pdf) {
		this.pdf = pdf;
	}

}
