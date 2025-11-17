/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.report;

/**
 * Report parameter types for crystal reports.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum ReportParameterType {

	/** Long Parameter */
	LONG("long"),
	/** Long Array Parameter */
	LONG_ARRAY("long"),
	/** Date Parameter */
	DATE("date"),
	/** DateTime Parameter */
	DATE_TIME("datetime"),
	/** String Parameter */
	STRING("string"),
	/** String Array Parameter */
	STRING_ARRAY("string"),
	/** Parameter Table Parameter (Long) - Foreign Key to CenReportParameters */
	PARAMETER_TABLE_LONG("long"),
	/** Parameter Table Parameter (String) - Foreign Key to CenReportParameters */
	PARAMETER_TABLE_STRING("long");

	/** the type name for current enum. */
	private String typeName;

	ReportParameterType(final String typeName) {
		this.typeName = typeName;
	}

	/**
	 * Get typeName
	 *
	 * @return the typeName
	 */
	public String getTypeName() {
		return typeName;
	}

}
