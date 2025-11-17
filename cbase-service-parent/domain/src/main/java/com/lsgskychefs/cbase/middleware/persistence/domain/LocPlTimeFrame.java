package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_PL_TIME_FRAME
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PL_TIME_FRAME")
public class LocPlTimeFrame implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npltimeframeIndex;

	private LocUnitProdTimeFrame locUnitProdTimeFrame;

	private LocUnitWsSchedule locUnitWsSchedule;

	private SysUnits sysUnits;

	private LocPlTimeFrameVariant locPlTimeFrameVariant;

	private CenPackinglistIndex cenPackinglistIndex;

	private long npackinglistIndexKey;

	private long nairlineKey;

	private String cunit;

	private Integer ndefault;

	private Long nworkstation;

	private int noffset;

	private Date dcreated;

	private String ccreatedBy;

	private Date dupdated;

	private String cupdatedBy;

	private Integer nbatch;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_PL_TIME_FRAME")
	@SequenceGenerator(name = "SEQ_LOC_PL_TIME_FRAME", sequenceName = "SEQ_LOC_PL_TIME_FRAME", allocationSize = 1)
	@Column(name = "NPLTIMEFRAME_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpltimeframeIndex() {
		return this.npltimeframeIndex;
	}

	public void setNpltimeframeIndex(final long npltimeframeIndex) {
		this.npltimeframeIndex = npltimeframeIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRODTIMEFRAME_INDEX", nullable = false)
	public LocUnitProdTimeFrame getLocUnitProdTimeFrame() {
		return this.locUnitProdTimeFrame;
	}

	public void setLocUnitProdTimeFrame(final LocUnitProdTimeFrame locUnitProdTimeFrame) {
		this.locUnitProdTimeFrame = locUnitProdTimeFrame;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CBOARDING_UNIT")
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSCHEDULE_INDEX", nullable = false)
	public LocUnitWsSchedule getLocUnitWsSchedule() {
		return this.locUnitWsSchedule;
	}

	public void setLocUnitWsSchedule(final LocUnitWsSchedule locUnitWsSchedule) {
		this.locUnitWsSchedule = locUnitWsSchedule;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NVARIANT", nullable = false)
	public LocPlTimeFrameVariant getLocPlTimeFrameVariant() {
		return this.locPlTimeFrameVariant;
	}

	public void setLocPlTimeFrameVariant(final LocPlTimeFrameVariant locPlTimeFrameVariant) {
		this.locPlTimeFrameVariant = locPlTimeFrameVariant;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NDEFAULT", precision = 1, scale = 0)
	public Integer getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final Integer ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "NWORKSTATION", precision = 12, scale = 0)
	public Long getNworkstation() {
		return this.nworkstation;
	}

	public void setNworkstation(final Long nworkstation) {
		this.nworkstation = nworkstation;
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

	@Column(name = "NBATCH", precision = 1, scale = 0)
	public Integer getNbatch() {
		return this.nbatch;
	}

	public void setNbatch(final Integer nbatch) {
		this.nbatch = nbatch;
	}

}
