package com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response;

import lombok.Data;

@Data
public class FsData {

    private String cflightKey;
    private String cairline;
    private int nflightNumber;
    private final String csuffix = " ";
    private String ddeparture;
    private String ddepartureUTC;
    private int ndepartureOffset;
    private String cdepStation;
    private String darrival;
    private String darrivalUTC;
    private int narrivalOffset;
    private String carrStation;
    private String cacType;
    private String cacConfiguration;
    private String crange;
    private String dtimestamp;
    private long nreqFlightKey;
}
