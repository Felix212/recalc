/*
 * Copyright (c) 2015-2023 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 20-Nov-2024 13:48:40 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_AIRCRAFT_GROUP
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRCRAFT_GROUP"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "CTEXT", "NAIRCRAFT_KEY" })
)
public class CenAircraftGroup implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private long naircraftGroupKey;
	private CenAircraft cenAircraft;
	private long nairlineKey;
	private String ctext;
	private int nsort;
	private int ndefault;
	private Set<CenAircraftGroupStowage> cenAircraftGroupStowages = new HashSet<>(0);

	@Id
	@Column(name = "NAIRCRAFT_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNaircraftGroupKey() {
		return this.naircraftGroupKey;
	}

	public void setNaircraftGroupKey(long naircraftGroupKey) {
		this.naircraftGroupKey = naircraftGroupKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(int ndefault) {
		this.ndefault = ndefault;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenAircraftGroup")
	public Set<CenAircraftGroupStowage> getCenAircraftGroupStowages() {
		return this.cenAircraftGroupStowages;
	}

	public void setCenAircraftGroupStowages(Set<CenAircraftGroupStowage> cenAircraftGroupStowages) {
		this.cenAircraftGroupStowages = cenAircraftGroupStowages;
	}

}


