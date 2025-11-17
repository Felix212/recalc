/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginHistKind;

/**
 * The login history type ({@link SysLoginHistKind#getNloginHistkindKey()})
 *
 * @author Ingo Rietzschel - U125742
 */
public enum CbaseLoginHistKind {
	/** password changed - 1 */
	PASSWORD_CHANGED(1),
	/** wrong password - 2 */
	WRONG_PASSWORD(2),
	/** account locked, wrong password - 3 */
	ACCOUNTLOCK_BECAUSE_OF_WRONG_PASSWORD(3),
	/** password expired - 4 */
	ACCOUNTLOCK_BECAUSE_OF_INACTIVITY(4),
	/** 5 */
	PASSWORD_RESET(5),
	/** remove account lock - 6 */
	ACCOUNTLOCK_RESET(6),
	/** 7 */
	LOGIN_REFUSED_BECAUSE_OF_ACCOUNTLOCK(7),
	/** 8 */
	MANUELL_ACCOUNT_LOCK(8),
	/** 9 */
	CHANGE_OF_PASSWORDLENGTH(9),
	/** 10 */
	CHANGE_OF_SPECIAL_SIGNS(10),
	/** 11 */
	CHANGE_OF_VALIDITY_INITIAL_PASSWORD(11),
	/** 12 */
	CHANGE_OF_PASSWORDCHANGEPERIODE(12),
	/** 13 */
	CHANGE_OF_PASSWORDHISTORY(13),
	/** 14 */
	CHANGE_OF_LOCK_AFTER_FAILURE_ATTEMPTS(14),
	/** 15 */
	CHANGE_OF_LOCK_AFTER_ANERGIC(15),
	/** 16 */
	CHANGE_OF_MAX_GRACELOGINS(16),
	/** 17 */
	CHANGE_OF_USED_UNCODED_PASSWORD(17);

	/** the kind of history id */
	private long id;

	/**
	 * Constructor
	 *
	 * @param id the kind of history id
	 */
	CbaseLoginHistKind(final long id) {
		this.id = id;
	}

	/**
	 * Get id
	 *
	 * @return the id
	 */
	public long getId() {
		return id;
	}

}
