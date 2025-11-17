package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

@Data
public class AirlinesQp implements java.io.Serializable {

    private Integer nqpKey;
    private Airlines airlines;
    private String cqpText;
    private int noffset;

}


