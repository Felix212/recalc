/*
 * Copyright (c) 2015-2023 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20-Nov-2024 14:35:02 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table LOC_UNIT_STOWAGE_BOX
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_STOWAGE_BOX"
)
public class LocUnitStowageBox implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitStowageBoxId id;
	private SysUnits sysUnits;
	private CenStowage cenStowage;
	private Integer nbox;
	private Date dtimestamp;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "nstowageKey", column = @Column(name = "NSTOWAGE_KEY", nullable = false, precision = 12, scale = 0)) })
	public LocUnitStowageBoxId getId() {
		return this.id;
	}

	public void setId(LocUnitStowageBoxId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false, insertable = false, updatable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTOWAGE_KEY", nullable = false, insertable = false, updatable = false)
	public CenStowage getCenStowage() {
		return this.cenStowage;
	}

	public void setCenStowage(CenStowage cenStowage) {
		this.cenStowage = cenStowage;
	}

	@Column(name = "NBOX", precision = 2, scale = 0)
	public Integer getNbox() {
		return this.nbox;
	}

	public void setNbox(Integer nbox) {
		this.nbox = nbox;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

}


