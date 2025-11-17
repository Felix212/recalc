/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.global;

import java.util.Locale;

/**
 * Class to hold format patterns for cbase middleware.
 *
 * @author Ingo Rietzschel - U125742
 */
public final class FormatConstants {

	/** Default date format pattern for cbase middleware.(dd.MM.yyyy HH:mm) */
	public static final String DATE_PATTERN = "dd.MM.yyyy HH:mm";

	/** Default number format pattern for cbase middleware. (0.###) */
	public static final String NUMBER_PATTERN = "0.###";

	/** 'N/A' as constant */
	public static final String NOT_AVAILABLE = "N/A";

	/** Default locale for cbase middleware */
	public static final Locale DEFAULT_LOCALE = Locale.getDefault();

	/** Date pattern without time (dd.MM.yyyy) */
	public static final String DATE = "dd.MM.yyyy";

	/** Date time pattern 'dd.MM.yyyy HH:mm:ss'. */
	public static final String DATE_TIME = "dd.MM.yyyy HH:mm:ss";

	/** Time pattern for hour and minute: 'HH:mm' */
	public static final String TIME_H_M = "HH:mm";

	/** Time pattern 'HH:mm:ss' */
	public static final String TIME = "HH:mm:ss";

	/** private constructor for constant class */
	private FormatConstants() {
		// nothing
	}
}
