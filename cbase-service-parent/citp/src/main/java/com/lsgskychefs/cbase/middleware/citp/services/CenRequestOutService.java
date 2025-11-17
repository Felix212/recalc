package com.lsgskychefs.cbase.middleware.citp.services;

import static com.lsgskychefs.cbase.middleware.citp.utils.ConvertingHelper.convertStringToArrayLong;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestOut;
import com.lsgskychefs.cbase.middleware.citp.config.AppVariablesCustomProperties;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestOut;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestOutRepository;

@Service
public class CenRequestOutService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestOutService.class);

	@Autowired
	private CenRequestOutRepository cenRequestOutRepository;

	/**
	 * Get the {@link CenRequestOut} and convert them to {@link RequestLogic}
	 *
	 * @param appVariablesCustomProperties
	 * @param pageable
	 * @return list of {@link RequestLogic}
	 */
	public List<RequestLogic> getRequestsLogic(final AppVariablesCustomProperties appVariablesCustomProperties,
			final Pageable pageable) {

		final List<RequestLogic> requestLogics = new ArrayList<>();

//        List<CenRequestOut> cenRequestOuts = new ArrayList<>();
//        cenRequestOuts.add(cenRequestOutRepository.findOne(115114920L));

		final List<CenRequestOut> cenRequestOuts = cenRequestOutRepository
				.getByCairlineAndNstatusAndNrequestTypeIsInOrderByNjobNrAsc(
						appVariablesCustomProperties.getAirlineSetCateringFigures(),
						appVariablesCustomProperties.getStatusSetCateringFigures(),
						convertStringToArrayLong(appVariablesCustomProperties.getRequestTypeSetCateringFigures()),
						pageable);

		LOGGER.info("CEN_REQUEST_OUT for " + appVariablesCustomProperties.getAirlineSetCateringFigures() + " Type "
				+ appVariablesCustomProperties.getRequestTypeSetCateringFigures() + " returns:"
				+ cenRequestOuts.size());

		for (final CenRequestOut cenRequestOut : cenRequestOuts) {

			final RequestLogic requestLogic = new RequestOut();

			requestLogic.setNJobNumber(cenRequestOut.getNjobNr());
			requestLogic.setRequestType(cenRequestOut.getNrequestType());
			requestLogic.setFlightKey(cenRequestOut.getCflightKey());
			requestLogic.setAirlineCode(cenRequestOut.getCairline());
			requestLogic.setFlightNumber(cenRequestOut.getNflightNumber());
			requestLogic.setDepartureDate(cenRequestOut.getDdeparture());
			requestLogic.setOperationalSuffix(cenRequestOut.getCsuffix());

			requestLogic.setBoardPoint(cenRequestOut.getCtlcFrom());
			requestLogic.setOffPoint(cenRequestOut.getCtlcTo());

			requestLogics.add(requestLogic);
		}

		return requestLogics;
	}
}
