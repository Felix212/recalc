/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.messaging;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * tbd
 *
 * @author Alex Schaab - U524036
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum RoutingKeys {
	DEFAULT("wewillsee");

	/** The value for this topic */
	private String value;

	/** Constructor */
	RoutingKeys(final String value) {
		this.value = value;
	}

	/**
	 * The value.
	 *
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * Returns the name of this enum constant, exactly as declared in its enum declaration.
	 *
	 * @return the name of this enum constant
	 */
	public String getName() {
		return name();
	}

}
