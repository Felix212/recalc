/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.dto;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsDetail;

/**
 * Calculation context for PowerBuilder-style meal calculations.
 *
 * <p>Holds all variables needed for the massive switch statement in
 * PowerBuilder uf_calculate() (lines 8598-9691).
 *
 * <p>This replaces scattered PowerBuilder instance variables.
 */
public class CalculationContext {

	// Core calculation inputs
	private int calcId;                    // lCalcID - Calculation type (1-114)
	private int calcBasis;                 // lCalcBasis - Basis for calculation (usually PAX count)
	private int calcBasisVersion;          // il_calcbasis_ver - Version-based calc basis
	private int paxCount;                  // lPax - Passenger count
	private int paxManual;                 // lPaxManual - Manually entered PAX
	private int version;                   // iVersion - Aircraft version/config
	private int percentage;                // iPercentage - Percentage value
	private double value;                  // dcValue - Decimal value for calculations
	private long minValue;                 // lMinValue - Minimum value constraint
	private long maxValue;                 // lMaxValue - Maximum value constraint

	// Component/meal properties
	private int componentGroup;            // iComponentGroup - Component group ID
	private int spmlDeduction;             // iSPMLDeduction - SPML deduction flag (0 or 1)
	private int componentPercentage;       // Component percentage (from CenMealsDetail)

	// SPML-related
	private int spmlCount;                 // lNumberOfSPML - Total SPML count for class
	private int spmlCountGlobal;           // il_spml_count - Global SPML counter
	private int preorderSpmlCount;         // il_preorder_spml_count - Preorder SPML count

	// Reserve/TopOff
	private int reserveQuantity;           // lReserveQuantity - Reserve quantity
	private int reserveType;               // lReserveType - Reserve type (0-3)
	private int topoffQuantity;            // lTopoffQuantity - TopOff quantity
	private int topoffType;                // lTopoffType - TopOff type (0-3)

	// Class information
	private String classCode;              // sClass - Class code (Y, C, F, etc.)
	private int classNumber;               // lClassNumber - Class number
	private boolean bookingClass;          // nbooking_class = 1

	// Flight information
	private long flightNumber;             // il_flgnr - Flight number
	private String suffix;                 // is_suffix - Flight suffix
	private long tlcFrom;                  // il_tlc_from - From station TLC
	private long tlcTo;                    // il_tlc_to - To station TLC

	// Context/mode flags
	private boolean inGeneration;          // bInGeneration - In generation mode
	private boolean inChange;              // bInChange - In change mode
	private boolean inSimulation;          // bInSimulation - In simulation mode
	private boolean calculateConcDiff;     // bCalculateConcDiff - Calculate concession diff

	// Keys
	private long resultKey;                // lResultKey
	private long handlingKey;              // lHandlingKey
	private long handlingDetailKey;        // lHandlingDetailKey
	private long masterKey;                // lMasterKey - nhandling_meal_key
	private long rotationNameKey;          // lRotationNameKey

	// Component detail (for component-level processing)
	private CenMealsDetail component;      // Current component being processed

	// Calculation results
	private double quantity;               // dcQuantity - Calculated quantity
	private double quantityVersion;        // idc_quantity_ver - Version-based quantity

	// Default constructor
	public CalculationContext() {
	}

	// Getters and setters

	public int getCalcId() {
		return calcId;
	}

	public void setCalcId(int calcId) {
		this.calcId = calcId;
	}

	public int getCalcBasis() {
		return calcBasis;
	}

	public void setCalcBasis(int calcBasis) {
		this.calcBasis = calcBasis;
	}

	public int getCalcBasisVersion() {
		return calcBasisVersion;
	}

	public void setCalcBasisVersion(int calcBasisVersion) {
		this.calcBasisVersion = calcBasisVersion;
	}

	public int getPaxCount() {
		return paxCount;
	}

	public void setPaxCount(int paxCount) {
		this.paxCount = paxCount;
	}

	public int getPaxManual() {
		return paxManual;
	}

