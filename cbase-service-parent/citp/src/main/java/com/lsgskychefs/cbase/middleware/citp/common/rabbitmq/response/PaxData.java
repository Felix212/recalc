package com.lsgskychefs.cbase.middleware.citp.common.rabbitmq.response;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class PaxData {

    private String cclass;
    private String nversion;
    private int npax;
    private String nexpected;
    private String npad;
    private int nchild;
    private int nspml;

    private List<SpmlData> spml = new ArrayList<>();
}
