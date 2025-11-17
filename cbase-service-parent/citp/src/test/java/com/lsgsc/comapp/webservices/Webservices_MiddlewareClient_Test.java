package com.lsgsc.comapp.webservices;

import com.dlh.zambas.mw.client.Context;
import com.dlh.zambas.mw.client.ServiceFactory;
import com.dlh.zambas.mw.client.configuration.ServiceConfiguration;
import com.dlh.zambas.mw.client.exception.ClientAPIException;
import com.dlh.zambas.mw.exception.MiddlewareException;
import com.dlh.zambas.wbs.command.service.CommandService;
import com.dlh.zambas.wbs.command.service.CommandServicesPT;
import com.dlh.zambas.wbs.command.wrapper.CommandCryptic;
import com.dlh.zambas.wbs.command.wrapper.CommandCryptic.MessageAction;
import com.dlh.zambas.wbs.command.wrapper.CommandCryptic.MessageAction.MessageFunctionDetails;
import com.dlh.zambas.wbs.command.wrapper.CommandCrypticReply;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.lsssecurity.*;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.lsssecurity.SecurityTrustedUserSignIn.FullLocation;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.lsssecurity.SecurityTrustedUserSignIn.RoleDataSection;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.lsssecurity.SecurityTrustedUserSignIn.RoleDataSection.RoleData;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.security.*;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.service.WbsCommonSecurityConfidentialService;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.service.WbsCommonSecurityConfidentialServicePort;
import com.dlh.zambas.wbs.wbscommonsecurityconfidential.session.Session;
import org.junit.Test;

import java.net.ConnectException;
import java.rmi.RemoteException;
import java.lang.Exception;

/**
 * Example class for testing purpose calling Amadeus web services
 * */
public class Webservices_MiddlewareClient_Test {

    // client context holds all client related data.
    private Context clientContext = null;

    // the functional Webservice object
    private CommandCryptic cryptic = null;

    // Authenticate object for Desmon auth.
    private DesmonAuthenticate authenticate = null;

    // security service interface exposed by 1A
    private WbsCommonSecurityConfidentialServicePort securityService = null;

    // session object in the functional service.
    private Session session = null;

    /**
     * setup the client context. It picks up details from
     * resources/config/clientapi.properties so make sure your properties file
     * has correct details
     */

