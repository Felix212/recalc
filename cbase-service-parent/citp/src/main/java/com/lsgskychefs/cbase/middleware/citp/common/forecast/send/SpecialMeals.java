package com.lsgskychefs.cbase.middleware.citp.common.forecast.send;

import java.io.Serializable;
import java.util.List;

/**
 * @author
 */
public class SpecialMeals implements Serializable {
    private static final long serialVersionUID = 1L;

    /** first */
    private List<InfoSpml> first;

    /** business */
    private List<InfoSpml> business;

    /** premiumeco */
    private List<InfoSpml> premiumeco;

    /** eco */
    private List<InfoSpml> eco;

    /**
     * Get first
     *
     * @return the first
     */
    public List<InfoSpml> getFirst() {
        return first;
    }

    /**
     * set first
     *
     * @param first the first to set
     */
    public void setFirst(final List<InfoSpml> first) {
        this.first = first;
    }

    /**
     * Get business
     *
     * @return the business
     */
    public List<InfoSpml> getBusiness() {
        return business;
    }

    /**
     * set business
     *
     * @param business the business to set
     */
    public void setBusiness(final List<InfoSpml> business) {
        this.business = business;
    }

    /**
     * Get premiumeco
     *
     * @return the premiumeco
     */
    public List<InfoSpml> getPremiumeco() {
        return premiumeco;
    }

    /**
     * set premiumeco
     *
     * @param premiumeco the premiumeco to set
     */
    public void setPremiumeco(final List<InfoSpml> premiumeco) {
        this.premiumeco = premiumeco;
    }

    /**
     * Get eco
     *
     * @return the eco
     */
    public List<InfoSpml> getEco() {
        return eco;
    }

    /**
     * set eco
     *
     * @param eco the eco to set
     */
    public void setEco(final List<InfoSpml> eco) {
        this.eco = eco;
    }

}
