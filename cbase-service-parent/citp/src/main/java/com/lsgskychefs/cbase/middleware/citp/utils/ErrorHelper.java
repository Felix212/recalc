package com.lsgskychefs.cbase.middleware.citp.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lsgskychefs.cbase.middleware.citp.config.CITPCustomProperties;

import java.util.HashMap;
import java.util.Map;

public class ErrorHelper {

    private static final Logger LOGGER = LoggerFactory.getLogger(ErrorHelper.class);

    private CITPCustomProperties citpCustomProperties;

    public ErrorHelper(CITPCustomProperties citpCustomProperties) {
        this.citpCustomProperties = citpCustomProperties;
    }

    public ErrorMapping getCbaseErrorTextUnknown() {
        return getCbaseErrorText("UNKNOWN");
    }

    public ErrorMapping getCbaseErrorTextTechnical() {
        return getCbaseErrorText("TECHNICAL");
    }

    public ErrorMapping getCbaseErrorText(String aKey) {
        LOGGER.info(String.format("CbaseErrorText KEY='%s'", aKey));
        ErrorMapping theEM = getErroMappingConfig().get(aKey);
        if (null == theEM) {
            LOGGER.info(String.format("Message-Code unknown: %s", aKey));
            theEM = new ErrorMapping();
        }
        return theEM;
    }

    private Map<String, ErrorMapping> getErroMappingConfig() {
        java.util.Map<String, ErrorMapping> theErrorConfig = new HashMap<>();

        String[] fields = citpCustomProperties.getActionRequest().split(",");

        String myCITPIdField = "";
        String myCITPDescriptionField = "";
        String myCBaseTextField = "";

        if (fields == null || fields.length == 0) {
            return null;
        }

        try {
            myCITPIdField = fields[0];
        } catch (Exception e) {
        }

        try {
            myCITPDescriptionField = fields[1];
        } catch (Exception e) {
        }

        try {
            myCBaseTextField = fields[2];
        } catch (Exception e) {
        }

        theErrorConfig.put(fields[0], new ErrorMapping(myCITPIdField, myCITPDescriptionField, myCBaseTextField));

        return theErrorConfig;
    }
}
