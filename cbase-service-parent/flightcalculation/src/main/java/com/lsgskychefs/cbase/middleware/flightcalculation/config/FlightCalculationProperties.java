/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

/**
 * Configuration properties for Flight Calculation Service.
 * Maps to application.yml properties under 'flight-calculation' prefix.
 *
 * <p>Example configuration:
 * <pre>
 * flight-calculation:
 *   instance-name: INSTANCE99
 *   number-of-calculations-per-cycle: 1
 *   process-functions:
 *     - 1  # FLIGHT_CALC
 *   read-cen-out: true
 *   scheduler:
 *     enabled: true
 *     interval-seconds: 60
 * </pre>
 *
 * @author Migration Team
 */
@Configuration
@ConfigurationProperties(prefix = "flight-calculation")
public class FlightCalculationProperties {

	/**
	 * Instance name for this service instance.
	 * Corresponds to PowerBuilder INI section name (e.g., "INSTANCE99").
	 */
	private String instanceName = "INSTANCE99";

	/**
	 * Number of jobs to process per cycle.
	 * Corresponds to PowerBuilder: iNumberOfCalculationsToProcess
	 */
	private int numberOfCalculationsPerCycle = 1;

	/**
	 * List of function IDs to process.
	 * Empty list means process all functions (-1 in PowerBuilder).
	 * Corresponds to PowerBuilder: iProcessFunction[]
	 */
	private List<Integer> processFunctions = new ArrayList<>();

	/**
	 * Whether to read CEN_OUT table for new jobs.
	 * Corresponds to PowerBuilder: bread_cen_out
	 */
	private boolean readCenOut = true;

	/**
	 * Whether to always force meal calculation.
	 * Corresponds to PowerBuilder: bDoAllwaysMealCalc
	 */
	private boolean alwaysForceMealCalculation = true;

	/**
	 * Maximum lock time in seconds.
	 * Corresponds to PowerBuilder: il_maxlock
	 */
	private int maxLockSeconds = 60;

	/**
	 * Service name for logging and protocol.
	 * Corresponds to PowerBuilder: sService_Name
	 */
	private String serviceName = "cbase_flight_calculation";

	/**
	 * Scheduler configuration.
	 */
	private SchedulerConfig scheduler = new SchedulerConfig();

	/**
	 * Locking configuration.
	 */
	private LockingConfig locking = new LockingConfig();

	/**
	 * Logging configuration.
	 */
	private LoggingConfig logging = new LoggingConfig();

	// Getters and setters

	public String getInstanceName() {
		return instanceName;
	}

	public void setInstanceName(String instanceName) {
		this.instanceName = instanceName;
	}

	public int getNumberOfCalculationsPerCycle() {
		return numberOfCalculationsPerCycle;
	}

	public void setNumberOfCalculationsPerCycle(int numberOfCalculationsPerCycle) {
		this.numberOfCalculationsPerCycle = numberOfCalculationsPerCycle;
	}

	public List<Integer> getProcessFunctions() {
		return processFunctions;
	}

	public void setProcessFunctions(List<Integer> processFunctions) {
		this.processFunctions = processFunctions;
	}

	public boolean isReadCenOut() {
		return readCenOut;
	}

	public void setReadCenOut(boolean readCenOut) {
		this.readCenOut = readCenOut;
	}

	public boolean isAlwaysForceMealCalculation() {
		return alwaysForceMealCalculation;
	}

	public void setAlwaysForceMealCalculation(boolean alwaysForceMealCalculation) {
		this.alwaysForceMealCalculation = alwaysForceMealCalculation;
	}

	public int getMaxLockSeconds() {
		return maxLockSeconds;
	}

	public void setMaxLockSeconds(int maxLockSeconds) {
		this.maxLockSeconds = maxLockSeconds;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public SchedulerConfig getScheduler() {
		return scheduler;
	}

	public void setScheduler(SchedulerConfig scheduler) {
		this.scheduler = scheduler;
	}

	public LockingConfig getLocking() {
		return locking;
	}

	public void setLocking(LockingConfig locking) {
		this.locking = locking;
	}

	public LoggingConfig getLogging() {
		return logging;
	}

	public void setLogging(LoggingConfig logging) {
		this.logging = logging;
	}

	/**
	 * Scheduler configuration.
	 */
	public static class SchedulerConfig {
		/**
		 * Enable/disable scheduler.
		 */
		private boolean enabled = true;

		/**
		 * Polling interval in seconds.
		 */
		private int intervalSeconds = 60;

		/**
		 * Initial delay before first execution in seconds.
		 */
		private int initialDelaySeconds = 10;

		public boolean isEnabled() {
			return enabled;
		}

		public void setEnabled(boolean enabled) {
			this.enabled = enabled;
		}

		public int getIntervalSeconds() {
			return intervalSeconds;
		}

		public void setIntervalSeconds(int intervalSeconds) {
			this.intervalSeconds = intervalSeconds;
		}

		public int getInitialDelaySeconds() {
			return initialDelaySeconds;
		}

		public void setInitialDelaySeconds(int initialDelaySeconds) {
			this.initialDelaySeconds = initialDelaySeconds;
		}
	}

	/**
	 * Locking configuration.
	 */
	public static class LockingConfig {
		/**
		 * Lock timeout in milliseconds for pessimistic locking.
		 */
		private int timeoutMillis = 60000;

		/**
		 * Whether to use distributed locking (future enhancement).
		 */
		private boolean distributed = false;

		public int getTimeoutMillis() {
			return timeoutMillis;
		}

		public void setTimeoutMillis(int timeoutMillis) {
			this.timeoutMillis = timeoutMillis;
		}

		public boolean isDistributed() {
			return distributed;
		}

		public void setDistributed(boolean distributed) {
			this.distributed = distributed;
		}
	}

	/**
	 * Logging configuration.
	 */
	public static class LoggingConfig {
		/**
		 * Include job key in MDC logging context.
		 */
		private boolean includeJobKey = true;

		/**
		 * Include result key in MDC logging context.
		 */
		private boolean includeResultKey = true;

		/**
		 * Log level for trace operations.
		 */
		private String traceLevel = "INFO";

		public boolean isIncludeJobKey() {
			return includeJobKey;
		}

		public void setIncludeJobKey(boolean includeJobKey) {
			this.includeJobKey = includeJobKey;
		}

		public boolean isIncludeResultKey() {
			return includeResultKey;
		}

		public void setIncludeResultKey(boolean includeResultKey) {
			this.includeResultKey = includeResultKey;
		}

		public String getTraceLevel() {
			return traceLevel;
		}

		public void setTraceLevel(String traceLevel) {
			this.traceLevel = traceLevel;
		}
	}
}
