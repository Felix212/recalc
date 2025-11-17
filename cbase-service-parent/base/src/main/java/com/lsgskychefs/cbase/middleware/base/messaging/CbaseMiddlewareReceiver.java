/*
 * IPushService.java
 *
 * Copyright (c) 2015-2019 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.messaging;

import java.util.concurrent.CountDownLatch;

import org.springframework.stereotype.Component;

/**
 * Provide RabbitMQ messaging receiver.
 *
 * @author Alex Schaab - U524036
 */
@Component
public class CbaseMiddlewareReceiver {
	private final CountDownLatch latch = new CountDownLatch(1);

	public void receiveMessage(final String message) {
		System.out.println("Received <" + message + ">");
		latch.countDown();
	}

	public CountDownLatch getLatch() {
		return latch;
	}
}
