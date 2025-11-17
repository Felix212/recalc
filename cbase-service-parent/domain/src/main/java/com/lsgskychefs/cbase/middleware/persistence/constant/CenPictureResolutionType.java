/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenPictureResolution;

/**
 * Contain all available resolution values for {@link CenPictureResolution}
 *
 * @see CenPictureResolution
 * @author Alex Schaab - U524036
 */
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CenPictureResolutionType {
	/** width:160, height:160 */
	LOW(1),
	/** width:600, height:600 */
	MEDIUM(2);

	/** The integer value for this type */
	private int value;

	/** Constructor */
	CenPictureResolutionType(final int value) {
		this.value = value;
	}

	/**
	 * The value from current resolution. Is used in DB.
	 *
	 * @return the value
	 */
	public int getValue() {
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
