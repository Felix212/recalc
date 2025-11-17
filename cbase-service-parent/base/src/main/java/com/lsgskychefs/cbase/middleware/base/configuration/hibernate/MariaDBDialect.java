/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.hibernate;

import org.hibernate.dialect.MySQL5Dialect;

/**
 * @author Dirk Bunk - U200035
 */
public class MariaDBDialect extends MySQL5Dialect {
	/**
	 * Constructor
	 */
	public MariaDBDialect() {
		super();
	}

	/**
	 * Enable dialect support for row values in IN lists
	 * 
	 * @return <code>true</code>
	 */
	public boolean supportsRowValueConstructorSyntaxInInList() {
		return true;
	}
}
