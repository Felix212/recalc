/*
 * IPushService.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.push;

import com.lsgskychefs.cbase.middleware.base.rest.ResponseElement;

/**
 * Service responsible for pushing messages to clients.
 *
 * @author Andreas Morgenstern
 */
public interface IPushService {

	/**
	 * Pushes a message to the given topic.
	 *
	 * @param topic The topic
	 * @param message the message data.
	 */
	void pushJSONMessage(final String topic, String message);

	/**
	 * Pushes a message contained in the given <code>ResponseElement</code> to the given topic. The message is transformed to a JSON string.
	 *
	 * @param topic The topic
	 * @param responseElement The <code>ResponseElement</code> containing the message data.
	 */
	void pushJSONMessage(final String topic, final ResponseElement responseElement);

	/**
	 * Pushes a message contained in the given <code>ResponseElement</code> to the given topic. The message is transformed to a JSON string.
	 *
	 * @param topic The topic
	 * @param responseElement The <code>ResponseElement</code> containing the message data.
	 */
	void pushJSONMessage(final PushServiceDefaultTopics topic, final ResponseElement responseElement);

}
