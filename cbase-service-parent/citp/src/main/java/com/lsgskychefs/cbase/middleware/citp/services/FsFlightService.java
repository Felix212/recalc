package com.lsgskychefs.cbase.middleware.citp.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.pojo.FsFlight;
import com.lsgskychefs.cbase.middleware.citp.pojo.FsFlightId;

/**
 * Service used for the {@link com.lsgskychefs.cbase.middleware.citp.pojo.FsFlight}
 */
@Service
public class FsFlightService {

    private static final Logger LOGGER = LoggerFactory.getLogger(FsFlightService.class);

    public void saveFightError(RequestLogic requestLogic, String anError) {

        FsFlight fsFlight = new FsFlight();

        FsFlightId fsFlightId = new FsFlightId();

        fsFlightId.setCflightKey(requestLogic.getFlightKey());
        fsFlightId.setNqpKey(requestLogic.getQpKey());

        fsFlight.setId(fsFlightId);

        fsFlight.setCacType("");
        fsFlight.setCacConfiguration("");

        // 1: flight is cancelled, 0 flight is scheduled
        fsFlight.setNcx(1);
        fsFlight.setCcomment(anError);

    }
}
