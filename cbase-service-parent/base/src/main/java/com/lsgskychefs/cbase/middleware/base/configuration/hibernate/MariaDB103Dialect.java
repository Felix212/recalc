/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.configuration.hibernate;

import org.hibernate.LockOptions;
import org.hibernate.dialect.function.StandardSQLFunction;
import org.hibernate.type.StandardBasicTypes;

/**
 * @author Dirk Bunk - U200035
 */
public class MariaDB103Dialect extends MariaDB102Dialect {

	/**
	 * Constructor
	 */
	public MariaDB103Dialect() {
		super();

		this.registerFunction("chr", new StandardSQLFunction("chr", StandardBasicTypes.CHARACTER));
	}

	@Override
	public boolean supportsSequences() {
		return true;
	}

	@Override
	public boolean supportsPooledSequences() {
		return true;
	}

	@Override
	public String getCreateSequenceString(final String sequenceName) {
		return "create sequence " + sequenceName;
	}

	@Override
	public String getDropSequenceString(final String sequenceName) {
		return "drop sequence " + sequenceName;
	}

	@Override
	public String getSequenceNextValString(final String sequenceName) {
		return "select " + getSelectSequenceNextValString(sequenceName);
	}

	@Override
	public String getSelectSequenceNextValString(final String sequenceName) {
		return "nextval(" + sequenceName + ")";
	}

	@Override
	public String getQuerySequencesString() {
		return "select table_name from information_schema.TABLES where table_type='SEQUENCE'";
	}

	@Override
	public String getWriteLockString(final int timeout) {
		if (timeout == LockOptions.NO_WAIT) {
			return getForUpdateNowaitString();
		}

		if (timeout > 0) {
			return getForUpdateString() + " wait " + timeout;
		}

		return getForUpdateString();
	}

	@Override
	public String getForUpdateNowaitString() {
		return getForUpdateString() + " nowait";
	}

	@Override
	public String getForUpdateNowaitString(final String aliases) {
		return getForUpdateString(aliases) + " nowait";
	}

}
