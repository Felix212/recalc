/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.report;

/**
 * Report types for crystal reports
 *
 * @author Ingo Rietzschel - U125742
 */
public enum ReportType {

	/** PDF report. */
	PDF(0),
	/** Excel report. */
	XLS(4);

	/** subfunction value */
	private int subfunction;

	ReportType(final int subfunction) {
		this.subfunction = subfunction;
	}

	/**
	 * Get subfunction
	 *
	 * @return the subfunction
	 */
	public int getSubfunction() {
		return subfunction;
	}
}
