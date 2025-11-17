package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
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

/**
 * Entity(DomainObject) for table LOC_UNIT_WS_SCHEDULE (workstation shift)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_WS_SCHEDULE")
public class LocUnitWsSchedule implements DomainObject, Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nworkscheduleIndex;
	private LocUnitPpmValidities locUnitPpmValidities;
	private long nareaKey;
	private long nvalidIndex;
	private long nworkstationKey;
	private String cschedule;
	private String cdescription;
	private String ctimefrom;
	private String ctimeto;
	private int noffset;
	private Long ncolor;
	private Integer nsort;
	private boolean nuseEmpCount;
	private Set<LocPlTimeFrame> locPlTimeFrames = new HashSet<>(0);
	private Set<LocUnitWsEmp> locUnitWsEmps = new HashSet<>(0);
	private LocUnitWorkstation locUnitWorkstation;
	private Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases = new HashSet<>(0);
	private Set<LocUnitWsScheduleOffset> locUnitWsScheduleOffsets = new HashSet<>();

	@Id
	@Column(name = "NWORKSCHEDULE_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(final long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NVALID_INDEX", nullable = false)
	public LocUnitPpmValidities getLocUnitPpmValidities() {
		return this.locUnitPpmValidities;
	}

	public void setLocUnitPpmValidities(final LocUnitPpmValidities locUnitPpmValidities) {
		this.locUnitPpmValidities = locUnitPpmValidities;
	}

	@Column(name = "NAREA_KEY", nullable = false, precision = 12, scale = 0)
	public long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return locUnitWorkstation;
	}

	public void setLocUnitWorkstation(final LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@Column(name = "NWORKSTATION_KEY", insertable = false, updatable = false, nullable = false, precision = 12, scale = 0)
	public long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "CSCHEDULE", nullable = false, length = 40)
	public String getCschedule() {
		return this.cschedule;
	}

	public void setCschedule(final String cschedule) {
		this.cschedule = cschedule;
	}

	@Column(name = "CDESCRIPTION", length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CTIMEFROM", length = 5)
	public String getCtimefrom() {
		return this.ctimefrom;
	}

	public void setCtimefrom(final String ctimefrom) {
		this.ctimefrom = ctimefrom;
	}

	@Column(name = "CTIMETO", length = 5)
	public String getCtimeto() {
		return this.ctimeto;
	}

	public void setCtimeto(final String ctimeto) {
		this.ctimeto = ctimeto;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 3, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(final int noffset) {
		this.noffset = noffset;
	}

	@Column(name = "NCOLOR", precision = 12, scale = 0)
	public Long getNcolor() {
		return this.ncolor;
	}

	public void setNcolor(final Long ncolor) {
		this.ncolor = ncolor;
	}

	@Column(name = "NSORT", precision = 6, scale = 0)
	public Integer getNsort() {
		return this.nsort;
	}

	public void setNsort(final Integer nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NUSE_EMP_COUNT", nullable = false, precision = 1, scale = 0)
	public boolean isNuseEmpCount() {
		return this.nuseEmpCount;
	}

	public void setNuseEmpCount(final boolean nuseEmpCount) {
		this.nuseEmpCount = nuseEmpCount;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWsSchedule")
	public Set<LocPlTimeFrame> getLocPlTimeFrames() {
		return this.locPlTimeFrames;
	}

	public void setLocPlTimeFrames(final Set<LocPlTimeFrame> locPlTimeFrames) {
		this.locPlTimeFrames = locPlTimeFrames;
	}

	/**
	 * Mapped FK attribute
	 *
	 * @return
	 */
	@Column(name = "NVALID_INDEX", updatable = false, insertable = false)
	public long getNvalidIndex() {
		return nvalidIndex;
	}

	/**
	 * Mapped FK attribute
	 *
	 * @param nvalidIndex the nvalidIndex to set
	 */
	public void setNvalidIndex(final long nvalidIndex) {
		this.nvalidIndex = nvalidIndex;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWsSchedule")
	public Set<LocUnitWsEmp> getLocUnitWsEmps() {
		return this.locUnitWsEmps;
	}

	public void setLocUnitWsEmps(final Set<LocUnitWsEmp> locUnitWsEmps) {
		this.locUnitWsEmps = locUnitWsEmps;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWsSchedule")
	public Set<LocUnitWsSchedIncrease> getLocUnitWsSchedIncreases() {
		return this.locUnitWsSchedIncreases;
	}

	public void setLocUnitWsSchedIncreases(final Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases) {
		this.locUnitWsSchedIncreases = locUnitWsSchedIncreases;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWsSchedule")
	public Set<LocUnitWsScheduleOffset> getLocUnitWsScheduleOffsets() {
		return locUnitWsScheduleOffsets;
	}

	public void setLocUnitWsScheduleOffsets(final Set<LocUnitWsScheduleOffset> locUnitWsScheduleOffsets) {
		this.locUnitWsScheduleOffsets = locUnitWsScheduleOffsets;
	}

}
