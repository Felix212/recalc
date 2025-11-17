package com.lsgskychefs.cbase.middleware.citp.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * Custom file for Amadeus Pool storing information regarding the pool and configuration of the Amadeus connection
 *
 * @author U185502
 */
@Data
@Configuration
//@PropertySource("classpath:config/amadeuspool.properties")
@PropertySource("file:${CONF_DIR}/amadeuspool.properties")
@ConfigurationProperties(prefix = "amadeuspool")
public class AmadeusPoolCustomProperties {

    private int minIdle;
    private int maxIdle;
    private int maxTotal;
    private boolean testOnBorrow;
    private boolean testOnReturn;
    private int maxActive;
    private int maxWait;

    private int whenExhaustedAction;

    private int timeBetweenEvictionRunsMillis;
    private int numTestsPerEvictionRun;
    private boolean testWhileIdle;

    private int minEvictableIdleTimeMillis;
    private boolean lifo;
}
