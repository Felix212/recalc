/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.constant.common;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetup;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenSetupId;

/**
 * The {@link CenSetupId} fields to get a {@link CenSetup} entry. <br>
 *
 * @author Ingo Rietzschel - U125742
 */
public enum PasswordRule {

	/** Initalpassortperiod - Number of days after which an initial password is invalid */
	INITAL_PASSORT_PERIOD("Initalpassortperiod", "30"),
	/** Passwordperiod - Number of days in which a password must be changed */
	PASSWORD_PERIOD("Passwordperiod", "60"),
	/** WrongPasswordTillLock - Number of failed attempts to account Lock */
	WRONG_PASSWORD_TILL_LOCK("WrongPasswordTillLock", "5"),
	/** PasswordHistory - Number of passwords in the password history */
	PASSWORD_HISTORY("PasswordHistory", "10"),
	/** MinPasswordLenght - Minimum password length */
	MIN_PASSWORD_LENGHT("MinPasswordLenght", "8"),
	/** AllowedSymbols - Permitted special characters */
	ALLOWED_SYMBOLS("AllowedSymbols", "$@"),
	/** MaxGraceLogins - Maximal number of GraceLogins */
	MAX_GRACE_LOGINS("MaxGraceLogins", "5"),
	/** UseCpassword - consider field Cpassword */
	USE_CPASSWORD("UseCpassword", "1"),
	/** LockAfterInactivity - Lock after x days of inactivity */
	LOCK_AFTER_INACTIVITY("LockAfterInactivity", "60"),
	/** MaxChangesPerDay - max changes of day */
	MAX_CHANGES_PER_DAY("MaxChangesPerDay", "3");

	/** The key for this password rule */
	private String key;
	/** The default value for this password rule. */
	private String defaultValue;

	/** Constructor */
	PasswordRule(final String key, final String defaultValue) {
		this.key = key;
		this.defaultValue = defaultValue;
	}

	/**
	 * Get password rule key( {@link CenSetupId#getCkey()}
	 *
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * Get the default value for this passowrd rule
	 *
	 * @return the defaultValue
	 */
	public String getDefaultValue() {
		return defaultValue;
	}

	/**
	 * The section value for password rules
	 *
	 * @return the section value {@link CenSetupId#getCsection()}
	 */
	public static String getSection() {
		return "Passwordrules";
	}

}
