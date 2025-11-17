package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.Transient;

import org.apache.commons.lang3.ObjectUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_WAREHOUSE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CH_WAREHOUSE")
public class LocUnitChWarehouse implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nwarehouseKey;
	@JsonIgnore
	private SysUnits sysUnits;
	private String cwarehouse;
	private String cdescription;
	private Long nfloorplanKey;
	@JsonIgnore
	private Set<LocUnitChDefLayout> locUnitChDefLayouts = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitChCapacity> locUnitChCapacities = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitChRule> locUnitChRules = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitChZone> locUnitChZones = new HashSet<>(0);
	@JsonIgnore
	private Set<LocWarehouseFloorplan> locWarehouseFloorplans = new HashSet<>(0);

	@Id
	@Column(name = "NWAREHOUSE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNwarehouseKey() {
		return this.nwarehouseKey;
	}

	public void setNwarehouseKey(final long nwarehouseKey) {
		this.nwarehouseKey = nwarehouseKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CWAREHOUSE", length = 50)
	public String getCwarehouse() {
		return this.cwarehouse;
	}

	public void setCwarehouse(final String cwarehouse) {
		this.cwarehouse = cwarehouse;
	}

	@Column(name = "CDESCRIPTION", length = 100)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChWarehouse")
	public Set<LocUnitChDefLayout> getLocUnitChDefLayouts() {
		return this.locUnitChDefLayouts;
	}

	public void setLocUnitChDefLayouts(final Set<LocUnitChDefLayout> locUnitChDefLayouts) {
		this.locUnitChDefLayouts = locUnitChDefLayouts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChWarehouse")
	public Set<LocUnitChCapacity> getLocUnitChCapacities() {
		return this.locUnitChCapacities;
	}

	public void setLocUnitChCapacities(final Set<LocUnitChCapacity> locUnitChCapacities) {
		this.locUnitChCapacities = locUnitChCapacities;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChWarehouse")
	public Set<LocUnitChRule> getLocUnitChRules() {
		return this.locUnitChRules;
	}

	public void setLocUnitChRules(final Set<LocUnitChRule> locUnitChRules) {
		this.locUnitChRules = locUnitChRules;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChWarehouse")
	public Set<LocUnitChZone> getLocUnitChZones() {
		return this.locUnitChZones;
	}

	public void setLocUnitChZones(final Set<LocUnitChZone> locUnitChZones) {
		this.locUnitChZones = locUnitChZones;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChWarehouse")
	public Set<LocWarehouseFloorplan> getLocWarehouseFloorplans() {
		return this.locWarehouseFloorplans;
	}

	public void setLocWarehouseFloorplans(final Set<LocWarehouseFloorplan> locWarehouseFloorplans) {
		this.locWarehouseFloorplans = locWarehouseFloorplans;
	}

	@Transient
	public Long getNfloorplanKey() {
		final LocWarehouseFloorplan floorplan = (LocWarehouseFloorplan) ObjectUtils.firstNonNull(locWarehouseFloorplans.toArray());
		if (floorplan != null) {
			nfloorplanKey = floorplan.getNfloorplanKey();
		}
		return nfloorplanKey;
	}

}
