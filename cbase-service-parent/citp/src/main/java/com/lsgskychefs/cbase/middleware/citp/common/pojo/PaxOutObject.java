package com.lsgskychefs.cbase.middleware.citp.common.pojo;

public class PaxOutObject {

    private int nclassNumber;
    private String cclass;
    private int nfunction;
    private int npax;
    private String ccomment;

    public PaxOutObject() {
        this.ccomment =null;
    }

    public PaxOutObject(int nCLASS_NUMBER, String cCLASS, int nFUNCTION, int nPAX, String cCOMMENT) {
        nclassNumber = nCLASS_NUMBER;
        cclass = cCLASS;
        nfunction = nFUNCTION;
        npax = nPAX;
        ccomment = cCOMMENT;
    }

    public int getNclassNumber() {
        return nclassNumber;
    }

    public void setNclassNumber(int nCLASS_NUMBER) {
        nclassNumber = nCLASS_NUMBER;
    }

    public String getCclass() {
        return cclass;
    }

    public void setCclass(String cCLASS) {
        cclass = cCLASS;
    }

    public int getNfunction() {
        return nfunction;
    }

    public void setNfunction(int nFUNCTION) {
        nfunction = nFUNCTION;
    }

    public int getNpax() {
        return npax;
    }

    public void setNpax(int nPAX) {
        npax = nPAX;
    }

    public String getCcomment() {
        return ccomment;
    }

    public void setCcomment(String cCOMMENT) {
        ccomment = cCOMMENT;
    }
}
