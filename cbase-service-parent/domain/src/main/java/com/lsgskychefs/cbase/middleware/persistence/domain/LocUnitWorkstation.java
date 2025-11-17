package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table LOC_UNIT_WORKSTATION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_WORKSTATION", uniqueConstraints = { @UniqueConstraint(columnNames = { "NAREA_KEY", "CWORKSTATION" }),
		@UniqueConstraint(columnNames = { "NAREA_KEY", "CTEXT" }) })
public class LocUnitWorkstation implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nworkstationKey;
	@JsonIgnore
	private long nareaKey;
	@JsonIgnore
	private LocUnitAreas locUnitAreas;
	private String cworkstation;
	private String ctext;

	private int ndefault;
	@JsonIgnore
	private Long nworkstationGroupKey;
	@JsonIgnore
	private Date dlastCheck;
	@JsonIgnore
	private Integer nfollowUpTime;
	@JsonIgnore
	private Integer nacWorkstation;
	@JsonIgnore
	private Integer npps;
	@JsonIgnore
	private Integer nexcludeDiagram;
	@JsonIgnore
	private String cworkcenter;
	@JsonIgnore
	private Long ncoldstoreKey;
	@JsonIgnore
	private byte[] bpicture;
	@JsonIgnore
	private int ncumulateWorkorderSeq;
	@JsonIgnore
	private Long nworkscheduleIndexIncrease;
	@JsonIgnore
	private int nalldayMode;
	@JsonIgnore
	private int nschedAssignMode;
	@JsonIgnore
	private Integer nmode;
	@JsonIgnore
	private Set<LocUnitLabelArea> locUnitLabelAreas = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitWsSchedule> locUnitWsSchedules;
	@JsonIgnore
	private Set<LocPloShift> locPloShifts = new HashSet<>(0);
	@JsonIgnore
	private Set<LocPloItemlist> locPloItemlists = new HashSet<>(0);
	@JsonIgnore
	private Set<LocPloWsShiftBreak> locPloWsShiftBreaks = new HashSet<>(0);

	@JsonIgnore
	private Set<LocPreprodPlArea> locPreprodPlAreas = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_WORKSTATION")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_WORKSTATION", sequenceName = "SEQ_LOC_UNIT_WORKSTATION", allocationSize = 1)
	@Column(name = "NWORKSTATION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNworkstationKey() {
		return this.nworkstationKey;
	}

	@JsonView(View.Simple.class)
	public void setNworkstationKey(final long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAREA_KEY", nullable = false)
	public LocUnitAreas getLocUnitAreas() {
		return this.locUnitAreas;
	}

	public void setLocUnitAreas(final LocUnitAreas locUnitAreas) {
		this.locUnitAreas = locUnitAreas;
	}

	@Column(name = "CWORKSTATION", nullable = false, length = 12)
	public String getCworkstation() {
		return this.cworkstation;
	}

	@JsonView(View.Simple.class)
	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	@JsonView(View.Simple.class)
	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final int ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NWORKSTATION_GROUP_KEY", precision = 12, scale = 0)
	public Long getNworkstationGroupKey() {
		return this.nworkstationGroupKey;
	}

	public void setNworkstationGroupKey(final Long nworkstationGroupKey) {
		this.nworkstationGroupKey = nworkstationGroupKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLAST_CHECK", length = 7)
	public Date getDlastCheck() {
		return this.dlastCheck;
	}

	public void setDlastCheck(final Date dlastCheck) {
		this.dlastCheck = dlastCheck;
	}

	@Column(name = "NFOLLOW_UP_TIME", precision = 4, scale = 0)
	public Integer getNfollowUpTime() {
		return this.nfollowUpTime;
	}

	public void setNfollowUpTime(final Integer nfollowUpTime) {
		this.nfollowUpTime = nfollowUpTime;
	}

	@Column(name = "NAC_WORKSTATION", precision = 1, scale = 0)
	public Integer getNacWorkstation() {
		return this.nacWorkstation;
	}

	public void setNacWorkstation(final Integer nacWorkstation) {
		this.nacWorkstation = nacWorkstation;
	}

	@Column(name = "NPPS", precision = 1, scale = 0)
	public Integer getNpps() {
		return this.npps;
	}

	public void setNpps(final Integer npps) {
		this.npps = npps;
	}

	@Column(name = "NEXCLUDE_DIAGRAM", precision = 1, scale = 0, columnDefinition = "number(1,0) default 0")
	public Integer getNexcludeDiagram() {
		return this.nexcludeDiagram;
	}

	public void setNexcludeDiagram(final Integer nexcludeDiagram) {
		this.nexcludeDiagram = nexcludeDiagram;
	}

	@Column(name = "CWORKCENTER", length = 8)
	public String getCworkcenter() {
		return this.cworkcenter;
	}

	public void setCworkcenter(final String cworkcenter) {
		this.cworkcenter = cworkcenter;
	}

	@Column(name = "NCOLDSTORE_KEY", precision = 12, scale = 0)
	public Long getNcoldstoreKey() {
		return this.ncoldstoreKey;
	}

	public void setNcoldstoreKey(final Long ncoldstoreKey) {
		this.ncoldstoreKey = ncoldstoreKey;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@Column(name = "NCUMULATE_WORKORDER_SEQ", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1,0) default 1")
	public int getNcumulateWorkorderSeq() {
		return this.ncumulateWorkorderSeq;
	}

	public void setNcumulateWorkorderSeq(final int ncumulateWorkorderSeq) {
		this.ncumulateWorkorderSeq = ncumulateWorkorderSeq;
	}

	@Column(name = "NWORKSCHEDULE_INDEX_INCREASE", precision = 12, scale = 0)
	public Long getNworkscheduleIndexIncrease() {
		return this.nworkscheduleIndexIncrease;
	}

	public void setNworkscheduleIndexIncrease(final Long nworkscheduleIndexIncrease) {
		this.nworkscheduleIndexIncrease = nworkscheduleIndexIncrease;
	}

	@Column(name = "NALLDAY_MODE", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1,0) default 1")
	public int getNalldayMode() {
		return this.nalldayMode;
	}

	public void setNalldayMode(final int nalldayMode) {
		this.nalldayMode = nalldayMode;
	}

	@Column(name = "NSCHED_ASSIGN_MODE", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1,0) default 1")
	public int getNschedAssignMode() {
		return this.nschedAssignMode;
	}

	public void setNschedAssignMode(final int nschedAssignMode) {
		this.nschedAssignMode = nschedAssignMode;
	}

	@Column(name = "NMODE", precision = 1)
	public Integer getNmode() {
		return this.nmode;
	}

	public void setNmode(final Integer nmode) {
		this.nmode = nmode;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocUnitLabelArea> getLocUnitLabelAreas() {
		return this.locUnitLabelAreas;
	}

	public void setLocUnitLabelAreas(final Set<LocUnitLabelArea> locUnitLabelAreas) {
		this.locUnitLabelAreas = locUnitLabelAreas;
	}

	/**
	 * @return the locUnitWsSchedules
	 */
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocUnitWsSchedule> getLocUnitWsSchedules() {
		return locUnitWsSchedules;
	}

	/**
	 * @param locUnitWsSchedules the locUnitWsSchedule to set
	 */
	public void setLocUnitWsSchedules(final Set<LocUnitWsSchedule> locUnitWsSchedules) {
		this.locUnitWsSchedules = locUnitWsSchedules;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocUnitWsSchedIncrease> getLocUnitWsSchedIncreases() {
		return this.locUnitWsSchedIncreases;
	}

	public void setLocUnitWsSchedIncreases(final Set<LocUnitWsSchedIncrease> locUnitWsSchedIncreases) {
		this.locUnitWsSchedIncreases = locUnitWsSchedIncreases;
	}

	/**
	 * Get nareaKey
	 *
	 * @return the nareaKey
	 */
	@Column(name = "NAREA_KEY", insertable = false, updatable = false)
	public long getNareaKey() {
		return nareaKey;
	}

	/**
	 * set nareaKey
	 *
	 * @param nareaKey the nareaKey to set
	 */
	public void setNareaKey(final long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "LOC_PLO_WS_SHIFT", joinColumns = {
			@JoinColumn(name = "NWORKSTATION_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
			@JoinColumn(name = "NSHIFT_KEY", nullable = false, updatable = false) })
	public Set<LocPloShift> getLocPloShifts() {
		return this.locPloShifts;
	}

	public void setLocPloShifts(final Set<LocPloShift> locPloShifts) {
		this.locPloShifts = locPloShifts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocPloItemlist> getLocPloItemlists() {
		return this.locPloItemlists;
	}

	public void setLocPloItemlists(final Set<LocPloItemlist> locPloItemlists) {
		this.locPloItemlists = locPloItemlists;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocPloWsShiftBreak> getLocPloWsShiftBreaks() {
		return this.locPloWsShiftBreaks;
	}

	public void setLocPloWsShiftBreaks(final Set<LocPloWsShiftBreak> locPloWsShiftBreaks) {
		this.locPloWsShiftBreaks = locPloWsShiftBreaks;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitWorkstation")
	public Set<LocPreprodPlArea> getLocPreprodPlAreas() {
		return this.locPreprodPlAreas;
	}

	public void setLocPreprodPlAreas(Set<LocPreprodPlArea> locPreprodPlAreas) {
		this.locPreprodPlAreas = locPreprodPlAreas;
	}

}
