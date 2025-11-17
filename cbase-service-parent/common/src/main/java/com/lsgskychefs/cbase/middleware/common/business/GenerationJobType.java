/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.business;

/**
 * Generation job type for documents.
 *
 * @author Ingo Rietzschel - U125742
 */
public enum GenerationJobType {

	/** generation type for generic documents. */
	GENERIC(1),
	/** generation type for secondary distribution documents. */
	SECONDARY_DISTRIBUTION(2),
	/** generation type for user defined documents. */
	USER_DEFINED(3);

	/** value of current job type */
	private int typeValue;

	/** Constructor @param typeValue */
	GenerationJobType(final int typeValue) {
		this.typeValue = typeValue;
	}

	/**
	 * Get typeValue
	 *
	 * @return the typeValue
	 */
	public int getTypeValue() {
		return typeValue;
	}

}
