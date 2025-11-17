/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysPpmRules;

/**
 * Contain all available ctopics for {@link SysPpmRules}
 *
 * @see SysPpmRules
 * @author Alex Schaab - U524036
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PpmRuleTopic {
	DEFAULT("DEFAULT"),
	START("START"),
	STOP("STOP"),
	CONTINOUS("CONTINOUS");

	/** The value for this topic */
	private String value;

	/** Constructor */
	PpmRuleTopic(final String value) {
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
