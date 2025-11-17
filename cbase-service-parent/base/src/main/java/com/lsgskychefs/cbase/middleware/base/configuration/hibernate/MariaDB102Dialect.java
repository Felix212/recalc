/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.hibernate;

import java.sql.Types;

import org.hibernate.dialect.function.StandardSQLFunction;
import org.hibernate.type.StandardBasicTypes;

/**
 * @author Dirk Bunk - U200035
 */
public class MariaDB102Dialect extends MariaDB10Dialect {

	/**
	 * Constructor
	 */
	public MariaDB102Dialect() {
		super();

		this.registerColumnType(Types.JAVA_OBJECT, "json");
		this.registerFunction("json_valid", new StandardSQLFunction("json_valid", StandardBasicTypes.NUMERIC_BOOLEAN));

	}

	@Override
	public boolean supportsColumnCheck() {
		return true;
	}
}
