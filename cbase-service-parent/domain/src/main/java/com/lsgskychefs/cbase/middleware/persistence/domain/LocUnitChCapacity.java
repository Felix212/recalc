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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_CAPACITY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CH_CAPACITY")
public class LocUnitChCapacity implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncapacityKey;
	private SysChillerEqType sysChillerEqType;
	@JsonIgnore
	private LocUnitChWarehouse locUnitChWarehouse;
	private Integer nquantity;
	@JsonIgnore
	private Set<LocUnitChStorageBin> locUnitChStorageBins = new HashSet<>(0);

	@Id
	@Column(name = "NCAPACITY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcapacityKey() {
		return this.ncapacityKey;
	}

	public void setNcapacityKey(final long ncapacityKey) {
		this.ncapacityKey = ncapacityKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEQUIPMENT_KEY", nullable = false)
	public SysChillerEqType getSysChillerEqType() {
		return this.sysChillerEqType;
	}

	public void setSysChillerEqType(final SysChillerEqType sysChillerEqType) {
		this.sysChillerEqType = sysChillerEqType;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWAREHOUSE_KEY", nullable = false)
	public LocUnitChWarehouse getLocUnitChWarehouse() {
		return this.locUnitChWarehouse;
	}

	public void setLocUnitChWarehouse(final LocUnitChWarehouse locUnitChWarehouse) {
		this.locUnitChWarehouse = locUnitChWarehouse;
	}

	@Column(name = "NQUANTITY", precision = 5, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChCapacity")
	public Set<LocUnitChStorageBin> getLocUnitChStorageBins() {
		return this.locUnitChStorageBins;
	}

	public void setLocUnitChStorageBins(final Set<LocUnitChStorageBin> locUnitChStorageBins) {
		this.locUnitChStorageBins = locUnitChStorageBins;
	}

}
