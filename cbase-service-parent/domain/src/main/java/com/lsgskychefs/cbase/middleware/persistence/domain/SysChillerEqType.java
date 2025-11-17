package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 28, 2019 9:57:38 AM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_CHILLER_EQ_TYPE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CHILLER_EQ_TYPE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysChillerEqType implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nequipmentKey;
	private String ctype;
	private String cdescription;
	private Integer nsizeWidth;
	private Integer nsizeDepth;
	private Integer nsizeHeight;
	private byte[] bpicture;
	@JsonIgnore
	private Set<LocUnitChCapacity> locUnitChCapacities = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitChZone> locUnitChZones = new HashSet<>(0);

	@Id
	@Column(name = "NEQUIPMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(final long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "CTYPE", nullable = false, length = 10)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(final String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "CDESCRIPTION", length = 100)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSIZE_WIDTH", precision = 6, scale = 0)
	public Integer getNsizeWidth() {
		return this.nsizeWidth;
	}

	public void setNsizeWidth(final Integer nsizeWidth) {
		this.nsizeWidth = nsizeWidth;
	}

	@Column(name = "NSIZE_DEPTH", precision = 6, scale = 0)
	public Integer getNsizeDepth() {
		return this.nsizeDepth;
	}

	public void setNsizeDepth(final Integer nsizeDepth) {
		this.nsizeDepth = nsizeDepth;
	}

	@Column(name = "NSIZE_HEIGHT", precision = 6, scale = 0)
	public Integer getNsizeHeight() {
		return this.nsizeHeight;
	}

	public void setNsizeHeight(final Integer nsizeHeight) {
		this.nsizeHeight = nsizeHeight;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysChillerEqType")
	public Set<LocUnitChCapacity> getLocUnitChCapacities() {
		return this.locUnitChCapacities;
	}

	public void setLocUnitChCapacities(final Set<LocUnitChCapacity> locUnitChCapacities) {
		this.locUnitChCapacities = locUnitChCapacities;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysChillerEqType")
	public Set<LocUnitChZone> getLocUnitChZones() {
		return this.locUnitChZones;
	}

	public void setLocUnitChZones(final Set<LocUnitChZone> locUnitChZones) {
		this.locUnitChZones = locUnitChZones;
	}

}
