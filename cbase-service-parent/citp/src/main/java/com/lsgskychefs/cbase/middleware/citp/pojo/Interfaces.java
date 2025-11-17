package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class Interfaces implements java.io.Serializable {

    private Integer ninterfaceKey;
    private int nkind;
    private String cinterface;
    private Set<Airlines> airlineses = new HashSet<>(0);

}


