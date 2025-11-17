package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class FsQp implements java.io.Serializable {

    private FsQpId id;
    private Fs fs;
    private String cqpText;
    private Date dtimestamp;
    private int ndone;

}


