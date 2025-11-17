package com.lsgskychefs.cbase.middleware.citp.common.request;

public interface RequestOutLogic extends RequestLogic {

    int FUNCTION_SET_CATERING_FIGURES_PAX_ONLY = 0;
    int FUNCTION_SET_CATERING_FIGURES_PAX_AND_COMMENT = 1;
    int FUNCTION_SET_CATERING_FIGURES_COMMENT_ONLY = 2; //not possible, because ZR6 always requires PAX data!

    String UNIT_QUALIFIER_CATERING_FIGURES = "CAT";
    String FREE_TEXT_INFORMATION_ENCODING = "3";
    String FREE_TEXT_INFORMATION_SOURCE = "A";
    String FREE_TEXT_INFORMATION_TEXTSUBJECTQUALIFIER = "1";

}