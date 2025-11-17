package com.lsgskychefs.cbase.middleware.citp.common.request;

import java.util.Date;

import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsData;
import com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response.FsQp;

/**
 * Used for the type of the direction: OUT
 *
 * @author U185502
 */
public class RequestOut implements RequestOutLogic {

    private long nJobNr;
    private String hostname;
    private String client;
    private String unit;
    private long requestType;
    private long resultKey;
    private String airline;
    private Integer flightNumber;
    private String suffix;
    private Date departureDateLocal;
    private String tclFrom;
    private String tclTo;
    private Date createdDate;
    private Date sentDate;
    private Date confirmedDate;
    private int status;
    private String errorText;
    private long retry;
    private String flightKey;
    private Long qpKey;
    private Long reqFlightKey;
    private Long transaction;

    private FsQp fsQp;
    private FsData fsData;

    @Override
    public FsQp getFsQp() {
        return fsQp;
    }

    @Override
    public void setFsQp(FsQp fsQp) {
        this.fsQp = fsQp;
    }

    @Override
    public FsData getFsData() {
        return fsData;
    }

    @Override
    public void setFsData(FsData fsData) {
        this.fsData = fsData;
    }

    public int getRequestDirection() {
        return REQUEST_DIRECTION_OUT;
    }


    public String getAirlineCode() {
        return airline;
    }


    public void setAirlineCode(String val) {
        airline = val;
    }


    public Integer getFlightNumber() {
        return flightNumber;
    }


    public void setFlightNumber(Integer val) {
        flightNumber = val;
    }


    public String getOperationalSuffix() {
        return suffix;
    }


    public void setOperationalSuffix(String val) {
        suffix = val;

    }


    public String getBoardPoint() {
        return tclFrom;
    }


    public void setBoardPoint(String val) {
        tclFrom = val;
    }


    public String getOffPoint() {
        return tclTo;
    }


    public void setOffPoint(String val) {
        tclTo = val;
    }


    public Date getDepartureDate() {
        return departureDateLocal;
    }


    public void setDepartureDate(Date val) {
        departureDateLocal = val;
    }


    public void prepareTestQuery() {
        // TODO Auto-generated method stub

    }


    public long getNJobNumber() {
        return nJobNr;
    }


    public void setNJobNumber(long number) {
        nJobNr = number;
    }


    public long getRequestType() {
        return requestType;
    }


    public void setRequestType(long reqType) {
        requestType = reqType;
    }

    public String getErrorMsg() {
        return errorText;
    }

    public void setErrorMsg(String errorMsg) {
        errorText = errorMsg;
    }

    public long getResult_Key() {
        return resultKey;
    }


    public void setResult_Key(long number) {
        resultKey = number;
    }

    @Override
    public String getFlightKey() {
        return flightKey;
    }

    @Override
    public void setFlightKey(String flightKey) {
        this.flightKey = flightKey;
    }

    @Override
    public Long getQpKey() {
        return qpKey;
    }

    @Override
    public void setQpKey(Long qpKey) {
        this.qpKey = qpKey;
    }

    @Override
    public Long getReqFlightKey() {
        return reqFlightKey;
    }

    @Override
    public void setReqFlightKey(Long reqFlightKey) {
        this.reqFlightKey = reqFlightKey;
    }
}
