package com.lsgsc.comapp.webservices;

import com.dlh.zambas.aws.wbsdcsbrd.service.DCSBRDService;
import com.dlh.zambas.aws.wbsdcsbrd.service.DCSBRDServicePort;
import com.dlh.zambas.aws.wbsdcsbrd.wrapper.*;
import com.dlh.zambas.aws.wbsdcsbrd.wrapper.DCSBRDSetBoardingLocation.BoardingGate;
import com.dlh.zambas.mw.client.Context;
import com.dlh.zambas.mw.client.ServiceFactory;
import com.dlh.zambas.mw.client.configuration.ServiceConfiguration;
import com.dlh.zambas.mw.client.headers.model.SecuritySOAPHeadersBean;
import com.dlh.zambas.mw.client.nextGen.headerHandler.security.header.AMASecurityHostedUser;
import org.junit.Test;

import java.lang.reflect.UndeclaredThrowableException;

public class WBS_DCSBRD_MiddlewareClient_Test {

    // client context holds all client related data.
    private Context clientContext = null;

    @Test(expected = UndeclaredThrowableException.class)
    public void wbs_DCSBRD_MiddlewareClient() {
        WBS_DCSBRD_MiddlewareClient_Test webservicesClient = new WBS_DCSBRD_MiddlewareClient_Test();

        /**
         * 1. setup the client context.
         */
        webservicesClient.setupClientContext();


        webservicesClient.callWebService();

        /**
         * 4. close the session/conversation with Amadeus systems.
         */
        webservicesClient.closeSession();

    }

    private void closeSession() {
        // TODO Auto-generated method stub

    }

    private void callWebService() {
        ServiceConfiguration config = null;
        try {
//		DCSBRDServicePort brdService = (DCSBRDServicePort)ServiceFactory.getService(DCSBRDService.class);

            // Initialising DCSBRDService object
            DCSBRDSetBoardingLocation brdReq = new DCSBRDSetBoardingLocation();

            BoardingGate brdgate = new BoardingGate();
            ActionIdentificationTypeI actionId = new ActionIdentificationTypeI();
            actionId.setActionRequestCode("AD");
            brdgate.setIndicator(actionId);

            TerminalLocationType2 tlLocation2 = new TerminalLocationType2();

            FacilityInformationType2 fcInfoType2 = new FacilityInformationType2();
            fcInfoType2.setFacilityType("GTE");
            fcInfoType2.setFacilityId("4");

//            tlLocation2.setInitFacilityInformation(0, fcInfoType2);

//			tlLocation2.setInitFacilityInformation(0, fcInfoType2);

            FlightDetailsResponseType2 fltDtlResType2 = new FlightDetailsResponseType2();
            OutboundCarrierDetailsTypeI2 outCarDtlType12 = new OutboundCarrierDetailsTypeI2();
            outCarDtlType12.setMarketingCarrier("LH");
            OutboundFlightNumberDetailstypeI2 outFltNoDtlType2 = new OutboundFlightNumberDetailstypeI2();
            outFltNoDtlType2.setFlightNumber("4809");


            fltDtlResType2.setCarrierDetails(outCarDtlType12);
            fltDtlResType2.setFlightDetails(outFltNoDtlType2);
            fltDtlResType2.setDepartureDate("16072018");
            fltDtlResType2.setBoardPoint("MUC");
            fltDtlResType2.setOffPoint("PVG");

//			BoardingGate brdgateInner = new BoardingGate();
            brdgate.setBoardingGate(tlLocation2);

            brdReq.addBoardingGate(brdgate);
            brdReq.setFlightId(fltDtlResType2);

//			brdReq.setInitBoardingGate(1, brdgate);

            // Initialising ServiceConfig object for DCSBRD Service
            config = ServiceFactory.getServiceConfiguration(DCSBRDService.class);

            config.setContext(clientContext);

            config.setTransport("https");
//			ServiceFactory.getService(config, clientContext)
//			DCSBRDServicePort brdService = (DCSBRDServicePort)ServiceFactory.getService(DCSBRDService.class, clientContext);

            // Create DCSBRDService Object
            DCSBRDServicePort brdService = (DCSBRDServicePort)ServiceFactory.getService(config, clientContext);

            // Send the request
            //service call
            DCSBRDSetBoardingLocationReply reply = brdService.dcsbrdSetBoardingLocation(brdReq);

            //service call for checking Subsequent service call
//			reply = brdService.dcsbrdSetBoardingLocation(brdReq);
        } catch(Exception ex) {
            ex.printStackTrace();
        }

    }

    private void setupClientContext() {

        try {

            clientContext = ServiceFactory.createContext();
            SecuritySOAPHeadersBean securityHeaders = new SecuritySOAPHeadersBean();
            securityHeaders.setUsername("CBASE");
            securityHeaders.setPassword("dFrU426p");
            securityHeaders.setIsStateful(Boolean.TRUE);
            securityHeaders.setIsHumanUser(Boolean.FALSE);

            AMASecurityHostedUser amaSecUser = new AMASecurityHostedUser();
            amaSecUser.getUserID().setAgentDutyCode("GS");
            amaSecUser.getUserID().setPseudoCityCode("XXXXXXX");
            amaSecUser.getUserID().setRequestorType("XX");
            amaSecUser.getUserID().setPOSType("XX");

            securityHeaders.setAmaSecHostUser(amaSecUser);

            clientContext.setSecurityHeaders(securityHeaders);
        } catch (Exception e) {
            e.getMessage();
        }
    }

}
