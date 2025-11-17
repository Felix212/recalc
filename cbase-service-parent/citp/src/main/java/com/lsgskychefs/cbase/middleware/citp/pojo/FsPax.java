package com.lsgskychefs.cbase.middleware.citp.pojo;

import com.lsgskychefs.cbase.middleware.citp.elaboration_data.impl.FsPaxData;

import lombok.Data;

@Data
public class FsPax implements java.io.Serializable {

    private FsPaxId id;
    private Fs fs;
    private Integer nversion;
    private Integer npax;
    private Integer nexpected;
    private Integer npad;
    private Integer nchild;
    private Integer nspml;

    public FsPax(FsPaxData fsPaxData) {

        FsPaxId fsPaxId = new FsPaxId();

        fsPaxId.setCclass(fsPaxData.getCclass());
        fsPaxId.setCflightKey(fsPaxData.getFlightKey());
        fsPaxId.setNqpKey(fsPaxData.getQpKey());

        setId(fsPaxId);
        setNchild(fsPaxData.getNchild());
        setNpax(fsPaxData.getNpax());
        setNspml(fsPaxData.getNpax());
    }
}


