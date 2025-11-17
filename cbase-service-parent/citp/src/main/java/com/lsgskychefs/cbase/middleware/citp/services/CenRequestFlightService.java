package com.lsgskychefs.cbase.middleware.citp.services;

import java.text.SimpleDateFormat;

import org.apache.commons.collections4.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.impl.Response;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsData;
import com.lsgskychefs.cbase.middleware.citp.utils.DateHelper;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequest;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestFlightRepository;

@Service
public class CenRequestFlightService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestFlightService.class);

	@Autowired
	private CenRequestFlightRepository cenRequestFlightRepository;

	public CenRequestFlight storeCenRequestFlight(final Response responseLogic, final RequestLogic requestLogic) {

		final CenRequestFlight cenRequestFlight = new CenRequestFlight();

		FsData fsData = null;

		if (CollectionUtils.isNotEmpty(responseLogic.getFlightData())) {
			fsData = responseLogic.getFlightData().iterator().next();
		}

		if (requestLogic.getFsData() != null) {
			cenRequestFlight.setNreqFlightKey(requestLogic.getFsData().getNreqFlightKey());
		}

		if (fsData != null) {
			cenRequestFlight.setCairline(fsData.getCairline());
			cenRequestFlight.setNflightNumber(fsData.getNflightNumber());
			cenRequestFlight.setCsuffix(fsData.getCsuffix());
			cenRequestFlight.setDdepartureLocal(
					DateHelper.parseDate(fsData.getDdeparture(), new SimpleDateFormat(DateHelper.DEFAULT_FORMAT_IN)));
			cenRequestFlight.setCdepartureTimeLocal(DateHelper.convert(fsData.getDdepartureUTC(),
					DateHelper.DEFAULT_HOUR_MINUTE, DateHelper.DEFAULT_HOUR_MINUTE));
			cenRequestFlight.setCairline(fsData.getCairline());
			cenRequestFlight.setCairlineOwner(fsData.getCairline());
			cenRequestFlight.setCactype(fsData.getCacType());
			cenRequestFlight.setCconfiguration(fsData.getCacConfiguration());
			cenRequestFlight.setCtlcFrom(fsData.getCtlcFrom());
			cenRequestFlight.setCtlcTo(fsData.getCtlcTo());
			cenRequestFlight.setDarrivalDateLocal(
					DateHelper.parseDate(fsData.getDarrival(), new SimpleDateFormat(DateHelper.DEFAULT_FORMAT_IN)));
			cenRequestFlight.setCarrivalTimeLocal(DateHelper.convert(fsData.getDarrivalUTC(),
					DateHelper.DEFAULT_HOUR_MINUTE, DateHelper.DEFAULT_HOUR_MINUTE));
		}

		final CenRequest cenRequest = new CenRequest();
		cenRequest.setNjobNr(requestLogic.getNJobNumber());

		cenRequestFlight.setCenRequest(cenRequest);

		return cenRequestFlightRepository.save(cenRequestFlight);
	}
}
