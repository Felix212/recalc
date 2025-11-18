/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.pojo;

/**
 * Flight calculation function configuration.
 * Wraps {@link com.lsgskychefs.cbase.middleware.persistence.domain.SysQueueFlFunction}
 * with additional helper methods.
 *
 * @author Migration Team
 */
public class FunctionConfiguration {

	private Integer function;
	private String text;
	private String protocolText;
	private Integer internalFunction;
	private Integer queuedReleaseInterface;
	private Integer readFromHistory;
	private Integer paxType;
	private Integer useAsPaxType;
	private Integer statusAfterProcess;
	private Integer statusToProcess;
	private Integer actype;
	private Integer useAsActype;

	// Getters and Setters

	public Integer getFunction() {
		return function;
	}

	public void setFunction(Integer function) {
		this.function = function;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getProtocolText() {
		return protocolText;
	}

	public void setProtocolText(String protocolText) {
		this.protocolText = protocolText;
	}

	public Integer getInternalFunction() {
		return internalFunction;
	}

	public void setInternalFunction(Integer internalFunction) {
		this.internalFunction = internalFunction;
	}

	public Integer getQueuedReleaseInterface() {
		return queuedReleaseInterface;
	}

	public void setQueuedReleaseInterface(Integer queuedReleaseInterface) {
		this.queuedReleaseInterface = queuedReleaseInterface;
	}

	public Integer getReadFromHistory() {
		return readFromHistory;
	}

	public void setReadFromHistory(Integer readFromHistory) {
		this.readFromHistory = readFromHistory;
	}

	public Integer getPaxType() {
		return paxType;
	}

	public void setPaxType(Integer paxType) {
		this.paxType = paxType;
	}

	public Integer getUseAsPaxType() {
		return useAsPaxType;
	}

	public void setUseAsPaxType(Integer useAsPaxType) {
		this.useAsPaxType = useAsPaxType;
	}

	public Integer getStatusAfterProcess() {
		return statusAfterProcess;
	}

	public void setStatusAfterProcess(Integer statusAfterProcess) {
		this.statusAfterProcess = statusAfterProcess;
	}

	public Integer getStatusToProcess() {
		return statusToProcess;
	}

	public void setStatusToProcess(Integer statusToProcess) {
		this.statusToProcess = statusToProcess;
	}

	public Integer getActype() {
		return actype;
	}

	public void setActype(Integer actype) {
		this.actype = actype;
	}

	public Integer getUseAsActype() {
		return useAsActype;
	}

	public void setUseAsActype(Integer useAsActype) {
		this.useAsActype = useAsActype;
	}

	/**
	 * Check if PAX type transfer is needed.
	 *
	 * @return true if PAX fields need to be mapped
	 */
	public boolean requiresPaxTypeTransfer() {
		return paxType != null && useAsPaxType != null &&
				!paxType.equals(useAsPaxType);
	}

	/**
	 * Check if AC type transfer is needed.
	 *
	 * @return true if aircraft version fields need to be mapped
	 */
	public boolean requiresActypeTransfer() {
		return actype != null && useAsActype != null &&
				!actype.equals(useAsActype);
	}

	/**
	 * Check if history should be read.
	 *
	 * @return true if history should be read
	 */
	public boolean shouldReadFromHistory() {
		return readFromHistory != null && readFromHistory == 1;
	}

	@Override
	public String toString() {
		return "FunctionConfiguration{" +
				"function=" + function +
				", internalFunction=" + internalFunction +
				", text='" + text + '\'' +
				'}';
	}
}
