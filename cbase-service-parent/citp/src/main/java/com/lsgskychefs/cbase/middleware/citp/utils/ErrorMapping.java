package com.lsgskychefs.cbase.middleware.citp.utils;

public class ErrorMapping {

    private String myCITPId;
    private String myCITPDescription;
    private String myCBaseText;

    public ErrorMapping() {
    }

    ErrorMapping(String acitpId, String acitpDescription, String aCBaseText) {
        myCITPId = acitpId;
        myCITPDescription = acitpDescription;
        myCBaseText = aCBaseText;
    }

    public String getCITPID() {
        return myCITPId;
    }

    public String getCITPDescription() {
        return myCITPDescription;
    }

    public String getCBaseText() {
        return myCBaseText;
    }

    public String toString() {
        StringBuffer theStrBuf = new StringBuffer();
        theStrBuf.append("ErrorMapping ");
        theStrBuf.append("  CITP_ID: ");
        theStrBuf.append(myCITPId);
        theStrBuf.append("  CITP_Description: ");
        theStrBuf.append(myCITPDescription);
        theStrBuf.append("  CBaseText: ");
        theStrBuf.append(myCBaseText);

        return theStrBuf.toString();
    }
}