package com.lsgskychefs.cbase.middleware.citp;

import org.springframework.boot.context.properties.EnableConfigurationProperties;

import com.lsgskychefs.cbase.middleware.AbstractCbaseMiddlewareApplication;
import com.lsgskychefs.cbase.middleware.citp.config.AmadeusPoolCustomProperties;
import com.lsgskychefs.cbase.middleware.citp.config.ClientApiCustomProperties;

@EnableConfigurationProperties({ ClientApiCustomProperties.class, AmadeusPoolCustomProperties.class })
public class CbaseServiceCitpApplication extends AbstractCbaseMiddlewareApplication {
	/**
	 * Main method calling the <code>startApplication</code> method of the parent
	 * class.
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

		if (System.getProperty("enable-tibco-trace") != null) {
			enableTibcoTrace();
		}

		startApplication(isWebApplication, args);
	}

	private static void enableTibcoTrace() {
		System.setProperty("com.tibco.tibjms.debug", "true");
		System.setProperty("com.tibco.tibjms.ssl.debug.trace", "true");
		System.setProperty("com.tibco.tibjms.ssl.trace", "true");

		System.setProperty("Trace.Task.*", "true");
		System.setProperty("java.property.TIBCO_SECURITY_VENDOR", "j2se");
		System.setProperty("java.property.javax.net.debperty.javax.net.debug", "ssl");
		System.setProperty("java.property.javax.net.debug", "ssl");
		System.setProperty("Trace.Role.*", "true");

		System.setProperty("java.security.manager", "");
		System.setProperty("java.security.policy", "security.policy");
		System.setProperty("java.security.debug", "true");
	}

}