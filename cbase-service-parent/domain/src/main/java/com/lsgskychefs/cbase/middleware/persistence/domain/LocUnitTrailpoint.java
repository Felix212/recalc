package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Apr 5, 2017 12:15:04 PM by Hibernate Tools 4.3.5.Final

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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_TRAILPOINT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TRAILPOINT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitTrailpoint implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntrailpointKey;

	private SysUnits sysUnits;

	private String cclient;

	private String ctrailpoint;

	private String cdescription;

	private int nsort;

	private long ntrailpointActionKey;

	private Long ntrailpointKeyBro;

	private Long ntrailpointGroupKey;

	private int nstorageTransaction;

	private Set<LocUnitTrailDetail> locUnitTrailDetails = new HashSet<>(0);

	private Set<LocUnitBeacon> locUnitBeacons = new HashSet<>(0);

	private Set<CenOutPpmPrLabSpotch> cenOutPpmPrLabSpotches = new HashSet<>(0);

	@Id
	@Column(name = "NTRAILPOINT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNtrailpointKey() {
		return this.ntrailpointKey;
	}

	public void setNtrailpointKey(final long ntrailpointKey) {
		this.ntrailpointKey = ntrailpointKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	@JsonIgnore
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CTRAILPOINT", nullable = false, length = 40)
	public String getCtrailpoint() {
		return this.ctrailpoint;
	}

	public void setCtrailpoint(final String ctrailpoint) {
		this.ctrailpoint = ctrailpoint;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@JsonView(View.Simple.class)
	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@JsonView(View.Simple.class)
	@Column(name = "NTRAILPOINT_ACTION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNtrailpointActionKey() {
		return this.ntrailpointActionKey;
	}

	public void setNtrailpointActionKey(final long ntrailpointActionKey) {
		this.ntrailpointActionKey = ntrailpointActionKey;
	}

	@JsonView(View.Simple.class)
	@Column(name = "NTRAILPOINT_KEY_BRO", precision = 12, scale = 0)
	public Long getNtrailpointKeyBro() {
		return this.ntrailpointKeyBro;
	}

	public void setNtrailpointKeyBro(final Long ntrailpointKeyBro) {
		this.ntrailpointKeyBro = ntrailpointKeyBro;
	}

	@JsonView(View.Simple.class)
	@Column(name = "NTRAILPOINT_GROUP_KEY", precision = 12, scale = 0)
	public Long getNtrailpointGroupKey() {
		return ntrailpointGroupKey;
	}

	public void setNtrailpointGroupKey(final Long ntrailpointGroupKey) {
		this.ntrailpointGroupKey = ntrailpointGroupKey;
	}

	@Column(name = "NSTORAGE_TRANSACTION", nullable = false, precision = 1, scale = 0)
	public int getNstorageTransaction() {
		return this.nstorageTransaction;
	}

	public void setNstorageTransaction(final int nstorageTransaction) {
		this.nstorageTransaction = nstorageTransaction;
	}

	@JsonView(View.FullWithReferences.class)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitTrailpoint")
	public Set<LocUnitTrailDetail> getLocUnitTrailDetails() {
		return this.locUnitTrailDetails;
	}

	public void setLocUnitTrailDetails(final Set<LocUnitTrailDetail> locUnitTrailDetails) {
		this.locUnitTrailDetails = locUnitTrailDetails;
	}

	@JsonView(View.SimpleWithReferences.class)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitTrailpoint")
	public Set<LocUnitBeacon> getLocUnitBeacons() {
		return this.locUnitBeacons;
	}

	public void setLocUnitBeacons(final Set<LocUnitBeacon> locUnitBeacons) {
		this.locUnitBeacons = locUnitBeacons;
	}

	@JsonView(View.FullWithReferences.class)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitTrailpoint")
	public Set<CenOutPpmPrLabSpotch> getCenOutPpmPrLabSpotches() {
		return this.cenOutPpmPrLabSpotches;
	}

	public void setCenOutPpmPrLabSpotches(final Set<CenOutPpmPrLabSpotch> cenOutPpmPrLabSpotches) {
		this.cenOutPpmPrLabSpotches = cenOutPpmPrLabSpotches;
	}

}
