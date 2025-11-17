/*
 * FlightCalculationApplication.java
 *
 * Copyright (c) 2020 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.flightcalculation;

import com.lsgskychefs.cbase.middleware.AbstractCbaseMiddlewareApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.amqp.RabbitAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Central class to bootstrap the application component via Spring Boot.
 *
 * @author Dirk Bunk - U200035
 */
@SpringBootApplication(exclude = {RabbitAutoConfiguration.class})
@EnableScheduling
public class FlightCalculationApplication extends AbstractCbaseMiddlewareApplication {
	/**
	 * Main method calling the <code>startApplication</code> method of the parent class.
	 *
	 * @param args The application arguments to be passed to Spring Boot.
	 */
	public static void main(final String... args) {
		boolean isWebApplication = true;
		for (final String arg : args) {
			if (arg.contains("run-as-service")) {
				isWebApplication = false;
				break;
			}
		}

		if (System.getProperty("run-as-service") != null) {
			isWebApplication = false;
		}

		startApplication(isWebApplication, args);
	}
}