/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutCheckpt;

/**
 * Flight checkpoint state.
 *
 * @author Ingo Rietzschel - U125742
 * @see CenOutCheckpt#getNcheckptState()
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CheckpointState {
	/** open (0) */
	OPEN(0),
	/** not relevant(10) */
	NOT_RELEVANT(10),
	/** relevant(20) */
	RELEVANT(20),
	/** target time exceeded by real time(30) */
	FINISHED_OVERDUE(30),
	/** real time bellow target time(40) */
	FINISHED_INTIME(40);

	/** The integer value for this state */
	private int stateValue;

	/** Constructor */
	CheckpointState(final int stateValue) {
		this.stateValue = stateValue;
	}

	/**
	 * The value from current state. Is used in DB.
	 *
	 * @return the state value
	 */
	public int getStateValue() {
		return stateValue;
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
