package com.lsgskychefs.cbase.middleware.citp.pojo;

import lombok.Data;

@Data
public class FsFlight  implements java.io.Serializable {

    private FsFlightId id;
    private Fs fs;
    private String cacType;
    private String cacConfiguration;
    private String ctailnumber;
    private int ncx;
    private String ccomment;

}