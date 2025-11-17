package com.lsgskychefs.cbase.middleware.citp.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * Custom file for storing information regarding the credentials with Amadeus
 *
 * @author U185502
 */
@Data
@Configuration
//@PropertySource("classpath:config/appcredential.properties")
@PropertySource("file:${CONF_DIR}/appcredential.properties")
@ConfigurationProperties(prefix = "app")
public class AppCredentialCustomProperties {

    private String inHouseIdentification;
    private String originator;
    private String originatorTypeCode;
    private String refDetailsType;
    private String refDetailsValue;
    private String desmonUser;
    private String password;
    private String desmonPassword;
    private String globalRoles;
    private String dutyCode;
}
