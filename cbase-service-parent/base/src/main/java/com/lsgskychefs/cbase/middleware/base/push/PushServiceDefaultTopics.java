/*
 * PushServiceDefaultTopics.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.push;

/**
 * Default Topics for the <code>PushService</code>.
 *
 * @author Andreas Morgenstern
 */
public enum PushServiceDefaultTopics {

	/** Topic for the StatusMonitor listeners - usually extend with nppm_sched_key */
	STATUS_MONITOR("StatusMonitor"),

	/** Topic for checkpoint comments */
	CHECKPOINT_REMARK("CheckpointRemark"),

	/** topic for checkpoint state changes */
	CHECKPOINT_STATE("CheckpointState"),

	/** topic for shift changes (move work order to a other shift) */
	SHIFT_CHANGES("ShiftChanges"),

	/** topic for shift changes (move flight to a other shift) */
	SHIFT_CHANGES_FLIGHT("ShiftChangesFlight"),

	/** topic for Powebuilder Flight Freeze Logic to inform about Workorder Changes - usually extend with nppm_sched_key */
	PPM_BATCH_NEW("PPMBatchNew"),

	/** topic for Powebuilder Flight Freeze Logic to inform about Workorder Changes - usually extend with nppm_sched_key */
	PPM_BATCH_DEL("PPMBatchDel"),

	/** topic for Powebuilder Flight Freeze Logic to inform about Workorder Changes - usually extend with nppm_sched_key */
	PPM_QTY_CHG("PPMQtyChg"),

	/** topic for planshift, after planshift is called */
	PLANSHIFT_CHG("PlanShift"),

	/** topic for CSO, to trigger AC and TimeChanges */
	PPM_FLIGHT_CHANGE("PPMFlightChange"),

	/** topic for CSO, to trigger AC and TimeChanges */
	PPM_CSO_STOWAGE_CHANGE("PPMCSOStowageChange"),

	/** topic for Chiller, to change stock content */
	CHILLER_STOCK_CHANGE("ChillerStockChange");

	/** The separator for fix and dynamix(extend) part of a topic. */
	public static final String TOPIC_SEPARATOR = "_";

	/** topic name */
	private String topic;

	/**
	 * Private constructor.
	 *
	 * @param topic the topic name
	 */
	PushServiceDefaultTopics(final String topic) {
		this.topic = topic;
	}

	/**
	 * Get topic name
	 *
	 * @return the topic name
	 */
	public String getTopic() {
		return topic;
	}

	/**
	 * Get the current topic extended with dynamic/extended part. (The enum topic is not changed)
	 *
	 * @param extendPart the dynamic part of a topic
	 * @return the extended topic.
	 */
	public String extendTopic(final String extendPart) {
		return this.topic + PushServiceDefaultTopics.TOPIC_SEPARATOR + extendPart;
	}

}
