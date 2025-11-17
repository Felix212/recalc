package com.lsgsc.comapp.webservices;

import com.dlh.zambas.aws.wbsunifiedsecurity.service.WbsUnifiedSecurityService;
import com.dlh.zambas.aws.wbsunifiedsecurity.service.WbsUnifiedSecurityServicePort;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.Authenticate;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.AuthenticateResponse;
import com.dlh.zambas.mw.client.Context;
import com.dlh.zambas.mw.client.ServiceFactory;
import com.dlh.zambas.mw.client.configuration.ServiceConfiguration;
import com.dlh.zambas.mw.client.exception.ClientAPIException;
import com.dlh.zambas.mw.exception.MiddlewareException;
import com.dlh.zambas.udh.cpprofileservice.service.CustomerProfileProfileService;
import com.dlh.zambas.udh.cpprofileservice.service.CustomerProfileProfileServicePort;
import com.dlh.zambas.udh.cpprofileservice.wrapper.*;
import org.junit.Test;

import java.net.ConnectException;
import java.rmi.RemoteException;
import java.util.TimeZone;

import static org.junit.Assert.assertNotNull;

public class ThirdParty_CPProfileServiceCall_UnifiedSecurity_Test {

    // client context holds all client related data.
    private Context clientContext = null;

    // Authenticate object for MDW auth.
    private Authenticate authenticate = null;

    // security service interface exposed by 1A
    private WbsUnifiedSecurityServicePort securityService = null;

    // MDW Sec Token object
    private AuthenticateResponse authResponse = null;
    String xmloutput = null;

    /*
     * setup the client context. It picks up details from
     * resources/config/clientapi.properties so make sure your properties file
     * has correct details
     */
    private void setupClientContext() {

        try {
            System.out.println("----------------Calling clientContext----------------");
            clientContext = ServiceFactory.createContext();

            assertNotNull("The client context is not null", clientContext);
            // clientContext.setApplicationID("TEST_APP");
            // clientContext.setCallerID("BLRD40950");
            // clientContext.setCustomerID("LH");
            System.out.println("-------------------------Successfully called clientContext------------------");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*
     * Security service call needs to be made to authenticate with LHMDW (LH
     * system) and get MDW Security Token
     */
    private void callSecurityService(String user, String pass) {

        try {
            String securityToken = null;
            String securityTokenValidity = null;
            System.out.println("-------------------------Now calling callSecurityService------------------");

            // Setting the ServiceConfiguration
            ServiceConfiguration servConfig = ServiceFactory.getServiceConfiguration(WbsUnifiedSecurityService.class);
            // create SecurityService object
            securityService = (WbsUnifiedSecurityServicePort) ServiceFactory.getService(servConfig, clientContext);

            assertNotNull("Verify that the security Service is not NULL", securityService);

            // Create Authenticate object
            authenticate = new Authenticate();

            // Add correct username defined in Desmon for your application.
            authenticate.setUserID(user);

            // Add correct password defined in Desmon for your application.
            authenticate.setPassword(pass);

            // Get the MDW Security Token for the user
            authResponse = securityService.authenticate(authenticate);

            assertNotNull("Verify that the response is not NULL", authResponse);

            securityToken = authResponse.getSecurityToken();
            securityTokenValidity = authResponse.getTokenValidity();

            // setting the MDW Security Token in client context
//            clientContext.setSecurityToken(securityToken);
//            clientContext.setSecurityTokenValidity(securityTokenValidity);
            System.out.println("-------------------------Successfully called callSecurityService------------------");
        } catch (ClientAPIException | RemoteException | MiddlewareException e) {
            e.printStackTrace();
        }
    }

    /*
     * 3rd Party Functional call.
     */
    private void callCPAuthenticationService() {

        try {

            System.out.println("-------------------------Now calling CPProfile Service------------------");

            // Initialising ServiceConfig object for CPProfile Service
            ServiceConfiguration config = ServiceFactory.getServiceConfiguration(CustomerProfileProfileService.class);
            config.setContext(clientContext);

            // Initialising CPAuthenticationService object
            CustomerProfileProfileServicePort service = (CustomerProfileProfileServicePort) ServiceFactory
                    .getService(config, clientContext);

            // Make the request
            RetrieveProfileRequest retrieveProfileRequest = new RetrieveProfileRequest();
            retrieveProfileRequest.setTenant(Tenant.LH);
            retrieveProfileRequest.setOriginatingSystem("Test Client");
            retrieveProfileRequest.setClientIP("123.213");
            retrieveProfileRequest.setCorrelationID("QWEA");
            retrieveProfileRequest.setSsoToken("LP123");
            AgentAuthorization agAuth = new AgentAuthorization();
            agAuth.setDesmonX509Cert("1239+");
            agAuth.setAgentPin("2");
            retrieveProfileRequest.setAgentAuthorization(agAuth);
            retrieveProfileRequest.getUcid().add("12321");
            retrieveProfileRequest.setProfileType(ProfileType.COMPANY);
            retrieveProfileRequest.getDataSets().add(CustomerProfileDataSets.GENERAL_DETAILS);

            // Send the request
            RetrieveProfileResponse response = service.retrieveProfile(retrieveProfileRequest);
            System.out.println(response);

            System.out.println("-------------------------Successfully called CPProfile Service------------------");
        } catch (ClientAPIException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*
     * Main class: The execution order needs to be followed.
     */
    @Test(expected = ConnectException.class)
    public void thirdPartyCPPorfileServiceCall_UnifiedService() {
        TimeZone t = TimeZone.getDefault();
        t.setRawOffset(0);
        System.setProperty("user.timezone", t.getDisplayName());
        ThirdParty_CPProfileServiceCall_UnifiedSecurity_Test cpProfService = new ThirdParty_CPProfileServiceCall_UnifiedSecurity_Test();

        /*
         * 1. setup the client context.
         */
        cpProfService.setupClientContext();

        /*
         * 2. Make a security call.
         */
        cpProfService.callSecurityService("XXXX", "XXXX");

        /*
         * 3. Make a 3rd Party service/functional call
         */
        cpProfService.callCPAuthenticationService();

    }
}
