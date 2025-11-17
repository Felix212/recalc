/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.pojo;

/**
 * Result of a flight calculation operation.
 * Contains status and error information.
 *
 * @author Migration Team
 */
public class FlightCalculationResult {

	/**
	 * Result status codes.
	 */
	public enum Status {
		/** Calculation completed successfully */
		SUCCESS(0),
		/** Calculation failed */
		ERROR(-1),
		/** Flight is locked, retry later */
		LOCKED(-10);

		private final int code;

		Status(int code) {
			this.code = code;
		}

		public int getCode() {
			return code;
		}
	}

	private Status status;
	private String errorMessage;
	private String errorMessageShort;
	private String webMessage;
	private Long resultKey;
	private Long jobNr;

	// Constructors

	public FlightCalculationResult() {
		this.status = Status.SUCCESS;
	}

	public FlightCalculationResult(Status status) {
		this.status = status;
	}

	public static FlightCalculationResult success() {
		return new FlightCalculationResult(Status.SUCCESS);
	}

	public static FlightCalculationResult error(String message) {
		FlightCalculationResult result = new FlightCalculationResult(Status.ERROR);
		result.setErrorMessage(message);
		result.setErrorMessageShort(message);
		return result;
	}

	public static FlightCalculationResult locked() {
		return new FlightCalculationResult(Status.LOCKED);
	}

	// Getters and Setters

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getErrorMessageShort() {
		return errorMessageShort;
	}

	public void setErrorMessageShort(String errorMessageShort) {
		this.errorMessageShort = errorMessageShort;
	}

	public String getWebMessage() {
		return webMessage;
	}

	public void setWebMessage(String webMessage) {
		this.webMessage = webMessage;
	}

	public Long getResultKey() {
		return resultKey;
	}

	public void setResultKey(Long resultKey) {
		this.resultKey = resultKey;
	}

	public Long getJobNr() {
		return jobNr;
	}

	public void setJobNr(Long jobNr) {
		this.jobNr = jobNr;
	}

	public boolean isSuccess() {
		return status == Status.SUCCESS;
	}

	public boolean isError() {
		return status == Status.ERROR;
	}

	public boolean isLocked() {
		return status == Status.LOCKED;
	}

	@Override
	public String toString() {
		return "FlightCalculationResult{" +
				"status=" + status +
				", errorMessage='" + errorMessage + '\'' +
				", resultKey=" + resultKey +
				", jobNr=" + jobNr +
				'}';
	}
}
