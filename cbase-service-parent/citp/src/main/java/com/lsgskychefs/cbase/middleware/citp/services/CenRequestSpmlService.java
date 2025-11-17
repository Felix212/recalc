package com.lsgskychefs.cbase.middleware.citp.services;

import java.math.BigDecimal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.citp.common.pojo.SpmlObject;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsSpmlData;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestFlight;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenRequestSpml;
import com.lsgskychefs.cbase.middleware.persistence.general.CenRequestSpmlRepository;

@Service
public class CenRequestSpmlService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CenRequestSpmlService.class);

	@Autowired
	private CenRequestSpmlRepository cenRequestSpmlRepository;

	public List<CenRequestSpml> getByCenRequestFlightAndClass(final CenRequestFlight cenRequestFlight,
			final String cclass) {

		return cenRequestSpmlRepository.getByCenRequestFlightAndClass(cenRequestFlight, cclass);
	}

	public void storeCenRequestSpml(final List<FsSpmlData> fsSpmlDataList, final CenRequestFlight cenRequestFlight) {

		if (fsSpmlDataList != null && !fsSpmlDataList.isEmpty()) {
			for (final FsSpmlData fsSpmlData : fsSpmlDataList) {
				for (final SpmlObject spmlObject : fsSpmlData.getMySpmls()) {

					// G. Brosch, 10.08.2011 >>>
					if (spmlObject.getCStatus().equalsIgnoreCase("NO")) {
						LOGGER.debug("*******>>> Flight-Key = " + ", Name = " + spmlObject.getCname()
								+ ", ATTENTION: SPML.CSTATUS = NO WAS NOT INSERTED! <<<*********");
						continue;
					}

					final CenRequestSpml cenRequestSpml = new CenRequestSpml();
					cenRequestSpml.setNclassNumber(spmlObject.getNClassNumber());
					cenRequestSpml.setCclass(spmlObject.getCclass());
					cenRequestSpml.setNquantity(new BigDecimal(spmlObject.getNquantity()));
					cenRequestSpml.setCspml(spmlObject.getCspml());
					// WG :5818 DSVGO we are no longer allowed to store the name in the database
//	                setCname(spmlObject.getCname());
					cenRequestSpml.setCaddText(spmlObject.getCaddText());
					cenRequestSpml.setCenRequestFlight(cenRequestFlight);

					cenRequestSpmlRepository.save(cenRequestSpml);
				}
			}
		}

	}
}
