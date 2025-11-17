/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.query;

import java.util.List;
import java.util.TimeZone;

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseSequence;

/**
 * Provide method to handle native query on central position.
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */

public interface NativeQueryProvider {

	/**
	 * Get the next value from given sequence.
	 *
	 * @param sequence the sequence
	 * @return the next value
	 */
	Long getNextSeqValue(final CbaseSequence sequence);

	/**
	 * Get the next x values from given sequence.
	 * 
	 * @param sequence the sequence
	 * @param amount the amount of values to get
	 * @return the next values
	 */
	List<Long> getNextSeqValues(final CbaseSequence sequence, final int amount);

	/**
	 * Get the database time zone.
	 *
	 * @return the database time zone.
	 */
	TimeZone getDatabaseTimeZone();
}
