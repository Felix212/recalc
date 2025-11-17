package com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response;

import lombok.Data;

@Data
public class FsQp {

    private String cqpText;
    private int noffset;
    private String cacType;
    private String cacConfiguration;
    private String ctailnumber;
    private int ncx;
    private String ccomment;
}
