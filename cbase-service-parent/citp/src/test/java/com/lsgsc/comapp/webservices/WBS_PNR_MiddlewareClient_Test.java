package com.lsgsc.comapp.webservices;

import com.dlh.zambas.aws.wbspnr.service.PNRService;
import com.dlh.zambas.aws.wbspnr.service.PNRServicePort;
import com.dlh.zambas.aws.wbspnr.wrapper.*;
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

public class WBS_PNR_MiddlewareClient_Test {
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
    public void wbs_PNR_MiddlewareClient() {
        WBS_PNR_MiddlewareClient_Test webservicesClient = new WBS_PNR_MiddlewareClient_Test();

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
        PNRCancel pnrCancel = new PNRCancel();
        ReservationControlInformationType8 value = new ReservationControlInformationType8();
        ReservationControlInformationDetailsTypeI13 reservation = new ReservationControlInformationDetailsTypeI13();
        reservation.setControlNumber("XXXX");
        value.setReservation(reservation);
        pnrCancel.setReservationInfo(value);
        OptionalPNRActionsType2 pnrActions = new OptionalPNRActionsType2();
        int[] optionCode = new int[1];
        optionCode[0] = 1;
        pnrActions.addOptionCode(1);
        pnrCancel.setPnrActions(pnrActions);

        try {
            config = ServiceFactory.getServiceConfiguration(PNRService.class);

            config.setContext(clientContext);
            config.setTransport("https");

            PNRServicePort service = (PNRServicePort) ServiceFactory.getService(config, clientContext);
            PNRReply pnrReply = service.pnrCancel(pnrCancel);
            System.out.println(pnrReply);

        } catch (ClientAPIException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
    }
}
