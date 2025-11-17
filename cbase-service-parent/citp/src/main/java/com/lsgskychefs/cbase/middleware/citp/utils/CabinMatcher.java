package com.lsgskychefs.cbase.middleware.citp.utils;

import java.util.regex.Pattern;

public final class CabinMatcher {

    private CabinMatcher() {
    }

    public static String matchCompartment(String aClassOfService) {
        String theCompartment = null;
        if ((aClassOfService != null) && (aClassOfService.length() > 0)) {
            // 03.02.14, Dirk Bunk: Adaptation / extension for Premium Economy
            if (Pattern.matches("[FAO]", aClassOfService)) {
                theCompartment = "F";
            } else if (Pattern.matches("[CDZIRJ]", aClassOfService)) {
                theCompartment = "C";
            } else if (Pattern.matches("[E]", aClassOfService)) {
                theCompartment = "E";
            } else {
                theCompartment = "M";
            }
        }
        return theCompartment;
    }

}
