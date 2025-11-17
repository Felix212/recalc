/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.common.pojo;

import com.lsgskychefs.cbase.middleware.persistence.pojo.AbstractPojo;
import com.lsgskychefs.cbase.middleware.persistence.pojo.CbaseMiddlewareEntry;

/**
 * Entry contains the values for native query check_user_has_role.sql.
 *
 * @author Heiko Rothenbach
 */
public class CheckUserHasRoleEntry extends AbstractPojo implements CbaseMiddlewareEntry {

	/** nrolecount */
	private long nrolecount;

	public long getNrolecount() {
		return nrolecount;
	}

	public void setNrolecount(final long nrolecount) {
		this.nrolecount = nrolecount;
	}

}
