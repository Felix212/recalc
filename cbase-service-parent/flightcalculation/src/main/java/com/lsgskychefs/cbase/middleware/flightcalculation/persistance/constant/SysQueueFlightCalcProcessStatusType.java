package com.lsgskychefs.cbase.middleware.flightcalculation.persistance.constant;

import java.util.HashMap;
import java.util.Map;

/**
 * All SysQueueFlightCalc process status types.
 *
 * @author Dirk Bunk - U200035
 */
public enum SysQueueFlightCalcProcessStatusType {
    /** -1 - so far unknown process status type */
    UNKNOWN(-1, "Unknown"),

    /** 0 - Open */
    OPEN(0, "Open"),

    /** 1 - Assigned */
    ASSIGNED(1, "Assigned"),

    /** 2 - Started */
    STARTED(2, "Started"),

    /** 3 - Done */
    DONE(3, "Done"),

    /** 8 - Duplicated */
    DUPLICATED(8, "Duplicated"),

    /** 9 - Failed */
    FAILED(9, "Failed");

    /** Contains mapping between the state integer value and {@link SysQueueFlightCalcProcessStatusType} */
    private static Map<Integer, SysQueueFlightCalcProcessStatusType> map;

    static {
        map = new HashMap<>();
        for (final SysQueueFlightCalcProcessStatusType label : SysQueueFlightCalcProcessStatusType.values()) {
            map.put(label.typeNumber, label);
        }
    }

    /** The value for the type. Is used in DB. */
    private int typeNumber;

    /** The state description */
    private String description;

    SysQueueFlightCalcProcessStatusType(final int typeNumber, final String description) {
        this.typeNumber = typeNumber;
        this.description = description;
    }

    /**
     * The value from current type. Is used in DB.
     *
     * @return the state value
     */
    public int getTypeValue() {
        return typeNumber;
    }

    /**
     * Get description
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Get the corresponding CbaseReckoningType.
     *
     * @param typeNumber type value
     * @return the corresponding CbaseReckoningType.
     */
    public static SysQueueFlightCalcProcessStatusType getEnum(final int typeNumber) {
        final SysQueueFlightCalcProcessStatusType value = map.get(typeNumber);
        return value == null ? SysQueueFlightCalcProcessStatusType.UNKNOWN : value;
    }
}
