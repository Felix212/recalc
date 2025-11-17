/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.pojo;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/**
 * Super class for our POJO helper classes(Plain Old Java Object), with default implementation of toString()-Methods.
 *
 * @author Ingo Rietzschel - U125742
 */
public abstract class AbstractPojo implements Pojo {

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
