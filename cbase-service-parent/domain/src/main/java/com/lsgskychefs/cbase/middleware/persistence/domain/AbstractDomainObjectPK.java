/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * Provide toString() and as String Method.
 *
 * @author Ingo Rietzschel - U125742
 */
public class AbstractDomainObjectPK implements DomainObjectPk {

	@Override
	public String asString() {
		return ToStringBuilder.reflectionToString(this);
	}

	@Override
	public String toString() {
		return asString();
	}

}
