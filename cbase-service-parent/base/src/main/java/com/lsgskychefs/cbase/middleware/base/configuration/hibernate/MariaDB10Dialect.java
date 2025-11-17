/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.hibernate;

import org.hibernate.dialect.function.StandardSQLFunction;
import org.hibernate.type.StandardBasicTypes;

/**
 * @author Dirk Bunk - U200035
 */
public class MariaDB10Dialect extends MariaDB53Dialect {

	/**
	 * Constructor
	 */
	public MariaDB10Dialect() {
		super();

		registerFunction("regexp_replace", new StandardSQLFunction("regexp_replace", StandardBasicTypes.STRING));
		registerFunction("regexp_instr", new StandardSQLFunction("regexp_instr", StandardBasicTypes.INTEGER));
		registerFunction("regexp_substr", new StandardSQLFunction("regexp_substr", StandardBasicTypes.STRING));
		registerFunction("weight_string", new StandardSQLFunction("weight_string", StandardBasicTypes.STRING));
		registerFunction("to_base64", new StandardSQLFunction("to_base64", StandardBasicTypes.STRING));
		registerFunction("from_base64", new StandardSQLFunction("from_base64", StandardBasicTypes.STRING));
	}

	@Override
	public boolean supportsIfExistsBeforeConstraintName() {
		return true;
	}
}
