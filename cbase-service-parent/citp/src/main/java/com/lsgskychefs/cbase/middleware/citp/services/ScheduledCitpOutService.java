package com.lsgskychefs.cbase.middleware.citp.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafuq.DCSFLTSetCateringFigures;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.DCSFLTSetCateringFiguresReply;
import com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.ResponseAnalysisDetailsType;
import com.lsgskychefs.cbase.middleware.base.business.AbstractRequestOutService;
import com.lsgskychefs.cbase.middleware.base.business.CenRequestType;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestOut;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestOutLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.ResponseOutLogic;
import com.lsgskychefs.cbase.middleware.citp.config.AppVariablesCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.exception.CITPTaskException;
import com.lsgskychefs.cbase.middleware.citp.services.amadeus.AmadeusService;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestStatus;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOut;

@Service
@CenRequestType(commaSeperatedTypes = "${app.requestTypeSetCateringFigures}")
public class ScheduledCitpOutService extends AbstractRequestOutService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ScheduledCitpOutService.class);

	@Autowired
	private CateringFiguresService cateringFiguresService;

	@Autowired
	private AppVariablesCustomProperties appVariablesCustomProperties;

	@Autowired
	private AmadeusService amadeusService;

	@Override
	protected void init() {
		setServiceName("cbase_citp_out_service");
	}

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	protected List<CenRequestOut> getOpenJobs() {
		getLogger().debug("check open jobs for CenRequest type <{}>", CenRequestTypes.getValues(types));

		final Pageable poolSized = PageRequest.of(0, maxPoolSize * 10);
		return cenRequestOutRepository.getByCairlineAndNstatusAndNrequestTypeIsInOrderByNjobNrAsc(
				appVariablesCustomProperties.getAirlineSetCateringFigures(), CenRequestStatus.OPEN.getValue(),
				CenRequestTypes.getValues(types), poolSized);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	protected Boolean process(final CenRequestOut jobEntity) {
		try {
			final RequestLogic requestLogic = createRequestObject(jobEntity);

			final DCSFLTSetCateringFigures dcsfltSetCateringFigures = cateringFiguresService
					.buildSetCateringFiguresRequest((RequestOutLogic) requestLogic);

			final DCSFLTSetCateringFiguresReply reply = amadeusService.callSetCateringFigures(dcsfltSetCateringFigures);

			final ResponseAnalysisDetailsType responseAnalysisDetailsType = reply.getResultIndicator();
			final String statusCode = responseAnalysisDetailsType.getStatusCode();

			LOGGER.info(String.format("The SetCateringFiguresResponse status = %s", statusCode));

			if (ResponseOutLogic.SET_CATERING_FIGURES_OK.equalsIgnoreCase(statusCode)) {
				// successful service call
				return true;

			} else {
				final List<com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.ErrorGroupType> errors = reply.getErrors();
				final int countErrors = (errors != null ? errors.size() : 0);

				final StringBuilder stringBuilder = new StringBuilder("Statuscode= " + statusCode + " ");
				for (int iError = 0; iError < countErrors; iError++) {
					stringBuilder.append(editGeneralErrorsToStr(errors.get(iError)));
				}
				LOGGER.error(String.format("The SetCateringFiguresResponse returns: %s", stringBuilder.toString()));
				// failed service call with errortext

				jobEntity.setCerrorText(stringBuilder.toString());
				return false;
			}

		} catch (final CITPTaskException e) {
			jobEntity.setCerrorText(e.getMessage());
			LOGGER.error("Failed to get inventory from CITP due to CITPTaskException", e);
		}

		return false;
	}

	private RequestLogic createRequestObject(final CenRequestOut jobEntity) {
		final RequestLogic requestLogic = new RequestOut();

		requestLogic.setNJobNumber(jobEntity.getNjobNr());
		requestLogic.setRequestType(jobEntity.getNrequestType());
		requestLogic.setFlightKey(jobEntity.getCflightKey());
		requestLogic.setAirlineCode(jobEntity.getCairline());
		requestLogic.setFlightNumber(jobEntity.getNflightNumber());
		requestLogic.setDepartureDate(jobEntity.getDdeparture());
		requestLogic.setOperationalSuffix(jobEntity.getCsuffix());

		requestLogic.setBoardPoint(jobEntity.getCtlcFrom());
		requestLogic.setOffPoint(jobEntity.getCtlcTo());

		return requestLogic;
	}

	private String editGeneralErrorsToStr(
			final com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.ErrorGroupType errorGroupType3) {
		final StringBuilder sb = new StringBuilder();

		final com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.ApplicationErrorInformationType applicationErrorInformationType3 = errorGroupType3
				.getErrorOrWarningCodeDetails();
		final com.dlh.zambas.aws.wbsdcsflt.wrapper.fcafur.ApplicationErrorDetailType applicationErrorDetailType3 = applicationErrorInformationType3
				.getErrorDetails();

		sb.append("[Error: Category=");
		sb.append(applicationErrorDetailType3.getErrorCategory());
		sb.append(", Code=");
		sb.append(applicationErrorDetailType3.getErrorCode());

		final List<String> errorWarningList = errorGroupType3.getInitErrorWarningDescription().getFreeText();

		for (int i = 0; i < errorWarningList.size(); i++) {
			if (i > 0) {
				sb.append("|");
			}
			sb.append(errorWarningList.get(i).concat(" | "));
		}
		sb.append("]");

		return sb.toString();
	}

}
