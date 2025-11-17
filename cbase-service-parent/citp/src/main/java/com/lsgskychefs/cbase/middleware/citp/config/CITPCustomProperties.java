package com.lsgskychefs.cbase.middleware.citp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Data;

/**
 * Custom file for storing information regarding the CITP properties
 *
 * @author U185502
 */
@Data
@Configuration
@PropertySource("file:${CONF_DIR}/citp.properties")
@ConfigurationProperties(prefix = "citp")
public class CITPCustomProperties {

    private boolean useIFlirTemplate;

    private String statusIndicator;

    private String actionRequest;

    private int middlewareAttempts;

    private String acTypes;

    private int flightNoPerJob;
    
}
