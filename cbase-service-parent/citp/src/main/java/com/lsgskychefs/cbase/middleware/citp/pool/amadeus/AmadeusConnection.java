package com.lsgskychefs.cbase.middleware.citp.pool.amadeus;

import java.rmi.RemoteException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.codec.binary.Base64;
import org.apache.cxf.binding.soap.SoapHeader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.dlh.zambas.aws.wbsunifiedsecurity.service.WbsUnifiedSecurityService;
import com.dlh.zambas.aws.wbsunifiedsecurity.service.WbsUnifiedSecurityServicePort;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.BinaryDataType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.LSSRequestType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.LSSResponseType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.OriginatorIdentificationDetailsTypeI;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.ReferenceInformationTypeI;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.ReferencingDetailsTypeI;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SecurityAuthenticate;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SecurityModeType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.Session;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SignInType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SignOutType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SystemDetailsInfoType;
import com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.SystemDetailsTypeI;
import com.dlh.zambas.mw.client.Context;
import com.dlh.zambas.mw.client.ServiceFactory;
import com.dlh.zambas.mw.client.configuration.ServiceConfiguration;
import com.dlh.zambas.mw.client.exception.ClientAPIException;
import com.dlh.zambas.mw.exception.MiddlewareException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException;
import com.lsgskychefs.cbase.middleware.base.error.exception.CbaseMiddlewareTechnicalException.CbaseMiddlewareTechnicalExceptionType;

public class AmadeusConnection implements AmadeusConnectionInterface {

	private static final Logger LOGGER = LoggerFactory.getLogger(AmadeusConnection.class);

	static AtomicInteger counter = new AtomicInteger(1);

	static String incrementCounter() {
		return String.valueOf(counter.getAndIncrement());
	}

	private final String id;

	private Context clientContext = null;

	private final int retryCount = 3;

	private long sessionCreated = -1;

	public AmadeusConnection() {

		id = incrementCounter();
		LOGGER.info("New AConnection instance created: {}", id);

		this.refreshContext();
	}

	@Override
	public String getID() {
		return id;
	}

	@Override
	public String getCallId() {
		return this.clientContext.getCallID();
	}

	@Override
	public String getCallerID() {
		return this.clientContext.getCallerID();
	}

	@Override
	public Context getClientContext() {
		return this.clientContext;
	}

	private synchronized Session createSession(int retry) {
		if (retry == 0) {
			throw new CbaseMiddlewareTechnicalException(CbaseMiddlewareTechnicalExceptionType.UNKNOWN,
					"Amadeus session creation failed -> too many retries!");
		}

		// Setup LSSRequest object to make sign-in call
		final LSSRequestType lssRequest = new LSSRequestType();
		final SignInType signIn = new SignInType();
		final SecurityAuthenticate securityAuthenticate = new SecurityAuthenticate();

		final com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.UserIdentificationType userIdentifier = new com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.UserIdentificationType();

		final OriginatorIdentificationDetailsTypeI originIdentification = new OriginatorIdentificationDetailsTypeI();
		originIdentification.setSourceOffice("FRALH08CB");
		userIdentifier.setOriginIdentification(originIdentification);
		userIdentifier.setOriginatorTypeCode("U");
		userIdentifier.setOriginator("WSLHCBASE");

		final ReferenceInformationTypeI dutyCode = new ReferenceInformationTypeI();
		final ReferencingDetailsTypeI dutyCodeDetails = new ReferencingDetailsTypeI();
		dutyCodeDetails.setReferenceQualifier("DUT");
		dutyCodeDetails.setReferenceIdentifier("GS");
		dutyCode.setDutyCodeDetails(dutyCodeDetails);

		final SystemDetailsInfoType systemDetails = new SystemDetailsInfoType();
		final SystemDetailsTypeI organizationDetails = new SystemDetailsTypeI();
		organizationDetails.setOrganizationId("LH");
		systemDetails.setOrganizationDetails(organizationDetails);

		final BinaryDataType passwordInfo = new BinaryDataType();
		passwordInfo.setDataLength(5);
		passwordInfo.setDataType("E");
		final byte[] encodedBytes = Base64.encodeBase64("hS2c0".getBytes());

		passwordInfo.setBinaryData(new String(encodedBytes));

		securityAuthenticate.getUserIdentifier().add(userIdentifier);
		securityAuthenticate.setDutyCode(dutyCode);
		securityAuthenticate.setSystemDetails(systemDetails);
		securityAuthenticate.getPasswordInfo().add(passwordInfo);

		signIn.setSecurityAuthenticate(securityAuthenticate);

		lssRequest.setSecurityMode(SecurityModeType.HOSTED);
		lssRequest.setSignIn(signIn);

		ServiceConfiguration serviceConfiguration;
		try {
			serviceConfiguration = ServiceFactory.getServiceConfiguration(WbsUnifiedSecurityService.class);

			final WbsUnifiedSecurityServicePort wbsUnifiedSecurityServicePort = (WbsUnifiedSecurityServicePort) ServiceFactory
					.getService(serviceConfiguration, this.clientContext);

			LSSResponseType lssResponse = null;
			lssResponse = wbsUnifiedSecurityServicePort.authenticateByLSS(lssRequest);

			final com.dlh.zambas.aws.wbsunifiedsecurity.wrapper.Session session = lssResponse.getSuccess()
					.getSessionType().getSession();

			this.sessionCreated = System.currentTimeMillis();
			return session;

		} catch (final Exception e) {
			LOGGER.info("Amadeus session creation failed -> retrying!", e);
			return createSession(retry--);
		}
	}

