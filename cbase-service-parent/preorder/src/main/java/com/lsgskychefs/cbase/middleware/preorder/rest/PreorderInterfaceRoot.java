/*
 *SalesInterfaceRoot.java
 *
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.preorder.rest;

import com.lsgskychefs.cbase.middleware.base.rest.RestInterfaceRoot;


public final class PreorderInterfaceRoot {

	/** The root context for the rest services of this module. */
	public static final String call = RestInterfaceRoot.REST_API_ROOT + "/call";


	/**
	 * Private Constructor.
	 */
	private PreorderInterfaceRoot() {
		// do nothing.
	}

}
