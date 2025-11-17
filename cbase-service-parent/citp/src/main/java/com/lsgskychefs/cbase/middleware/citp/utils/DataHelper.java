package com.lsgskychefs.cbase.middleware.citp.utils;

public class DataHelper {

    private DataHelper() {}

    /**
     * fills the values with preceding zeros up to three chars.
     *
     * @param cabinCapacity amount
     * @return amount with preceding zeros
     */
    public static String fillWithZeros(String cabinCapacity) {
        if (cabinCapacity == null) {
            cabinCapacity = "000";
        }
        StringBuilder cabinCapacityBuilder = new StringBuilder(cabinCapacity);
        while (cabinCapacityBuilder.length() < 3) {
            cabinCapacityBuilder.insert(0, "0");
        }
        cabinCapacity = cabinCapacityBuilder.toString();
        return cabinCapacity;
    }
}
