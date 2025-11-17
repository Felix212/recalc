package com.lsgskychefs.cbase.middleware.citp.services.amadeus;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.dlh.zambas.aws.wbsdcsflt.service.DCSFLTService;
import com.dlh.zambas.aws.wbsdcsflt.service.DCSFLTServicePort;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.DCSFLTSetCateringFigures;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.DCSFLTSetCateringFiguresReply;
import com.dlh.zambas.aws.wbsinv.service.InvService;
import com.dlh.zambas.aws.wbsinv.service.InvServicePort;
import com.dlh.zambas.aws.wbsinv.wrapper.ApplicationErrorDetailType;
import com.dlh.zambas.aws.wbsinv.wrapper.ApplicationErrorInformationType;
import com.dlh.zambas.aws.wbsinv.wrapper.ErrorGroupType;
import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightData;
import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.dlh.zambas.aws.wbsinv.wrapper.StatusDetailsTypeI2;
import com.dlh.zambas.aws.wbsinv.wrapper.StatusTypeI;
import com.dlh.zambas.aws.wbspnr.service.PNRService;
import com.dlh.zambas.aws.wbspnr.service.PNRServicePort;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlight;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlightReply;
import com.dlh.zambas.mw.exception.MiddlewareException;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestInLogic;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.ResponseLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.impl.Response;
import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.DataFactoryLogic;
import com.lsgskychefs.cbase.middleware.citp.exception.CITPTaskException;
import com.lsgskychefs.cbase.middleware.citp.exception.CITPTaskFunctionalException;
import com.lsgskychefs.cbase.middleware.citp.pool.amadeus.AmadeusConnection;
import com.lsgskychefs.cbase.middleware.citp.pool.amadeus.AmadeusConnectionInterface;
import com.lsgskychefs.cbase.middleware.citp.pool.amadeus.AmadeusConversation;
import com.lsgskychefs.cbase.middleware.citp.pool.amadeus.AmadeusConversationHelper;

