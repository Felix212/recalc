package com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.citp.common.pojo.SeatObject;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.DataLogic;

import java.util.ArrayList;
import java.util.List;

/**
 * Representation of a row in the Set
 *
 * @author U185502
 */
public class SeatData implements DataLogic {

    private static final Logger LOGGER = LoggerFactory.getLogger(SeatData.class);

    private Long qpKey;
    private List<SeatObject> seatObjects;

    public SeatData(Long aFlightKey) {

        seatObjects = new ArrayList<>();
        this.qpKey = aFlightKey;
    }

    public void add(SeatObject aSeatObject) {
        if (seatObjects == null) {
            seatObjects = new ArrayList<>();
        }
        seatObjects.add(aSeatObject);
    }
}
