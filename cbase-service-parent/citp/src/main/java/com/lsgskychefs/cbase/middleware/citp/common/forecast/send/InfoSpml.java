package com.lsgskychefs.cbase.middleware.citp.common.forecast.send;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

public class InfoSpml implements Serializable {

    private static final long serialVersionUID = 1L;

    /** mealCode */
    @JsonProperty("meal_code")
    private String mealCode;

    /** amount */
    private long amount;

    /**
     * Get mealCode
     *
     * @return the mealCode
     */
    public String getMealCode() {
        return mealCode;
    }

    /**
     * set mealCode
     *
     * @param mealCode the mealCode to set
     */
    public void setMealCode(final String mealCode) {
        this.mealCode = mealCode;
    }

    /**
     * Get amount
     *
     * @return the amount
     */
    public long getAmount() {
        return amount;
    }

    /**
     * set amount
     *
     * @param amount the amount to set
     */
    public void setAmount(final long amount) {
        this.amount = amount;
    }

}
