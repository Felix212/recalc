package com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response;

import lombok.Data;

@Data
public class SpmlData {

    private String cclass;
    private String cspml;
    private int nquantity;
    private String cname;
    private String caddText;
}