	public void setPaxManual(int paxManual) {
		this.paxManual = paxManual;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getPercentage() {
		return percentage;
	}

	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public long getMinValue() {
		return minValue;
	}

	public void setMinValue(long minValue) {
		this.minValue = minValue;
	}

	public long getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(long maxValue) {
		this.maxValue = maxValue;
	}

	public int getComponentGroup() {
		return componentGroup;
	}

	public void setComponentGroup(int componentGroup) {
		this.componentGroup = componentGroup;
	}

	public int getSpmlDeduction() {
		return spmlDeduction;
	}

	public void setSpmlDeduction(int spmlDeduction) {
		this.spmlDeduction = spmlDeduction;
	}

	public int getComponentPercentage() {
		return componentPercentage;
	}

	public void setComponentPercentage(int componentPercentage) {
		this.componentPercentage = componentPercentage;
	}

	public int getSpmlCount() {
		return spmlCount;
	}

	public void setSpmlCount(int spmlCount) {
		this.spmlCount = spmlCount;
	}

	public int getSpmlCountGlobal() {
		return spmlCountGlobal;
	}

	public void setSpmlCountGlobal(int spmlCountGlobal) {
		this.spmlCountGlobal = spmlCountGlobal;
	}

	public int getPreorderSpmlCount() {
		return preorderSpmlCount;
	}

	public void setPreorderSpmlCount(int preorderSpmlCount) {
		this.preorderSpmlCount = preorderSpmlCount;
	}

	public int getReserveQuantity() {
		return reserveQuantity;
	}

	public void setReserveQuantity(int reserveQuantity) {
		this.reserveQuantity = reserveQuantity;
	}

	public int getReserveType() {
		return reserveType;
	}

	public void setReserveType(int reserveType) {
		this.reserveType = reserveType;
	}

	public int getTopoffQuantity() {
		return topoffQuantity;
	}

	public void setTopoffQuantity(int topoffQuantity) {
		this.topoffQuantity = topoffQuantity;
	}

	public int getTopoffType() {
		return topoffType;
	}

	public void setTopoffType(int topoffType) {
		this.topoffType = topoffType;
	}

	public String getClassCode() {
		return classCode;
	}

	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}

	public int getClassNumber() {
		return classNumber;
	}

	public void setClassNumber(int classNumber) {
		this.classNumber = classNumber;
	}

	public boolean isBookingClass() {
		return bookingClass;
	}

	public void setBookingClass(boolean bookingClass) {
		this.bookingClass = bookingClass;
	}

	public long getFlightNumber() {
		return flightNumber;
	}

	public void setFlightNumber(long flightNumber) {
		this.flightNumber = flightNumber;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public long getTlcFrom() {
		return tlcFrom;
	}

	public void setTlcFrom(long tlcFrom) {
		this.tlcFrom = tlcFrom;
	}

	public long getTlcTo() {
		return tlcTo;
	}

	public void setTlcTo(long tlcTo) {
		this.tlcTo = tlcTo;
	}

	public boolean isInGeneration() {
		return inGeneration;
	}

	public void setInGeneration(boolean inGeneration) {
		this.inGeneration = inGeneration;
	}

	public boolean isInChange() {
		return inChange;
	}

	public void setInChange(boolean inChange) {
		this.inChange = inChange;
	}

	public boolean isInSimulation() {
		return inSimulation;
	}

	public void setInSimulation(boolean inSimulation) {
		this.inSimulation = inSimulation;
	}

	public boolean isCalculateConcDiff() {
		return calculateConcDiff;
	}

	public void setCalculateConcDiff(boolean calculateConcDiff) {
		this.calculateConcDiff = calculateConcDiff;
	}

	public long getResultKey() {
		return resultKey;
	}

	public void setResultKey(long resultKey) {
		this.resultKey = resultKey;
	}

	public long getHandlingKey() {
		return handlingKey;
	}

	public void setHandlingKey(long handlingKey) {
		this.handlingKey = handlingKey;
	}

	public long getHandlingDetailKey() {
		return handlingDetailKey;
	}

	public void setHandlingDetailKey(long handlingDetailKey) {
		this.handlingDetailKey = handlingDetailKey;
	}

	public long getMasterKey() {
		return masterKey;
	}

	public void setMasterKey(long masterKey) {
		this.masterKey = masterKey;
	}

	public long getRotationNameKey() {
		return rotationNameKey;
	}

	public void setRotationNameKey(long rotationNameKey) {
		this.rotationNameKey = rotationNameKey;
	}

	public CenMealsDetail getComponent() {
		return component;
	}

	public void setComponent(CenMealsDetail component) {
		this.component = component;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getQuantityVersion() {
		return quantityVersion;
	}

	public void setQuantityVersion(double quantityVersion) {
		this.quantityVersion = quantityVersion;
	}
}
