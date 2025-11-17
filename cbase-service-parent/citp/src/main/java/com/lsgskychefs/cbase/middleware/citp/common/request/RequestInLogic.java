package com.lsgskychefs.cbase.middleware.citp.common.request;

import com.dlh.zambas.aws.wbsinv.wrapper.FlightDetailsQueryType4;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlight;
import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;

public interface RequestInLogic extends RequestLogic {

    FlightDetailsQueryType4 createQuery();

    PNRListPassengersByFlight createSBRListQuery(String aYear, String aMonth, String aDay, CITPCustomProperties citpCustomProperties);
}
