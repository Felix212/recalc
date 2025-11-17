package com.lsgskychefs.cbase.middleware.citp.common.request;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsQp;

import java.util.Date;

/**
 * Defines the CITP Adapter Request Interface
 *
 * @author U138665
 */
@JsonSerialize(as= RequestLogic.class)
public interface RequestLogic {

    int REQUEST_DIRECTION_IN = 10;
    int REQUEST_DIRECTION_OUT = 20;
    int STATUS_NEW = 0;
    int STATUS_IN_PROGRESS = 1;
    int STATUS_FINISHED_OK = 2;
    int STATUS_FINISHED_ERROR = 3;
    long REQTYPE_IFLIRR_ONLY = 1;
    long REQTYPE_IFLIRR_AND_SBRLIST = 2;
    long REQTYPE_SET_CATERING_FIGURES = 3;

    FsQp getFsQp();

    void setFsQp(FsQp fsQp);

    FsData getFsData();

    void setFsData(FsData fsData);

    int getRequestDirection();

    String getAirlineCode();

    void setAirlineCode(String val);

    Integer getFlightNumber();

    void setFlightNumber(Integer val);

    String getOperationalSuffix();

    void setOperationalSuffix(String val);

    String getBoardPoint();

    void setBoardPoint(String val);

    String getOffPoint();

    void setOffPoint(String val);

    Date getDepartureDate();

    void setDepartureDate(Date val);

    void prepareTestQuery();

    long getNJobNumber();

    void setNJobNumber(long number);

    long getRequestType();

    void setRequestType(long requestType);

    String getErrorMsg();

    void setErrorMsg(String errorMsg);

    long getResult_Key();

    void setResult_Key(long Result_Key);

    String getFlightKey();

    void setFlightKey(String flightKey);

    Long getQpKey();

    void setQpKey(Long qpKey);

    Long getReqFlightKey();

    void setReqFlightKey(Long reqFlightKey);
}
