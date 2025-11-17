/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.pojo;

import java.util.Date;

/**
 * Entry contains the values for on language of SysTranslate.
 *
 * @author Ingo Rietzschel - U125742
 */
public class Translation extends AbstractPojo implements CbaseMiddlewareEntry {

	/** cpurpose */
	private String cpurpose;

	/** language */
	private String clanguage;

	/** nobject */
	private int nobject;

	/** nstatus */
	private Integer nstatus;

	/** cprogramInsert */
	private String cprogramInsert;

	/** dtimestamp */
	private Date dtimestamp;

	/** Constructor */
	public Translation() {
		// default constructor
		super();
	}

	/**
	 * Constructor
	 *
	 * @param cpurpose cpurpose
	 * @param clanguage clanguage
	 */
	public Translation(final String cpurpose, final String clanguage) {
		super();
		this.cpurpose = cpurpose;
		this.clanguage = clanguage;
	}

	/**
	 * Get cpurpose
	 *
	 * @return the cpurpose
	 */
	public String getCpurpose() {
		return cpurpose;
	}

	/**
	 * Get language
	 *
	 * @return the language
	 */
	public String getClanguage() {
		return clanguage;
	}

	/**
	 * Get nobject
	 *
	 * @return the nobject
	 */
	public int getNobject() {
		return nobject;
	}

	/**
	 * Get nstatus
	 *
	 * @return the nstatus
	 */
	public Integer getNstatus() {
		return nstatus;
	}

	/**
	 * Get cprogramInsert
	 *
	 * @return the cprogramInsert
	 */
	public String getCprogramInsert() {
		return cprogramInsert;
	}

	/**
	 * Get dtimestamp
	 *
	 * @return the dtimestamp
	 */
	public Date getDtimestamp() {
		return dtimestamp;
	}
}
