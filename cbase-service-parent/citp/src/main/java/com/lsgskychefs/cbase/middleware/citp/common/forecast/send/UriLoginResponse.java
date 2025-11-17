package com.lsgskychefs.cbase.middleware.citp.common.forecast.send;

import java.io.Serializable;
import java.util.Date;

public class UriLoginResponse implements Serializable {
    private static final long serialVersionUID = 1L;

    /** requiredPasswordChange */
    private boolean requiresPasswordChange;

    /** message */
    private String message;

    /** tokenScheme */
    private String tokenScheme;

    /** token */
    private String token;

    /** refreshToken */
    private String refreshToken;

    /** refreshTokenExpiryDate */
    private Date refreshTokenExpiryDate;

    /**
     * Get requiresPasswordChange
     *
     * @return the requiresPasswordChange
     */
    public boolean isRequiresPasswordChange() {
        return requiresPasswordChange;
    }

    /**
     * set requiresPasswordChange
     *
     * @param requiresPasswordChange the requiresPasswordChange to set
     */
    public void setRequiresPasswordChange(final boolean requiresPasswordChange) {
        this.requiresPasswordChange = requiresPasswordChange;
    }

    /**
     * Get message
     *
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * set message
     *
     * @param message the message to set
     */
    public void setMessage(final String message) {
        this.message = message;
    }

    /**
     * Get tokenScheme
     *
     * @return the tokenScheme
     */
    public String getTokenScheme() {
        return tokenScheme;
    }

    /**
     * set tokenScheme
     *
     * @param tokenScheme the tokenScheme to set
     */
    public void setTokenScheme(final String tokenScheme) {
        this.tokenScheme = tokenScheme;
    }

    /**
     * Get token
     *
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * set token
     *
     * @param token the token to set
     */
    public void setToken(final String token) {
        this.token = token;
    }

    /**
     * Get refreshToken
     *
     * @return the refreshToken
     */
    public String getRefreshToken() {
        return refreshToken;
    }

    /**
     * set refreshToken
     *
     * @param refreshToken the refreshToken to set
     */
    public void setRefreshToken(final String refreshToken) {
        this.refreshToken = refreshToken;
    }

    /**
     * Get refreshTokenExpiryDate
     *
     * @return the refreshTokenExpiryDate
     */
    public Date getRefreshTokenExpiryDate() {
        return refreshTokenExpiryDate;
    }

    /**
     * set refreshTokenExpiryDate
     *
     * @param refreshTokenExpiryDate the refreshTokenExpiryDate to set
     */
    public void setRefreshTokenExpiryDate(final Date refreshTokenExpiryDate) {
        this.refreshTokenExpiryDate = refreshTokenExpiryDate;
    }

}
