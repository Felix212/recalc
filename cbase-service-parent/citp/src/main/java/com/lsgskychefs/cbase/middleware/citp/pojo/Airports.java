package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class Airports implements java.io.Serializable {

    private String ccode;
    private String cdescription;
    private int ntimezone;
    private Set<Users> userses = new HashSet<>(0);


}


