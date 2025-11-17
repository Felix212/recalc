/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.pojo;

import java.util.Date;

/**
 * Data transfer object representing a flight calculation job.
 * Wraps {@link com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlightCalc}
 * with additional computed fields.
 *
 * @author Migration Team
 */
public class FlightCalculationJob {

	private Long jobNr;
	private Long resultKey;
	private Integer function;
	private Integer processStatus;
	private Date ddeparture;
	private String cinstance;
	private String cunit;
	private String cairline;
	private Long nflightNumber;
	private String csuffix;
	private String ctlcFrom;
	private String ctlcTo;
	private Date dstartComputing;
	private Date dstopComputing;
	private Integer nerror;
	private String cerror;

	// Constructors
	public FlightCalculationJob() {
	}

	// Getters and Setters

	public Long getJobNr() {
		return jobNr;
	}

	public void setJobNr(Long jobNr) {
		this.jobNr = jobNr;
	}

	public Long getResultKey() {
		return resultKey;
	}

	public void setResultKey(Long resultKey) {
		this.resultKey = resultKey;
	}

	public Integer getFunction() {
		return function;
	}

	public void setFunction(Integer function) {
		this.function = function;
	}

	public Integer getProcessStatus() {
		return processStatus;
	}

	public void setProcessStatus(Integer processStatus) {
		this.processStatus = processStatus;
	}

	public Date getDdeparture() {
		return ddeparture;
	}

	public void setDdeparture(Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	public String getCinstance() {
		return cinstance;
	}

	public void setCinstance(String cinstance) {
		this.cinstance = cinstance;
	}

	public String getCunit() {
		return cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	public String getCairline() {
		return cairline;
	}

	public void setCairline(String cairline) {
		this.cairline = cairline;
	}

	public Long getNflightNumber() {
		return nflightNumber;
	}

	public void setNflightNumber(Long nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	public String getCsuffix() {
		return csuffix;
	}

	public void setCsuffix(String csuffix) {
		this.csuffix = csuffix;
	}

	public String getCtlcFrom() {
		return ctlcFrom;
	}

	public void setCtlcFrom(String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	public String getCtlcTo() {
		return ctlcTo;
	}

	public void setCtlcTo(String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	public Date getDstartComputing() {
		return dstartComputing;
	}

	public void setDstartComputing(Date dstartComputing) {
		this.dstartComputing = dstartComputing;
	}

	public Date getDstopComputing() {
		return dstopComputing;
	}

	public void setDstopComputing(Date dstopComputing) {
		this.dstopComputing = dstopComputing;
	}

	public Integer getNerror() {
		return nerror;
	}

	public void setNerror(Integer nerror) {
		this.nerror = nerror;
	}

	public String getCerror() {
		return cerror;
	}

	public void setCerror(String cerror) {
		this.cerror = cerror;
	}

	/**
	 * Get flight identifier string.
	 * Format: "LH123A/2025-11-17/FRA-MUC/UNIT0001(12345)"
	 *
	 * @return Flight identifier
	 */
	public String getFlightIdentifier() {
		return String.format("%s%d%s/%s/%s-%s/%s(%d)",
				cairline != null ? cairline : "",
				nflightNumber != null ? nflightNumber : 0,
				csuffix != null ? csuffix : "",
				ddeparture != null ? ddeparture.toString() : "",
				ctlcFrom != null ? ctlcFrom : "",
				ctlcTo != null ? ctlcTo : "",
				cunit != null ? cunit : "",
				resultKey != null ? resultKey : 0);
	}

	@Override
	public String toString() {
		return "FlightCalculationJob{" +
				"jobNr=" + jobNr +
				", resultKey=" + resultKey +
				", function=" + function +
				", processStatus=" + processStatus +
				", flightId='" + getFlightIdentifier() + '\'' +
				'}';
	}
}
