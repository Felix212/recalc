package com.lsgskychefs.cbase.middleware.citp.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * Custom file for storing information regarding the variables with Application
 *
 * @author U185502
 */
@Data
@Configuration
//@PropertySource("classpath:config/appvariables.properties")
@PropertySource("file:${CONF_DIR}/appvariables.properties")
@ConfigurationProperties(prefix = "app")
public class AppVariablesCustomProperties {

    private Boolean allFlightModeJob;

    private Integer flightsPerJob;
    private String airlineJob;
    private Long airlineQpKeyJob;

    private Integer statusCustomFlightJob;
    private String requestCustomFlightType;

    private Integer statusAllFlightJob;
    private String requestAllFlightType;

    private String airlineSetCateringFigures;
    private Integer statusSetCateringFigures;
    private String requestTypeSetCateringFigures;

    private Integer corePoolSize;
    private Integer maxPoolSize;
    private Integer queueCapacity;
}
