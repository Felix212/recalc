/*
 * SysMsgDelivery.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.01.2016 12:07:25 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_MSG_DELIVERY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_MSG_DELIVERY")
public class SysMsgDelivery implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysMsgDeliveryId id;
	private SysMsgMessages sysMsgMessages;
	private String csessionid;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cqueue", column = @Column(name = "CQUEUE", nullable = false, length = 256)),
			@AttributeOverride(name = "nmessageKey",
					column = @Column(name = "NMESSAGE_KEY", nullable = false, precision = 12, scale = 0)) })
	public SysMsgDeliveryId getId() {
		return this.id;
	}

	public void setId(final SysMsgDeliveryId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "NMESSAGE_KEY", nullable = false, insertable = false, updatable = false)
	public SysMsgMessages getSysMsgMessages() {
		return this.sysMsgMessages;
	}

	public void setSysMsgMessages(final SysMsgMessages sysMsgMessages) {
		this.sysMsgMessages = sysMsgMessages;
	}

	@Column(name = "CSESSIONID", length = 32)
	public String getCsessionid() {
		return this.csessionid;
	}

	public void setCsessionid(final String csessionid) {
		this.csessionid = csessionid;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = true, length = 6)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}
