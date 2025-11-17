package com.lsgskychefs.cbase.middleware.citp.services;

import static com.lsgskychefs.cbase.middleware.citp.utils.ConvertingHelper.convertStringToArrayLong;

import java.util.List;
import java.util.Optional;

import org.apache.commons.collections4.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lsgskychefs.cbase.middleware.base.business.AbstractRequestService;
import com.lsgskychefs.cbase.middleware.base.business.CenRequestType;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData;
import com.lsgskychefs.cbase.middleware.citp.common.request.Request;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.impl.Response;
import com.lsgskychefs.cbase.middleware.citp.config.AppVariablesCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.exception.CITPTaskException;
import com.lsgskychefs.cbase.middleware.citp.exception.CITPTaskFunctionalException;
import com.lsgskychefs.cbase.middleware.citp.services.amadeus.AmadeusService;
import com.lsgskychefs.cbase.middleware.citp.utils.DateHelper;
import com.lsgskychefs.cbase.middleware.persistence.constant.CenRequestTypes;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;

@Service
@CenRequestType(commaSeperatedTypes = "${app.requestCustomFlightType}")
public class ScheduledCitpInService extends AbstractRequestService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ScheduledCitpInService.class);

	@Autowired
	private CenRequestPaxService cenRequestPaxService;

	@Autowired
	private CenRequestSpmlService cenRequestSpmlService;

	@Autowired
	private CenRequestFlightService cenRequestFlightService;

	@Autowired
	private AppVariablesCustomProperties appVariablesCustomProperties;

	@Autowired
	private AmadeusService amadeusService;

	@Override
	protected void init() {
		setServiceName("cbase_citp_in_service");
	}

	@Override
	protected Logger getLogger() {
		return LOGGER;
	}

	@Override
	protected List<CenRequest> getOpenJobs() {
		getLogger().debug("check open jobs for CenRequest type <{}>", CenRequestTypes.getValues(types));

		final Pageable poolSized = PageRequest.of(0, maxPoolSize * 10);
		final String cairline = appVariablesCustomProperties.getAirlineJob();

		if (appVariablesCustomProperties.getAllFlightModeJob() == null
				|| !appVariablesCustomProperties.getAllFlightModeJob()) {
			return cenRequestRepository
					.findByCairlineAndNairlineQpKeyAndNstatusAndCenRequestTypesNrequestTypeIsInOrderByNjobNrAsc(
							cairline, appVariablesCustomProperties.getAirlineQpKeyJob(),
							appVariablesCustomProperties.getStatusCustomFlightJob(),
							convertStringToArrayLong(appVariablesCustomProperties.getRequestCustomFlightType()),
							poolSized);
		} else {
			return cenRequestRepository.findByCairlineAndNstatusAndCenRequestTypesNrequestTypeIsInOrderByNjobNrAsc(
					cairline, appVariablesCustomProperties.getStatusAllFlightJob(),
					convertStringToArrayLong(appVariablesCustomProperties.getRequestCustomFlightType()), poolSized);
		}
	}

	// just if you want to test it synchronously then uncomment it
