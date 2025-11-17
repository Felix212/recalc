package com.lsgskychefs.cbase.middleware.citp.common.response;

import com.dlh.zambas.aws.wbspnr.wrapper.PNRListPassengersByFlightReply;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsQp;
import com.lsgskychefs.cbase.middleware.citp.common.request.RequestLogic;
import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.DataFactoryLogic;

/**
 * Defines the CITP Adapter Response Interface
 *
 * @author U185502
 */
public interface ResponseLogic {

    FsQp getFsQp();

    void setFsQp(FsQp fsQp);

    FsData getFsData();

    void setFsData(FsData fsData);

    String getMySBRListYear();

    void setMySBRListYear(String aSBRListYear);

    String getMySBRListMonth();

    void setMySBRListMonth(String aSBRListMonth);

    String getMySBRListDay();

    void setMySBRListDay(String aSBRListDay);

    void setSBRListData(PNRListPassengersByFlightReply aSBRList, RequestLogic requestLogic, DataFactoryLogic dataFactoryLogic, CITPCustomProperties citpCustomProperties);
}
