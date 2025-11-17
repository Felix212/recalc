package com.lsgskychefs.cbase.middleware.citp.elaboration_data;

import com.dlh.zambas.aws.wbsinv.wrapper.InvAdvancedGetFlightDataReply;
import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlightReply;
import com.lsgskychefs.cbase.middleware.citp.common.pojo.SsrObject;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsData;

import java.util.List;

public interface DataFactory {

    /**
     * creates data for the flight table.
     *
     * @param myRequest the id of the current row in the table cen_request.
     * @param res       CITP response.
     * @return List of FilghtDaos filled with the data of the citp response.
     */
    List<FsData> createFlightData(final RequestLogic myRequest,
                                  final InvAdvancedGetFlightDataReply res);

    /**
     * creates data for the pax table.
     *
     * @param myRequest     the id of the current row in the table cen_request.
     * @param res           CITP response.
     * @param nreqFlightKey the reference / foreign key to the table flight.
     * @return List of FilghtDaos filled with the data of the citp response.
     */
    List<DataLogic> createFsPaxData(final RequestLogic myRequest,
                                    final InvAdvancedGetFlightDataReply res,
                                    final Long nreqFlightKey);

    SsrObject createSpmlData(final List<PNRListPassengersByFlightReply.AggregatedOutput.PnrViews> aPNRViews,
                             String aCabin, Long aFlightKey, String flightKey);

    SsrObject createSeatData(final List<PNRListPassengersByFlightReply.AggregatedOutput.PnrViews> aPNRViews, Long aFlightKey);
}
