package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.10.2019 11:33:07 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_PL_TIME_FRAME_FLIGHT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PL_TIME_FRAME_FLIGHT", uniqueConstraints = @UniqueConstraint(columnNames = { "NVALID_INDEX", "CUNIT",
		"NPACKINGLIST_INDEX_KEY", "CFLIGHT_KEY_SHORT", "NFREQ" }))
public class LocPlTimeFrameFlight implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npltfFlightIndex;

	private SysUnits sysUnitsByCunit;

	private SysUnits sysUnitsByCboardingUnit;

	private LocUnitWsSchedule locUnitWsSchedule;

	private long nvalidIndex;

	private long npackinglistIndexKey;

	private String cflightKeyShort;

	private String cairline;

	private int nflightNumber;

	private String csuffix;

	private String ctlcFrom;

	private String ctlcTo;

	private long npltfFlightIndexGroup;

	private int nfreq;

	private int noffset;

	private Date dcreated;

	private String ccreatedBy;

	private Date dupdated;

	private String cupdatedBy;

	@Id
	@Column(name = "NPLTF_FLIGHT_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpltfFlightIndex() {
		return this.npltfFlightIndex;
	}

	public void setNpltfFlightIndex(final long npltfFlightIndex) {
		this.npltfFlightIndex = npltfFlightIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnitsByCunit() {
		return this.sysUnitsByCunit;
	}

	public void setSysUnitsByCunit(final SysUnits sysUnitsByCunit) {
		this.sysUnitsByCunit = sysUnitsByCunit;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CBOARDING_UNIT")
	public SysUnits getSysUnitsByCboardingUnit() {
		return this.sysUnitsByCboardingUnit;
	}

	public void setSysUnitsByCboardingUnit(final SysUnits sysUnitsByCboardingUnit) {
		this.sysUnitsByCboardingUnit = sysUnitsByCboardingUnit;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSCHEDULE_INDEX", nullable = false)
	public LocUnitWsSchedule getLocUnitWsSchedule() {
		return this.locUnitWsSchedule;
	}

	public void setLocUnitWsSchedule(final LocUnitWsSchedule locUnitWsSchedule) {
		this.locUnitWsSchedule = locUnitWsSchedule;
	}

	@Column(name = "NVALID_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNvalidIndex() {
		return this.nvalidIndex;
	}

	public void setNvalidIndex(final long nvalidIndex) {
		this.nvalidIndex = nvalidIndex;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CFLIGHT_KEY_SHORT", nullable = false, length = 20)
	public String getCflightKeyShort() {
		return this.cflightKeyShort;
	}

	public void setCflightKeyShort(final String cflightKeyShort) {
		this.cflightKeyShort = cflightKeyShort;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Column(name = "CTLC_FROM", nullable = false, length = 3)
	public String getCtlcFrom() {
		return this.ctlcFrom;
	}

	public void setCtlcFrom(final String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	@Column(name = "CTLC_TO", nullable = false, length = 3)
	public String getCtlcTo() {
		return this.ctlcTo;
	}

	public void setCtlcTo(final String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	@Column(name = "NPLTF_FLIGHT_INDEX_GROUP", nullable = false, precision = 12, scale = 0)
	public long getNpltfFlightIndexGroup() {
		return this.npltfFlightIndexGroup;
	}

	public void setNpltfFlightIndexGroup(final long npltfFlightIndexGroup) {
		this.npltfFlightIndexGroup = npltfFlightIndexGroup;
	}

	@Column(name = "NFREQ", nullable = false, precision = 1, scale = 0)
	public int getNfreq() {
		return this.nfreq;
	}

	public void setNfreq(final int nfreq) {
		this.nfreq = nfreq;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 3, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final int noffset) {
		this.noffset = noffset;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED", length = 7)
	public Date getDupdated() {
		return this.dupdated;
	}

	public void setDupdated(final Date dupdated) {
		this.dupdated = dupdated;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}