    private void setupClientContext() {

        try {

            clientContext = ServiceFactory.createContext();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Security service call needs to be made to authenticate with Desmon (LH
     * system) and get the certificate which will get passed to backend
     */

    private void callSecurityService(String user, String pass) {

        try {
            // create security service object
            securityService = (WbsCommonSecurityConfidentialServicePort) ServiceFactory
                    .getService(WbsCommonSecurityConfidentialService.class,
                            clientContext);

            Authenticate auth = new Authenticate();

            authenticate = new DesmonAuthenticate();
            // put correct username defined in Desmon systems for your
            // application.
            authenticate.setUserId(user);
            // put correct password defined in Desmon systems for your
            // application.
            authenticate.setPassword(pass);
            // set this true/false based on type of user created in Desmon
            // systems robotic/human
            authenticate.setHumanUser(false);
            // Set the Session Pooling to true/false, for Robotic User only.
            // For human user it is always false.
            authenticate.setUseSessionPool(false);

            // Set the authenticate object.
            auth.setDesmonAuthenticate(authenticate);

            // get the desmon certificate for the user
            AuthenticateResponse resp = securityService.authenticate(auth);
            X509CertificateDTO desmonCertificate = resp.getReturn();

            System.out.println("desmonCertificate: "
                    + desmonCertificate.getEncoded());
            // setting the desmon certificate in client context
            clientContext.setDesmonCertifcate(desmonCertificate.getEncoded());

            LSSSignIn signin = new LSSSignIn();
            signin.setSecurityTrustedUserSignIn(getSecurityTrustedUserSignIn());

            session = securityService.lssSignIn(signin).getSession();
            clientContext.setSession(session);

            System.out.println("SecurityToken: " + session.getSecurityToken());

        } catch (ClientAPIException e) {
            e.printStackTrace();
        } catch (RemoteException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /** Create LSS SignIn Request. */

    private static SecurityTrustedUserSignIn getSecurityTrustedUserSignIn() {

        SecurityTrustedUserSignIn secSignIn = new SecurityTrustedUserSignIn();

        UserIdentificationType uIdent = new UserIdentificationType();
        OriginatorIdentificationDetailsType originator = new OriginatorIdentificationDetailsType();
        originator.setInHouseIdentification1("FRALH08CB");

        uIdent.setOriginIdentification(originator);
        uIdent.setOriginator("9000CB");
        uIdent.setOriginatorTypeCode("Z");

        UserIdentificationType uIdent1 = new UserIdentificationType();
        OriginatorIdentificationDetailsType originator1 = new OriginatorIdentificationDetailsType();
        originator1.setInHouseIdentification1("FRALH08CB");

        uIdent1.setOriginIdentification(originator1);
        uIdent1.setOriginator("9000CB");
        uIdent1.setOriginatorTypeCode("Z");

        secSignIn.getUserIdentifier().add(uIdent);
        secSignIn.getUserIdentifier().add(uIdent1);

        SystemDetailsInfoType systemDetails = new SystemDetailsInfoType();

        SystemDetailsTypeI systemDetailType = new SystemDetailsTypeI();
        systemDetailType.setCompanyId("LH");

        systemDetails.setDeliveringSystem(systemDetailType);
        systemDetails.setWorkstationId("0CA/WS3924611");
        systemDetails.setIdQualifier("W");

        secSignIn.setSystemDetails(systemDetails);

        ReferenceInfoType paramReferenceInfoType = new ReferenceInfoType();

        ReferencingDetailsTypeI paramReferencingDetailsTypeI = new ReferencingDetailsTypeI();
        paramReferencingDetailsTypeI.setType("DUT");
        paramReferencingDetailsTypeI.setValue("GS");

        paramReferenceInfoType
                .setReferenceDetails(paramReferencingDetailsTypeI);

        secSignIn.setDutyCode(paramReferenceInfoType);

        RoleDataSection roleType = new RoleDataSection();
        RoleType paramRoleType = new RoleType();
        paramRoleType.setRoleLabel("LH_G_APPL_CBASE_ROLE");
        roleType.setLabelOfRole(paramRoleType);

        ApplicationType paramApplicationType = new ApplicationType();
        ApplicationIdentificationType paramApplicationIdentificationType = new ApplicationIdentificationType();
        paramApplicationIdentificationType.setDescription("");
        paramApplicationIdentificationType.setLabel("NGI");

        paramApplicationType
                .setApplicationDetails(paramApplicationIdentificationType);
        roleType.setRoleApplication(paramApplicationType);

        OrganizationType paramOrganizationType = new OrganizationType();
        OrganizationIdentificationType paramOrganizationIdentificationType = new OrganizationIdentificationType();
        paramOrganizationIdentificationType.setLabel("LH");
        paramOrganizationType
                .setOrganizationDetails(paramOrganizationIdentificationType);
        roleType.setRoleOwner(paramOrganizationType);

        RoleData roleDta = new RoleData();

        ApplicationType appType = new ApplicationType();
        ApplicationIdentificationType appIdType = new ApplicationIdentificationType();
        appIdType.setDescription("LH");
        appIdType.setLabel("NGI");

        appType.setApplicationDetails(appIdType);

        roleDta.setDataApplication(appType);

        OrganizationType orgTType = new OrganizationType();
        OrganizationIdentificationType orgDetail = new OrganizationIdentificationType();
        orgDetail.setLabel("LH");
        orgTType.setOrganizationDetails(orgDetail);

        roleDta.setDataOrganization(orgTType);

        CodedAttributeType dataTypeValue = new CodedAttributeType();

        CodedAttributeInformationType codAttInfo = new CodedAttributeInformationType();
        codAttInfo.setAttributeDescription("LH");
        codAttInfo.setAttributeType("ORG");

        dataTypeValue.setAttributeDetails(codAttInfo);
        roleDta.setDataTypeAndValue(dataTypeValue);

        roleType.getRoleData().add(roleDta);

        secSignIn.getRoleDataSection().add(roleType);

        FullLocation fullLocation = new FullLocation();

        TerminalLocationType terminalLocationType = new TerminalLocationType();

        FacilityInformationType facilityInfoType = new FacilityInformationType();
        facilityInfoType.setIdentifier("Dashm");
        facilityInfoType.setType("TBD");
        terminalLocationType.setFacilityDetails(facilityInfoType);
        fullLocation.setLocationInfo(terminalLocationType);

        PlaceLocationIdentificationTypeU worStationPos = new PlaceLocationIdentificationTypeU();

        RelatedLocationOneIdentificationTypeU firstLocation = new RelatedLocationOneIdentificationTypeU();
        firstLocation.setCode("309");
        firstLocation.setQualifier("300");
        worStationPos.setFirstLocationDetails(firstLocation);

        LocationIdentificationBatchTypeU locationIdentBatch = new LocationIdentificationBatchTypeU();

        locationIdentBatch.setCode("FRA");
        locationIdentBatch.setQualifier("139");

        worStationPos.setLocationDescription(locationIdentBatch);
        worStationPos.setLocationType("ZZZ");
        fullLocation.setWorkstationPos(worStationPos);

        secSignIn.setFullLocation(fullLocation);
        return secSignIn;
    }

    /** Webservice Functional call. */

    private void callWebService() {

        ServiceConfiguration config;
        try {

            CommandCryptic cryptic = new CommandCryptic();
            cryptic.getInitLongTextString().setTextStringDetails("RT23TCOX");
            MessageAction messageAction = new MessageAction();
            MessageFunctionDetails functionDetails = new MessageFunctionDetails();
            functionDetails.setMessageFunction("131");

            messageAction.setMessageFunctionDetails(functionDetails);
            cryptic.setMessageAction(messageAction);

            config = ServiceFactory
                    .getServiceConfiguration(CommandService.class);
            config.setTransport("https");
            CommandServicesPT service = (CommandServicesPT) ServiceFactory
                    .getService(config);
            config.getContext().setSession(session);
            service.commandCryptic(cryptic);
            CommandCrypticReply reply = service.commandCryptic(cryptic);
            System.out
                    .println(reply.getLongTextString().getTextStringDetails());

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getCause().toString());
        }
    }

    /*
     * Close session with LSS Backend (1A system). This needs to be done
     * explicitly every time a session is opened.
     */

    private void closeSession() {

        SignOut signOut = new SignOut();
        signOut.setSession(session);
        signOut.setSecuritySignOut(new SecuritySignOut());

        // MiddlewareException is thrown now
        try {

            securityService.signOut(signOut);
            System.out.println("session signed out");

        } catch (RemoteException e) {
            System.out.println("exception while invocation.");
            e.printStackTrace();

        } catch (MiddlewareException e) {
            // removed MWException
            System.out
                    .println("Middleware exception caught while Sign out. Please check the logs");
            e.printStackTrace();
        }

    }

    /**
     * Main class: The execution order needs to be followed.
     */
    @Test(expected = ConnectException.class)
    public void webservices_MiddlewareClient() {

        Webservices_MiddlewareClient_Test webservicesClient = new Webservices_MiddlewareClient_Test();

        /**
         * 1. setup the client context.
         */
        webservicesClient.setupClientContext();

        /**
         * 2. Make a security call.replace user/pass and accoridngly also
         * set the Application ID in clientapi.properties.
         */
        webservicesClient.callSecurityService("CBASE", "dFrU426p");

        /**
         * 3. Make a Web service/functional call
         */
        webservicesClient.callWebService();

        /**
         * 4. close the session/conversation with Amadeus systems.
         */
        webservicesClient.closeSession();

    }
}