@Component("amadeusServiceTarget")
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class AmadeusService {
	private static final Logger LOGGER = LoggerFactory.getLogger(AmadeusService.class);

	static AtomicInteger counter = new AtomicInteger(1);

	static String incrementCounter() {
		return String.valueOf(counter.getAndIncrement());
	}

	private final String id;

	@Value("${cbase.service.citp.max.retry:5}")
	private int maxRetry;

	// @Autowired
	// private AmadeusPoolCustomProperties amadeusPoolCustomProperties;

	@Autowired
	private CITPCustomProperties citpCustomProperties;

	private final AmadeusConnectionInterface amadeusConnection;

	public AmadeusService() {
		id = incrementCounter();
		LOGGER.info("New AmadeusService instance created: {}", id);
		amadeusConnection = new AmadeusConnection();
	}

	public Response getSomething(final RequestLogic requestLogic)
			throws CITPTaskException, CITPTaskFunctionalException {
		ResponseLogic responseLogic = null;

		if (requestLogic.getRequestType() == RequestLogic.REQTYPE_IFLIRR_ONLY) {
			// IFLIRR ONLY
			responseLogic = this.getInventoryFlightData(requestLogic, 5);
		}

		if (requestLogic.getRequestType() == RequestLogic.REQTYPE_IFLIRR_AND_SBRLIST) {
			// IFLIRR AND SBRLIST
			responseLogic = this.getInventoryFlightData(requestLogic, 5);
			if (responseLogic != null) {
				this.getSBRListFlightData(requestLogic, responseLogic, 5);
			}
		}
		return (Response) responseLogic;
	}

	public ResponseLogic getInventoryFlightData(final RequestLogic request, final int retry)
			throws CITPTaskException, CITPTaskFunctionalException {

		/*
		 * Access is read only - no loc of flight needed
		 */
		final StatusDetailsTypeI2 statusCompleteDetails = new StatusDetailsTypeI2();
		statusCompleteDetails.setStatusIndicator(citpCustomProperties.getStatusIndicator());
		statusCompleteDetails.setActionRequest(citpCustomProperties.getActionRequest());

		final List<StatusDetailsTypeI2> statusInformation = new ArrayList<>();
		statusInformation.add(statusCompleteDetails);

		final StatusTypeI statusTypeI = new StatusTypeI();
		statusTypeI.getInitStatusInformation().addAll(statusInformation);

		final InvAdvancedGetFlightData invAdvancedGetFlightData = new InvAdvancedGetFlightData();
		invAdvancedGetFlightData.setFlightDate(((RequestInLogic) request).createQuery());
		invAdvancedGetFlightData.setGrabLock(statusTypeI);

		final InvServicePort initializedAmadeusService = amadeusConnection
				.initializeAmadeusService(InvServicePort.class, InvService.class);

		final InvAdvancedGetFlightDataReply reply = AmadeusConversationHelper.process(maxRetry,
				new AmadeusConversation<InvAdvancedGetFlightDataReply>() {
					@Override
					public InvAdvancedGetFlightDataReply execute() throws RemoteException, MiddlewareException {
						return initializedAmadeusService.invAdvancedGetFlightData(invAdvancedGetFlightData);
					}

					@Override
					public void onMaxRetryFailed() {
						amadeusConnection.refreshContext();
					}

				});

		if (reply != null) {
			final ErrorGroupType errorGroupType = reply.getErrorInfo();

			if (errorGroupType != null) {
				final ApplicationErrorInformationType applicationErrorInformationType = errorGroupType
						.getApplicationErrorInfo();

				if (applicationErrorInformationType != null) {
					// -- handle application errors
					// ------------------------------
					final ApplicationErrorDetailType detail = applicationErrorInformationType
							.getApplicationErrorDetail();
					final String code = detail.getApplicationErrorCode();
					final String qual = detail.getCodeListQualifier();
					// EC - Error codes
					// INF - Information code
					// WEC - Warning code

					final List<String> messageText = errorGroupType.getInteractiveFreeText().getMessageText();

					final StringBuilder stringBuilder = new StringBuilder("Application problem[");
					stringBuilder.append(qual).append("], code[").append(code).append("]: ");
					for (final String s : messageText) {
						stringBuilder.append(s);
					}
					final String theLogStr1 = "Error in response: " + stringBuilder.toString() + "  Flightnumber: "
							+ invAdvancedGetFlightData.getFlightDate().getFlightReference().getFlightNumber();
					final boolean theIsFunctionalErrorAndNotToLog = "WEC".equalsIgnoreCase(qual);
					if (theIsFunctionalErrorAndNotToLog) {
						LOGGER.debug(theLogStr1);
						throw new CITPTaskFunctionalException(theLogStr1, code, stringBuilder.toString());
					} else {
						LOGGER.warn(theLogStr1);
						throw new CITPTaskException(theLogStr1);
					}
				}

			} else {
				return new Response(request, reply, new DataFactoryLogic());
			}

		} else {
			throw new CITPTaskException("Bad CITP Response");
		}

		return null;
	}

	public void getSBRListFlightData(final RequestLogic requestLogic, final ResponseLogic responseLogic,
			final int retry) throws CITPTaskException, CITPTaskFunctionalException {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Flight date Database: " + requestLogic.getDepartureDate() + ", Flight date first leg: "
					+ responseLogic.getMySBRListDay() + responseLogic.getMySBRListMonth()
					+ responseLogic.getMySBRListYear());
		}

		final PNRListPassengersByFlight theFlight = ((RequestInLogic) requestLogic).createSBRListQuery(
				responseLogic.getMySBRListYear(), responseLogic.getMySBRListMonth(), responseLogic.getMySBRListDay(),
				citpCustomProperties);

		final PNRServicePort initializedAmadeusService = amadeusConnection
				.initializeAmadeusService(PNRServicePort.class, PNRService.class);

		final PNRListPassengersByFlightReply reply = AmadeusConversationHelper.process(maxRetry,
				new AmadeusConversation<PNRListPassengersByFlightReply>() {
					@Override
					public PNRListPassengersByFlightReply execute() throws RemoteException, MiddlewareException {
						return initializedAmadeusService.pnrListPassengersByFlight(theFlight);
					}

					@Override
					public void onMaxRetryFailed() {
						amadeusConnection.refreshContext();
					}
				});

		if (reply != null) {
			if (reply.getErrorHandler() != null) {
				final List<String> freeTextList = reply.getErrorHandler().getErrorWarningDescription().getFreeText();
				if (freeTextList != null && freeTextList.size() > 0) {
					final StringBuilder msg = new StringBuilder("getSBRListFlightData failed! ");

					for (final String s : freeTextList) {
						msg.append(s);
					}

					final String theErrorID = freeTextList.get(0);
					LOGGER.error(msg.toString());
					throw new CITPTaskFunctionalException(msg.toString(), theErrorID, "getSBRListFlightData failed");
				}
			} else {
				responseLogic.setSBRListData(reply, requestLogic, new DataFactoryLogic(), citpCustomProperties);
			}
		}
	}

	public DCSFLTSetCateringFiguresReply callSetCateringFigures(final DCSFLTSetCateringFigures dcsfltSetCateringFigures)
			throws CITPTaskException {

		final DCSFLTServicePort initializedAmadeusService = amadeusConnection
				.initializeAmadeusService(DCSFLTServicePort.class, DCSFLTService.class);

		final DCSFLTSetCateringFiguresReply reply = AmadeusConversationHelper.process(maxRetry,
				new AmadeusConversation<DCSFLTSetCateringFiguresReply>() {
					@Override
					public DCSFLTSetCateringFiguresReply execute() throws RemoteException, MiddlewareException {
						return initializedAmadeusService.dcsfltSetCateringFigures(dcsfltSetCateringFigures);
					}

					@Override
					public void onMaxRetryFailed() {
						amadeusConnection.refreshContext();
					}
				});

		if (reply != null) {
			return reply;
		} else {
			throw new CITPTaskException("DCSFLT Response is null.");
		}

	}
}
