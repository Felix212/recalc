package com.lsgskychefs.cbase.middleware.citp.common.pojo;

/**
 * Counter class for counting the class of the flights
 *
 * @author U185502
 */
public class CounterObject {

    // initialise flight key
    private Long flightKey;

    // initialise first class counter
    private int firstClassCounter;

    // initialise business class counter
    private int bizClassCounter;

    // initialise economy class counter
    private int ecoClassCounter;

    // initialise premium economy class counter
    private int premiumEcoClassCounter;

    /*
     * Creates the constructor
     */
    public CounterObject() {
        flightKey = null;
        firstClassCounter = 0;
        bizClassCounter = 0;
        ecoClassCounter = 0;
        premiumEcoClassCounter = 0;
    }

    public Long getFlightKey() {
        return flightKey;
    }

    public void setFlightKey(Long flightKey) {
        this.flightKey = flightKey;
    }

    public int getFirstClassCounter() {
        return firstClassCounter;
    }

    public void setFirstClassCounter(int firstClassCounter) {
        this.firstClassCounter = firstClassCounter;
    }

    public int getBizClassCounter() {
        return bizClassCounter;
    }

    public void setBizClassCounter(int bizClassCounter) {
        this.bizClassCounter = bizClassCounter;
    }

    public int getEcoClassCounter() {
        return ecoClassCounter;
    }

    public void setEcoClassCounter(int ecoClassCounter) {
        this.ecoClassCounter = ecoClassCounter;
    }

    public int getPremiumEcoClassCounter() {
        return premiumEcoClassCounter;
    }

    public void setPremiumEcoClassCounter(int premiumEcoClassCounter) {
        this.premiumEcoClassCounter = premiumEcoClassCounter;
    }

    public void incrementMyPremiumEcoClassCounter() {
        this.premiumEcoClassCounter++;
    }

    public void incrementMyEcoClassCounter() {
        this.ecoClassCounter++;
    }

    public void incrementMyBizClassCounter() {
        this.bizClassCounter++;
    }

    public void incrementMyFirstClassCounter() {
        this.firstClassCounter++;
    }

    public void addToMyFirstClassCounter(int aNum) {
        this.firstClassCounter += aNum;
    }

    public void addToMyBizClassCounter(int aNum) {
        this.bizClassCounter += aNum;
    }

    public void addToMyEcoClassCounter(int aNum) {
        this.ecoClassCounter += aNum;
    }

    public void addToMyPremiumEcoClassCounter(int aNum) {
        this.premiumEcoClassCounter += aNum;
    }

    /**
     * Sum the counters of variables
     *
     * @param aNumFirst
     * @param aNumBiz
     * @param aNumPremiumEco
     * @param aNumEco
     */
    public void addToAllCounters(int aNumFirst, int aNumBiz, int aNumPremiumEco, int aNumEco) {
        this.firstClassCounter += aNumFirst;
        this.bizClassCounter += aNumBiz;
        this.premiumEcoClassCounter += aNumPremiumEco;
        this.ecoClassCounter += aNumEco;
    }
}
