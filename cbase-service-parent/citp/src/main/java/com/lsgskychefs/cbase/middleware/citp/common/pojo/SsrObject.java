package com.lsgskychefs.cbase.middleware.citp.common.pojo;

import java.util.List;

import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;

/**
 * Pojo Class for the collection of smpl and seats information
 *
 * @author U185502
 */
public class SsrObject {

    // initialise the list of smpl
    private List<DataLogic> mySpmls;

    // initialise the counter of objects
    private CounterObject myChlds;

    // initialise the list of seats
    private List<DataLogic> mySeats;

    public List<DataLogic> getMySpmls() {
        return mySpmls;
    }

    public void setMySpmls(List<DataLogic> mySpmls) {
        this.mySpmls = mySpmls;
    }

    public CounterObject getMyChlds() {
        return myChlds;
    }

    public void setMyChlds(CounterObject myChlds) {
        this.myChlds = myChlds;
    }

    public List<DataLogic> getMySeats() {
        return mySeats;
    }

    public void setMySeats(List<DataLogic> mySeats) {
        this.mySeats = mySeats;
    }
}
