/*
 * FlightExplosionApplication.java
 *
 * Copyright (c) 2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.preorder;

import com.lsgskychefs.cbase.middleware.AbstractCbaseMiddlewareApplication;


public class PreorderApplication extends AbstractCbaseMiddlewareApplication {
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
