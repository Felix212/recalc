package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class Airlines implements java.io.Serializable {

    private Integer nairlineKey;
    private Interfaces interfaces;
    private String cairline;
    private String cname;
    private byte[] blogo;
    private String cfspFreq;
    private String cfspTime;
    private int nfspOffset;
    private Set<AirlineClasses> airlineClasseses = new HashSet<>(0);
    private Set<AirlinesQp> airlinesQps = new HashSet<>(0);
    private Set<Users> userses = new HashSet<>(0);


}


