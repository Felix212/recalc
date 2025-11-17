package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

@Data
public class AirlineClasses implements java.io.Serializable {

    private AirlineClassesId id;
    private Airlines airlines;
    private String ciataClass;
    private String cclassName;
    private int nclassSort;


}


