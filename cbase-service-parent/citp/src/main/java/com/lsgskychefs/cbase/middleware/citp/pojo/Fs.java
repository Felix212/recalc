package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Data
public class Fs implements java.io.Serializable {

    private String cflightKey;
    private int nairlineKey;
    private String cairline;
    private int nflightNumber;
    private char csuffix;
    private Date ddeparture;
    private Date ddepartureUtc;
    private int ndepartureOffset;
    private String cdepStation;
    private Date darrival;
    private Date darrivalUtc;
    private int narrivalOffset;
    private String carrStation;
    private String cacType;
    private String cacConfiguration;
    private String crange;
    private Date dtimestamp;
    private Set<FsFlight> fsFlights = new HashSet<>(0);
    private Set<FsSpml> fsSpmls = new HashSet<>(0);
    private Set<FsPax> fsPaxes = new HashSet<>(0);
    private Set<FsQp> fsQps = new HashSet<>(0);

    public Fs(String cflightKey) {
        this.cflightKey = cflightKey;
    }
}