//	@Override
//	protected CompletableFuture<Boolean> processJob(final CenRequest jobEntity) {
//		final CompletableFuture<Boolean> processFuture = new CompletableFuture<>();
//
//		this.startJob(jobEntity);
//		if (this.process(jobEntity)) {
//			this.finishJob(jobEntity, CenRequestStatus.DONE);
//			processFuture.complete(true);
//		} else {
//			this.finishJob(jobEntity, CenRequestStatus.FAILED);
//			processFuture.complete(false);
//		}
//
//		return processFuture;
//	}

	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public Boolean process(final CenRequest jobEntity) {
		try {
			final RequestLogic requestLogic = createRequestObject(jobEntity);

			final Response responseLogicResponseEntity = (Response) amadeusService.getInventoryFlightData(requestLogic,
					5);

			LOGGER.info("Response status from CITP call: {}", responseLogicResponseEntity);

			final Response responseLogic = Optional.ofNullable(responseLogicResponseEntity)
					.orElseThrow(() -> new NullPointerException("No response body found"));

			responseLogic.setFsQp(requestLogic.getFsQp());
			responseLogic.setFsData(requestLogic.getFsData());

			final CenRequestFlight cenRequestFlight = cenRequestFlightService.storeCenRequestFlight(responseLogic,
					requestLogic);
			cenRequestPaxService.storeCenRequestPax(responseLogic, requestLogic, cenRequestFlight);
			cenRequestSpmlService.storeCenRequestSpml(responseLogic.getFsSpmlData(), cenRequestFlight);

			return true;

		} catch (final CITPTaskFunctionalException e) {
			jobEntity.setCerrorText(e.getMessage());
			LOGGER.error("Failed to get inventory from CITP (1) cause of {}", e.getMyErrorMessage());
			return false;
		} catch (final CITPTaskException e) {
			jobEntity.setCerrorText(e.getMessage());
			LOGGER.error("Failed to get inventory from CITP due to CITPTaskException", e);
		}

		return false;
	}

	private RequestLogic createRequestObject(final CenRequest jobEntity) {
		final RequestLogic requestLogic = new Request();
		CenRequestFlight cenRequestFlight = null;

		final List<CenRequestFlight> cenRequestFlights = cenRequestFlightRepository.findByCenRequest(jobEntity);

		if (CollectionUtils.isNotEmpty(cenRequestFlights)) {
			cenRequestFlight = cenRequestFlights.iterator().next();
		}

		final FsData fsData = new FsData();

		if (cenRequestFlight != null) {
			fsData.setCflightKey("");
			fsData.setCairline(cenRequestFlight.getCairline());
			fsData.setNflightNumber(cenRequestFlight.getNflightNumber());
			fsData.setDdeparture(DateHelper.formatDate(cenRequestFlight.getDdepartureLocal()));
			fsData.setDdepartureUTC(DateHelper.formatDate(cenRequestFlight.getDdepartureLocal()));
//	            fsData.setNdepartureOffset(cenRequestFlight.getCtlcFrom());
			fsData.setCdepStation(cenRequestFlight.getCtlcTo());
			fsData.setDarrival(DateHelper.formatDate(cenRequestFlight.getDarrivalDateLocal()));
			fsData.setDarrivalUTC(DateHelper.formatDate(cenRequestFlight.getDarrivalDateLocal()));
//	            fsData.setNarrivalOffset(cenRequestFlight.getNarrivalOffset());
//	            fsData.setCarrStation(cenRequestFlight.getCarrStation());
			fsData.setCacType(cenRequestFlight.getCactype());
			fsData.setCacConfiguration(cenRequestFlight.getCconfiguration());
//	            fsData.setCrange(cenRequestFlight.getCrange());
//	            fsData.setDtimestamp(DateHelper.getStandardDateMessageQueue(cenRequestFlight.getDtimestamp()));
			fsData.setNreqFlightKey(cenRequestFlight.getNreqFlightKey());
		}

		requestLogic.setFsData(fsData);
		requestLogic.setAirlineCode(jobEntity.getCairline());
		requestLogic.setFlightNumber(jobEntity.getNflightNumber());
		requestLogic.setDepartureDate(jobEntity.getDdeparture());
		requestLogic.setBoardPoint(jobEntity.getCtlcFrom());
		requestLogic.setOffPoint(jobEntity.getCtlcTo());
		requestLogic.setRequestType(RequestLogic.REQTYPE_IFLIRR_AND_SBRLIST);
		requestLogic.setFlightKey(jobEntity.getCflightKey());
		requestLogic.setQpKey(jobEntity.getNairlineQpKey());
		requestLogic.setNJobNumber(jobEntity.getNjobNr());

		return requestLogic;
	}

}
