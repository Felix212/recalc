package com.lsgskychefs.cbase.middleware.citp.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/**
 * Custom file for CAPI storing information regarding the communication with Amadeus
 *
 * @author U185502
 */
@Data
@Configuration
@PropertySource("file:${CONF_DIR}/clientapi.properties")
@ConfigurationProperties(prefix = "clientapi")
public class ClientApiCustomProperties {

    private String applicationId = "Test";

    private String customerId;

    private String username;

    private String password;

    private String targetCarrierId;

    private String callerId;

    private String compression;

    private String defaultTransport;

    private String httpServer;

    private String httpPort;

    private String httpsServer;

    private String httpsPort;

    private String jmsNamingProviderUrl;

    private String jmsSslNamingProviderUrl;

    private String jmsUsername;

    private String jmsPassword;

    private String jmsMessageTimeout;

    private String httpMessageTimeout;

    private String backend;

    private String inactivityTimeout;

    private String maxJmsSessions;

    private String jmsQueueId;

    private String jmsConnectionAttempts;

    private String jmsConnectionAttemptsDelay;

    private String jmsConnectionAttemptTimeout;

    private String jmsSocketConnectTimeout;

    private String jmsMaintenanceTopicSubscribe;

    private String jmsMaintenanceTopicConnectionFactory;

    private String maxHttpConnections;

    private String enableLoadbalancedJms;

    private String maxJmsConnections;

    private String maxJmsProviderInstances;

    private String jmsConnectionFactoryPrefix;

    private String logenabled;

    private String hostnameverification;

    private String cipherSuites;

    private String responseTimeThreshold;

    private String logLevel;
}
