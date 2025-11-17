/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;

/**
 * Marker interface for PK classes.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface DomainObjectPk extends MetaModelSupport {

	/**
	 * Generate and return a string representation of pk.
	 *
	 * @return String representation of pk
	 */
	String asString();
}
