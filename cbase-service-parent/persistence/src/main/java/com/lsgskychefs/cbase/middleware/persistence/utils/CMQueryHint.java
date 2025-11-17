/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.utils;

import java.util.LinkedHashMap;

/**
 * Helper class for simple generation of vendor-specific properties and hints
 *
 * @author Ingo Rietzschel - U125742
 */
public class CMQueryHint extends LinkedHashMap<String, Object> {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/**
	 * Create a new CMQueryHint map.
	 *
	 * @return created map
	 */
	public static CMQueryHint map() {
		return new CMQueryHint();
	}

	/**
	 * Create a new CMQueryHint and put the given key-value pair.
	 *
	 * @param key the key of entry
	 * @param value the value of entry
	 * @return created map
	 */
	public static CMQueryHint putC(final String key, final Object value) {
		return map().putR(key, value);
	}

	/**
	 * Put the given key-value pair into current map.
	 * 
	 * @param key the key of entry
	 * @param value the value of entry
	 * @return current map
	 */
	public CMQueryHint putR(final String key, final Object value) {
		super.put(key, value);
		return this;
	}

	/**
	 * Put the 'javax.persistence.lock.timeout' query hint property into the map.
	 *
	 * @param timeout the time out in millisecond
	 * @return current map
	 */
	public CMQueryHint putLockTimeOut(final String timeout) {
		return putR("javax.persistence.lock.timeout", timeout);
	}

}
