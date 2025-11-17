/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.dto;

import com.lsgskychefs.cbase.middleware.persistence.domain.*;

import java.util.Date;
import java.util.List;

/**
 * Context object containing all data needed for meal calculation.
 *
 * <p>PowerBuilder equivalent: s_change_flight structure
 *
 * <p>This object is passed between services and accumulates all
 * information needed for the complete meal explosion process.
 *
 * @author Migration Team
 */
public class MealCalculationContext {

	// Flight information
	private CenOutPpmFlights flight;
	private Long resultKey;
	private Long airlineKey;
	private Long aircraftKey;
	private Long routingDetailKey;
	private Long rotationKey;
	private Date departureDate;
	private String departureTime;

	// PAX data
	private List<CenOutPax> paxData;
	private List<CenOutPax> priorPaxData;

	// SPML data
	private List<CenOutSpml> spmlData;
	private List<CenOutSpml> priorSpmlData;

	// Current meal state
	private List<CenOutMeals> currentMeals;
	private List<CenOutMeals> priorMeals;

	// Current handling state
	private List<CenOutHandling> currentHandling;
	private List<CenOutHandling> priorHandling;

	// Calculated results
	private List<CenOutMeals> newMeals;
	private List<CenOutHandling> newHandling;

	// Configuration
	private boolean forceRecalculation;
	private boolean calculateMeals;
	private boolean calculateExtra;
	private boolean calculateHandling;
	private Long transactionKey;

	// Processing flags
	private boolean success;
	private String errorMessage;

	public MealCalculationContext() {
		this.success = true;
		this.calculateMeals = true;
		this.calculateExtra = true;
		this.calculateHandling = true;
	}

	// Getters and Setters

	public CenOutPpmFlights getFlight() {
		return flight;
	}

	public void setFlight(CenOutPpmFlights flight) {
		this.flight = flight;
		if (flight != null) {
			this.resultKey = flight.getId().getNresultKey();
		}
	}

	public Long getResultKey() {
		return resultKey;
	}

	public void setResultKey(Long resultKey) {
		this.resultKey = resultKey;
	}

	public Long getAirlineKey() {
		return airlineKey;
	}

	public void setAirlineKey(Long airlineKey) {
		this.airlineKey = airlineKey;
	}

	public Long getAircraftKey() {
		return aircraftKey;
	}

	public void setAircraftKey(Long aircraftKey) {
		this.aircraftKey = aircraftKey;
	}

	public Long getRoutingDetailKey() {
		return routingDetailKey;
	}

	public void setRoutingDetailKey(Long routingDetailKey) {
		this.routingDetailKey = routingDetailKey;
	}

	public Long getRotationKey() {
		return rotationKey;
	}

	public void setRotationKey(Long rotationKey) {
		this.rotationKey = rotationKey;
	}

	public Date getDepartureDate() {
		return departureDate;
	}

	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
	}

	public String getDepartureTime() {
		return departureTime;
	}

	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}

	public List<CenOutPax> getPaxData() {
		return paxData;
	}

	public void setPaxData(List<CenOutPax> paxData) {
		this.paxData = paxData;
	}

	public List<CenOutPax> getPriorPaxData() {
		return priorPaxData;
	}

	public void setPriorPaxData(List<CenOutPax> priorPaxData) {
		this.priorPaxData = priorPaxData;
	}

	public List<CenOutSpml> getSpmlData() {
		return spmlData;
	}

	public void setSpmlData(List<CenOutSpml> spmlData) {
		this.spmlData = spmlData;
	}

	public List<CenOutSpml> getPriorSpmlData() {
		return priorSpmlData;
	}

	public void setPriorSpmlData(List<CenOutSpml> priorSpmlData) {
		this.priorSpmlData = priorSpmlData;
	}

	public List<CenOutMeals> getCurrentMeals() {
		return currentMeals;
	}

	public void setCurrentMeals(List<CenOutMeals> currentMeals) {
		this.currentMeals = currentMeals;
	}

	public List<CenOutMeals> getPriorMeals() {
		return priorMeals;
	}

	public void setPriorMeals(List<CenOutMeals> priorMeals) {
		this.priorMeals = priorMeals;
	}

	public List<CenOutHandling> getCurrentHandling() {
		return currentHandling;
	}

	public void setCurrentHandling(List<CenOutHandling> currentHandling) {
		this.currentHandling = currentHandling;
	}

	public List<CenOutHandling> getPriorHandling() {
		return priorHandling;
	}

	public void setPriorHandling(List<CenOutHandling> priorHandling) {
		this.priorHandling = priorHandling;
	}

	public List<CenOutMeals> getNewMeals() {
		return newMeals;
	}

	public void setNewMeals(List<CenOutMeals> newMeals) {
		this.newMeals = newMeals;
	}

	public List<CenOutHandling> getNewHandling() {
		return newHandling;
	}

	public void setNewHandling(List<CenOutHandling> newHandling) {
		this.newHandling = newHandling;
	}

	public boolean isForceRecalculation() {
		return forceRecalculation;
	}

	public void setForceRecalculation(boolean forceRecalculation) {
		this.forceRecalculation = forceRecalculation;
	}

	public boolean isCalculateMeals() {
		return calculateMeals;
	}

	public void setCalculateMeals(boolean calculateMeals) {
		this.calculateMeals = calculateMeals;
	}

	public boolean isCalculateExtra() {
		return calculateExtra;
	}

	public void setCalculateExtra(boolean calculateExtra) {
		this.calculateExtra = calculateExtra;
	}

	public boolean isCalculateHandling() {
		return calculateHandling;
	}

	public void setCalculateHandling(boolean calculateHandling) {
		this.calculateHandling = calculateHandling;
	}

	public Long getTransactionKey() {
		return transactionKey;
	}

	public void setTransactionKey(Long transactionKey) {
		this.transactionKey = transactionKey;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
		this.success = false;
	}
}
