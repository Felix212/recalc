/*
 * SysMsgMessages.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 29.01.2016 12:07:25 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_MSG_MESSAGES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_MSG_MESSAGES")
public class SysMsgMessages implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmessageKey;

	private String ctopic;

	private Date dtimestamp;

	private String cdata;

	private Set<SysMsgDelivery> sysMsgDeliveries = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_MSG_MESSAGES")
	@SequenceGenerator(name = "SEQ_SYS_MSG_MESSAGES", sequenceName = "SEQ_SYS_MSG_MESSAGES", allocationSize = 1)
	@Column(name = "NMESSAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmessageKey() {
		return this.nmessageKey;
	}

	public void setNmessageKey(final long nmessageKey) {
		this.nmessageKey = nmessageKey;
	}

	@Column(name = "CTOPIC", nullable = false, length = 256)
	public String getCtopic() {
		return this.ctopic;
	}

	public void setCtopic(final String ctopic) {
		this.ctopic = ctopic;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 6)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CDATA", length = 2000)
	public String getCdata() {
		return this.cdata;
	}

	public void setCdata(final String cdata) {
		this.cdata = cdata;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysMsgMessages", cascade = CascadeType.PERSIST)
	public Set<SysMsgDelivery> getSysMsgDeliveries() {
		return this.sysMsgDeliveries;
	}

	public void setSysMsgDeliveries(final Set<SysMsgDelivery> sysMsgDeliveries) {
		this.sysMsgDeliveries = sysMsgDeliveries;
	}

}