	public synchronized void destroySessionIfExists() {
		if (clientContext == null || clientContext.getSession() == null) {
			return;
		}

		final LSSRequestType lssRequest = new LSSRequestType();
		final SignOutType signOut = new SignOutType();
		final Session session = (Session) clientContext.getSession();

		signOut.setSession(session);
		lssRequest.setSignOut(signOut);
		lssRequest.setSecurityMode(SecurityModeType.HOSTED);

		try {
			final ServiceConfiguration config = ServiceFactory.getServiceConfiguration(WbsUnifiedSecurityService.class);
			config.setContext(clientContext);
			final WbsUnifiedSecurityServicePort securityService = (WbsUnifiedSecurityServicePort) ServiceFactory
					.getService(config, clientContext);

			final LSSResponseType lssResponse = securityService.authenticateByLSS(lssRequest);
		} catch (final RemoteException | MiddlewareException e) {
			LOGGER.error("Failed to destroy session", e);
			e.printStackTrace();
		} catch (final ClientAPIException e) {
			LOGGER.error("Failed to create servie", e);
		}

		// Removing the Session from client context
		clientContext.setSession(null);

	}

	/**
	 * Initialize the Amadeus Services after log in
	 *
	 * @throws ClientAPIException - throws error during initialization
	 */
	@Override
	public <T, S> T initializeAmadeusService(final Class<T> targetClass, final Class<S> clazz) {

		LOGGER.info("Using AConnection instance: {} with context state [{}] [{}] [{}]", id,
				getClientContextSoapHeaderValue("CallID"), getClientContextSoapHeaderValue("awsse:SessionId"),
				getClientContextSoapHeaderValue("awsse:SequenceNumber"));

		if (isSessionExpired()) {
			LOGGER.info("session expired, creating new one");
			this.refreshContext();
		}

		try {
			final ServiceConfiguration config = ServiceFactory.getServiceConfiguration(clazz);
			config.setContext(clientContext);

			return targetClass.cast(ServiceFactory.getService(config, clientContext));
		} catch (final ClientAPIException e) {
			LOGGER.error("Failed to create servie", e);
			return null;
		}
	}

	private String getClientContextSoapHeaderValue(final String headerName) {
		final Map<String, Object> responseContext = clientContext.getSoapResponseContext();
		final List<SoapHeader> sopaHeaderList = (List<org.apache.cxf.binding.soap.SoapHeader>) responseContext
				.get(org.apache.cxf.headers.Header.HEADER_LIST);

		for (final SoapHeader soapHeader : sopaHeaderList) {
			// full header details in QName
			final javax.xml.namespace.QName qname = soapHeader.getName();
			// header name
			final org.w3c.dom.Node headerNode = (org.w3c.dom.Node) soapHeader.getObject();
			if (headerNode.getNodeName().equals(headerName)) {
				// value of header object
				return headerNode.getTextContent();
			}

			// to fetch child nodes
			if (headerNode.hasChildNodes() && headerNode.getFirstChild().getNodeType() == Node.ELEMENT_NODE) {
				final NodeList list = headerNode.getChildNodes();
				if (list.getLength() > 0) {
					// loop through child nodes
					for (int i = 0; i < list.getLength(); i++) {
						final Node n = list.item(i);
						if (n.getNodeName().equals(headerName)) {
							return n.getTextContent();
						}
					}
				}
			}
		}

		return null;
	}

	@Override
	public void traceSoapHeaders(final String phase) {

		LOGGER.info("### TRACE {} AConnection:{}", phase, id);

	}

	@Override
	public boolean isSessionExpired() {
		final long currentTimestamp = System.currentTimeMillis();
		final long difference = currentTimestamp - sessionCreated;
		if (difference > 10 * 60 * 1000) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public void refreshContext() {
		this.destroySessionIfExists();
		clientContext = ServiceFactory.createContext();
		clientContext.setSession(createSession(retryCount));
	}

}
