package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_CH_STORAGE_BIN
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CH_STORAGE_BIN")
public class LocUnitChStorageBin implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nstorageBinKey;
	@JsonIgnore
	private LocUnitChCapacity locUnitChCapacity;
	private long nequipmentKey;
	private String cstowage;
	private Integer nsize;
	@JsonIgnore
	private Set<LocUnitChZone> locUnitChZones = new HashSet<>(0);

	@Id
	@Column(name = "NSTORAGE_BIN_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNstorageBinKey() {
		return this.nstorageBinKey;
	}

	@JsonView(View.Simple.class)
	public void setNstorageBinKey(final long nstorageBinKey) {
		this.nstorageBinKey = nstorageBinKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCAPACITY_KEY")
	public LocUnitChCapacity getLocUnitChCapacity() {
		return this.locUnitChCapacity;
	}

	public void setLocUnitChCapacity(final LocUnitChCapacity locUnitChCapacity) {
		this.locUnitChCapacity = locUnitChCapacity;
	}

	@Column(name = "NEQUIPMENT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	@JsonView(View.Simple.class)
	public void setNequipmentKey(final long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "CSTOWAGE", length = 40)
	public String getCstowage() {
		return this.cstowage;
	}

	@JsonView(View.Simple.class)
	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "NSIZE", precision = 5, scale = 0)
	public Integer getNsize() {
		return this.nsize;
	}

	@JsonView(View.Simple.class)
	public void setNsize(final Integer nsize) {
		this.nsize = nsize;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "locUnitChStorageBins")
	public Set<LocUnitChZone> getLocUnitChZones() {
		return this.locUnitChZones;
	}

	public void setLocUnitChZones(final Set<LocUnitChZone> locUnitChZones) {
		this.locUnitChZones = locUnitChZones;
	}

}
