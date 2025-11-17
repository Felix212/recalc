package com.lsgskychefs.cbase.middleware.citp.common.forecast.send;

import java.io.Serializable;

public class InfoClass implements Serializable {

    private static final long serialVersionUID = 1L;

    /** first */
    private int first;

    /** business */
    private int business;

    /** premiumeco */
    private int premiumeco;

    /** eco */
    private int eco;

    /**
     * Get first
     *
     * @return the first
     */
    public int getFirst() {
        return first;
    }

    /**
     * set first
     *
     * @param first the first to set
     */
    public void setFirst(final int first) {
        this.first = first;
    }

    /**
     * Get business
     *
     * @return the business
     */
    public int getBusiness() {
        return business;
    }

    /**
     * set business
     *
     * @param business the business to set
     */
    public void setBusiness(final int business) {
        this.business = business;
    }

    /**
     * Get premiumeco
     *
     * @return the premiumeco
     */
    public int getPremiumeco() {
        return premiumeco;
    }

    /**
     * set premiumeco
     *
     * @param premiumeco the premiumeco to set
     */
    public void setPremiumeco(final int premiumeco) {
        this.premiumeco = premiumeco;
    }

    /**
     * Get eco
     *
     * @return the eco
     */
    public int getEco() {
        return eco;
    }

    /**
     * set eco
     *
     * @param eco the eco to set
     */
    public void setEco(final int eco) {
        this.eco = eco;
    }

}
