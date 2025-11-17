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

/**
 * Entity(DomainObject) for table LOC_UNIT_TRAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TRAIL")
public class LocUnitTrail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ntrailKey;
	private SysUnits sysUnits;
	private String cclient;
	private String ctrail;
	private String cdescription;
	private int nsort;
	private Set<LocUnitTrailDetail> locUnitTrailDetails = new HashSet<>(0);

	@Id
	@Column(name = "NTRAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNtrailKey() {
		return this.ntrailKey;
	}

	public void setNtrailKey(final long ntrailKey) {
		this.ntrailKey = ntrailKey;
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

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CTRAIL", nullable = false, length = 40)
	public String getCtrail() {
		return this.ctrail;
	}

	public void setCtrail(final String ctrail) {
		this.ctrail = ctrail;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitTrail")
	public Set<LocUnitTrailDetail> getLocUnitTrailDetails() {
		return this.locUnitTrailDetails;
	}

	public void setLocUnitTrailDetails(final Set<LocUnitTrailDetail> locUnitTrailDetails) {
		this.locUnitTrailDetails = locUnitTrailDetails;
	}

}
