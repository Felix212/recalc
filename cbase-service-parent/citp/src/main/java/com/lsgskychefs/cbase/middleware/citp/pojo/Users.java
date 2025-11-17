package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class Users implements java.io.Serializable {

    private String cuserId;
    private String cname;
    private String clastName;
    private String cemail;
    private String cbussinessUnit;
    private int nroleId;
    private byte[] bimage;
    private Set<Airports> airportses = new HashSet<>(0);
    private Set<Airlines> airlineses = new HashSet<>(0);
}


