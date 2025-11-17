package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class FsLog implements java.io.Serializable {

    private Integer nfsLogKey;
    private String cairline;
    private Date dfrom;
    private Date dto;
    private int nrows;
    private int nnew;
    private int nchanged;
    private String ccomment;
    private Date dstart;
    private Date dfinished;

}


