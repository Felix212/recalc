/*
 * Copyright (c) 2015-2023 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20-Nov-2024 13:48:40 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_AIRCRAFT_GROUP_STOWAGE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRCRAFT_GROUP_STOWAGE"
)
public class CenAircraftGroupStowage implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private long nacStowageGroupKey;
	private CenGalley cenGalley;
	private CenAircraftGroup cenAircraftGroup;
	private CenStowage cenStowage;

	@Id
	@Column(name = "NAC_STOWAGE_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNacStowageGroupKey() {
		return this.nacStowageGroupKey;
	}

	public void setNacStowageGroupKey(long nacStowageGroupKey) {
		this.nacStowageGroupKey = nacStowageGroupKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGALLEY_KEY", nullable = false)
	public CenGalley getCenGalley() {
		return this.cenGalley;
	}

	public void setCenGalley(CenGalley cenGalley) {
		this.cenGalley = cenGalley;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_GROUP_KEY", nullable = false)
	public CenAircraftGroup getCenAircraftGroup() {
		return this.cenAircraftGroup;
	}

	public void setCenAircraftGroup(CenAircraftGroup cenAircraftGroup) {
		this.cenAircraftGroup = cenAircraftGroup;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTOWAGE_KEY", nullable = false)
	public CenStowage getCenStowage() {
		return this.cenStowage;
	}

	public void setCenStowage(CenStowage cenStowage) {
		this.cenStowage = cenStowage;
	}

}


