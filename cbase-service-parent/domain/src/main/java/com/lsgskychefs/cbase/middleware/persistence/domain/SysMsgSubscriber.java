/*
 * SysMsgSubscriber.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.01.2016 12:07:25 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_MSG_SUBSCRIBER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_MSG_SUBSCRIBER")
public class SysMsgSubscriber implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysMsgSubscriberId id;

	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cqueue", column = @Column(name = "CQUEUE", nullable = false, length = 256)),
			@AttributeOverride(name = "ctopic", column = @Column(name = "CTOPIC", nullable = false, length = 256)) })
	public SysMsgSubscriberId getId() {
		return this.id;
	}

	public void setId(final SysMsgSubscriberId id) {
		this.id = id;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 6)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
