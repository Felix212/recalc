package com.lsgskychefs.cbase.middleware.citp.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.common.response.impl.Response;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsPaxData;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestPax;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestPaxRepository;

@Service
public class CenRequestPaxService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestPaxService.class);

	@Autowired
	private CenRequestPaxRepository cenRequestPaxRepository;

	public void storeCenRequestPax(final Response response, final RequestLogic requestLogic,
			final CenRequestFlight cenRequestFlight) {

		final List<FsPaxData> fsPaxDataList = response.getFsPaxData();

		for (final FsPaxData fsPaxData : fsPaxDataList) {

			final CenRequestPax cenRequestPax = new CenRequestPax();

			cenRequestPax.setNclassNumber(fsPaxData.getNclassNumber());

			try {
				cenRequestPax.setNversion(Integer.valueOf(fsPaxData.getNversion()));
			} catch (final Exception e) {
				LOGGER.error(e.getMessage(), e);
			}

			cenRequestPax.setNpax(fsPaxData.getNpax());

			try {
				cenRequestPax.setNexpected(Integer.valueOf(fsPaxData.getNexpected()));
			} catch (final Exception e) {
				LOGGER.error(e.getMessage(), e);
			}

			try {
				cenRequestPax.setNpad(Integer.valueOf(fsPaxData.getNpad()));
			} catch (final Exception e) {
				LOGGER.error(e.getMessage(), e);
			}

			cenRequestPax.setNchd(fsPaxData.getNchild());
			cenRequestPax.setNpaxSpml(fsPaxData.getNspml());
			cenRequestPax.setCclass(fsPaxData.getCclass());

			final long nReqFlightKey = requestLogic.getFsData().getNreqFlightKey();

			cenRequestPax.setNreqPaxKey(nReqFlightKey);
			cenRequestPax.setCenRequestFlight(cenRequestFlight);

			cenRequestPaxRepository.save(cenRequestPax);
		}
	}
}
