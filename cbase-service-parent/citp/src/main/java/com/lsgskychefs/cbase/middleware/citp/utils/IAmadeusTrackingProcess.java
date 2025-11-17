package com.lsgskychefs.cbase.middleware.citp.utils;

import com.dlh.zambas.mw.client.Context;

import java.time.LocalDateTime;

/**
 * Interface for tracking Amadeus Services
 *
 * @author U185502
 */
public interface IAmadeusTrackingProcess {

    /**
     * Increments the use count. Use count is only for statistical purposes and perhaps debug purposes.
     */
    void incrementUseCount();

    /**
     * Adjusts last used date, i.e. sets it to current date. As an amadeus connection silently times out we must remember the last used time
     * in order to refresh the connection.
     */
    void adjustLastUsed();

    /**
     * Returns true if the connection has been used more than 9 mins 55 secs ago (Amadeus global timeout is 10 mins and 10 secs).
     */
    boolean hasTimedOut();

    /**
     * Retrieves the time created.
     *
     * @return the creation time
     */
    LocalDateTime getTimeCreated();

    /**
     * Returns the date the amadeus connection was last used.
     *
     * @return last time used
     */
    long getTimeLastUsed();

    /**
     * Returns the use count of the amadeus connection.
     *
     * @return counts the usage
     */
    int getUseCount();

    /**
     * Retrieves the info string
     */
    String getInfoString();

    /**
     * Returns the call idCounter. The call idCounter uniquely identifies the call on middleware side and gets automatically increased by the CAPI.
     * The middleware (EDS) often need the call idCounter in order to be able to find the call in their logs.
     * EDS can provide the mapping of the middleware call idCounter to the Amadeus conversation idCounter
     * For our own purposes the call idCounter is not too useful.
     */
    String getCallId();

    /**
     * Retrieves the clientContext object needed to access the middleware.
     */
    Context getClientContext();

    /**
     * @param context
     */
    void setClientContext(Context context);
}
