package com.lsgskychefs.cbase.middleware.citp.pojo;

import com.lsgskychefs.cbase.middleware.citp.common.pojo.SpmlObject;
import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsSpmlData;

import lombok.Data;

@Data
public class FsSpml implements java.io.Serializable {

    private Long nfsSpmlKey;
    private Fs fs;
    private Integer nqpKey;
    private String cclass;
    private String cspml;
    private Integer nquantity;
    private String cname;
    private String caddText;

    public FsSpml(FsSpmlData fsSpmlData, SpmlObject spmlObject) {

        setFs(new Fs(fsSpmlData.getFlightKey()));
        setNqpKey(fsSpmlData.getNreqFlightKey().intValue());
        setCclass(spmlObject.getCclass());
        setCspml(spmlObject.getCspml());
        setNquantity(spmlObject.getNquantity());
        // WG :5818 DSVGO we are no longer allowed to store the name in the database
//        setCname(spmlObject.getCname());
        setCaddText(spmlObject.getCaddText());
    }
}


