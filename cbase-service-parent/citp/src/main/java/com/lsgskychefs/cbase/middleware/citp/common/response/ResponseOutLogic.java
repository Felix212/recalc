package com.lsgskychefs.cbase.middleware.citp.common.response;

public interface ResponseOutLogic {

    // see 'Codeset for Processing status code (Ref: 9869 1A 01.2.6)' in Amadeus documentation TechRef_DCSFLT_06.2_001.pdf page 105,
    String SET_CATERING_FIGURES_ERROR_OR_WARNING = "N";
    String SET_CATERING_FIGURES_OK = "P";
    String SET_CATERING_FIGURES_ERROR_NON_RECOVERABLE = "X";

}