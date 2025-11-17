package com.lsgsc.comapp.webservices;

import com.dlh.zambas.aws.wbsair.service.AirService;
import com.dlh.zambas.aws.wbsair.service.AirServicePort;
import com.dlh.zambas.aws.wbsair.wrapper.*;
import com.dlh.zambas.aws.wbsair.wrapper.AirMultiAvailability.RequestSection;
import com.dlh.zambas.mw.client.Context;
import com.dlh.zambas.mw.client.ServiceFactory;
import com.dlh.zambas.mw.client.configuration.ServiceConfiguration;
import com.dlh.zambas.mw.client.exception.ClientAPIException;
import com.dlh.zambas.mw.client.headers.model.SecuritySOAPHeadersBean;
import com.dlh.zambas.mw.client.nextGen.headerHandler.security.header.AMASecurityHostedUser;
import com.dlh.zambas.mw.exception.MiddlewareException;
import org.junit.Test;

import java.lang.reflect.UndeclaredThrowableException;
import java.rmi.RemoteException;

public class WBS_AIR_Middleware_Client_Test {
    // client context holds all client related data.
    private Context clientContext = null;
    private ServiceConfiguration config = null;

    private void setupClientContext() {

        try {

            clientContext = ServiceFactory.createContext();
            SecuritySOAPHeadersBean securityHeaders = new SecuritySOAPHeadersBean();
            securityHeaders.setUsername("XXXXXXX");
            securityHeaders.setPassword("XXXXXX");
            securityHeaders.setIsStateful(Boolean.TRUE);
            securityHeaders.setIsHumanUser(Boolean.FALSE);

            AMASecurityHostedUser amaSecUser = new AMASecurityHostedUser();
            amaSecUser.getUserID().setAgentDutyCode("XXX");
            amaSecUser.getUserID().setPseudoCityCode("XXXXXXX");
            amaSecUser.getUserID().setRequestorType("XX");
            amaSecUser.getUserID().setPOSType("XX");

            securityHeaders.setAmaSecHostUser(amaSecUser);

            clientContext.setSecurityHeaders(securityHeaders);
        } catch (Exception e) {
            e.getMessage();
        }
    }

    @Test(expected = UndeclaredThrowableException.class)
    public void wbs_AIR_Middleware_Client() {
        WBS_AIR_Middleware_Client_Test webservicesClient = new WBS_AIR_Middleware_Client_Test();

        /**
         * 1. setup the client context.
         */
        webservicesClient.setupClientContext();

        try {
            webservicesClient.callWebService();
        } catch (RemoteException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MiddlewareException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    private void callWebService() throws RemoteException, MiddlewareException {

        try {

            config = ServiceFactory.getServiceConfiguration(AirService.class);

            AirServicePort service = (AirServicePort) ServiceFactory.getService(config, clientContext);
            AirMultiAvailability airMultiAvailability = new AirMultiAvailability();
            MessageActionDetailsType m = new MessageActionDetailsType();
            MessageFunctionBusinessDetailsType p = new MessageFunctionBusinessDetailsType();
            p.setActionCode("44");
            m.setFunctionDetails(p);
            airMultiAvailability.setMessageActionDetails(m);

            RequestSection arg0 = new RequestSection();
            AvailabilityProductionInfoType arg1 = new AvailabilityProductionInfoType();
            ProductDateTimeType arg2 = new ProductDateTimeType();
            arg2.setDepartureDate("070616");
            arg1.addAvailabilityDetails(arg2);
            arg0.setAvailabilityProductInfo(arg1);

            LocationDetailsType arg3 = new LocationDetailsType();
            arg3.setCityAirport("VLC");
            arg1.setDepartureLocationInfo(arg3);

            arg3.setCityAirport("MUC");
            arg1.setArrivalLocationInfo(arg3);

            AirlineOptionType arg4 = new AirlineOptionType();
            FullFlightIdentificationType arg5 = new FullFlightIdentificationType();
            arg5.setAirlineCode("LH");
            arg4.addFlightIdentification(arg5);
            arg0.addAirlineOrFlightOption(arg4);

            AvailabilityOptionsType arg6 = new AvailabilityOptionsType();
            arg6.setTypeOfRequest("TN");

            arg0.setAvailabilityOptions(arg6);

            airMultiAvailability.addRequestSection(arg0);

            AirMultiAvailabilityReply airReply = service.airMultiAvailability(airMultiAvailability);

        } catch (ClientAPIException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
    }
}
