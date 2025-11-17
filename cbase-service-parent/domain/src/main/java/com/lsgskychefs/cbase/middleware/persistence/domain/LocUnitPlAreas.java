package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_PL_AREAS
 *
 * @author Hibernate Tools
 */
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "LOC_UNIT_PL_AREAS", uniqueConstraints = @UniqueConstraint(columnNames = { "CUNIT", "CCLIENT", "NPACKINGLIST_INDEX_KEY",
		"DVALID_FROM" }))
public class LocUnitPlAreas implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplAreaKey;

	private LocUnitAreas locUnitAreas;

	private CenPackinglistIndex cenPackinglistIndex;

	private long nworkstationKey;

	private int nplType;

	private String cunit;

	private String cclient;

	private int nlabelPrint;

	private Date dvalidFrom;

	private Date dvalidTo;

	private Integer ncartdiagram;

	private Integer nexplode;

	private Integer ncontentSpec;

	private int npps;

	private int nprintFlightlabel;

	private int nallocateAuto;

	private Date dallocateAuto;

	private Long nplAreaPresetKey;

	@JsonIgnore
	private LocUnitPlAreaPreset locUnitPlAreaPreset;

	private Set<LocUnitPlReserve> locUnitPlReserves = new HashSet<>(0);

	private Set<LocUnitPlFlightLabel> locUnitPlFlightLabels = new HashSet<>(0);

	private LocUnitPlProdLabel locUnitPlProdLabel;

	private LocUnitWorkstation locUnitWorkstation;

	private String ccreatedBy;

	private Date dcreatedOn;

	private String cupdatedBy;

	private Date dupdatedOn;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_PL_AREAS")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_PL_AREAS", sequenceName = "SEQ_LOC_UNIT_PL_AREAS", allocationSize = 1)
	@Column(name = "NPL_AREA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplAreaKey() {
		return this.nplAreaKey;
	}

	public void setNplAreaKey(final long nplAreaKey) {
		this.nplAreaKey = nplAreaKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAREA_KEY", nullable = false)
	public LocUnitAreas getLocUnitAreas() {
		return this.locUnitAreas;
	}

	public void setLocUnitAreas(final LocUnitAreas locUnitAreas) {
		this.locUnitAreas = locUnitAreas;
	}

	@Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NPL_TYPE", nullable = false, precision = 6, scale = 0)
	public int getNplType() {
		return this.nplType;
	}

	public void setNplType(final int nplType) {
		this.nplType = nplType;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NLABEL_PRINT", nullable = false, precision = 1, scale = 0)
	public int getNlabelPrint() {
		return this.nlabelPrint;
	}

	public void setNlabelPrint(final int nlabelPrint) {
		this.nlabelPrint = nlabelPrint;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NCARTDIAGRAM", nullable = false, precision = 1, scale = 0)
	public Integer getNcartdiagram() {
		return this.ncartdiagram;
	}

	public void setNcartdiagram(final Integer ncartdiagram) {
		this.ncartdiagram = ncartdiagram;
	}

	@Column(name = "NEXPLODE", precision = 1, scale = 0)
	public Integer getNexplode() {
		return this.nexplode;
	}

	public void setNexplode(final Integer nexplode) {
		this.nexplode = nexplode;
	}

	@Column(name = "NCONTENT_SPEC", precision = 1, scale = 0)
	public Integer getNcontentSpec() {
		return this.ncontentSpec;
	}

	public void setNcontentSpec(final Integer ncontentSpec) {
		this.ncontentSpec = ncontentSpec;
	}

	@Column(name = "NPPS", nullable = false, precision = 1, scale = 0)
	public int getNpps() {
		return this.npps;
	}

	public void setNpps(final int npps) {
		this.npps = npps;
	}

	@Column(name = "NPRINT_FLIGHTLABEL", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNprintFlightlabel() {
		return this.nprintFlightlabel;
	}

	public void setNprintFlightlabel(final int nprintFlightlabel) {
		this.nprintFlightlabel = nprintFlightlabel;
	}

	@Column(name = "NALLOCATE_AUTO", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNallocateAuto() {
		return this.nallocateAuto;
	}

	public void setNallocateAuto(final int nallocateAuto) {
		this.nallocateAuto = nallocateAuto;
	}

	public Date getDallocateAuto() {
		return dallocateAuto;
	}

	public void setDallocateAuto(final Date dallocateAuto) {
		this.dallocateAuto = dallocateAuto;
	}

	@Column(name = "NPL_AREA_PRESET_KEY", precision = 12)
	public Long getNplAreaPresetKey() {
		return this.nplAreaPresetKey;
	}

	public void setNplAreaPresetKey(final Long nplAreaPresetKey) {
		this.nplAreaPresetKey = nplAreaPresetKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_AREA_PRESET_KEY", insertable = false, updatable = false)
	public LocUnitPlAreaPreset getLocUnitPlAreaPreset() {
		return locUnitPlAreaPreset;
	}

	public void setLocUnitPlAreaPreset(LocUnitPlAreaPreset locUnitPlAreaPreset) {
		this.locUnitPlAreaPreset = locUnitPlAreaPreset;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPlAreas")
	public Set<LocUnitPlReserve> getLocUnitPlReserves() {
		return this.locUnitPlReserves;
	}

	public void setLocUnitPlReserves(final Set<LocUnitPlReserve> locUnitPlReserves) {
		this.locUnitPlReserves = locUnitPlReserves;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPlAreas")
	public Set<LocUnitPlFlightLabel> getLocUnitPlFlightLabels() {
		return this.locUnitPlFlightLabels;
	}

	public void setLocUnitPlFlightLabels(final Set<LocUnitPlFlightLabel> locUnitPlFlightLabels) {
		this.locUnitPlFlightLabels = locUnitPlFlightLabels;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "locUnitPlAreas")
	public LocUnitPlProdLabel getLocUnitPlProdLabel() {
		return this.locUnitPlProdLabel;
	}

	public void setLocUnitPlProdLabel(final LocUnitPlProdLabel locUnitPlProdLabel) {
		this.locUnitPlProdLabel = locUnitPlProdLabel;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return this.locUnitWorkstation;
	}

	public void setLocUnitWorkstation(final LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@CreatedDate
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON")
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(final Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@LastModifiedDate
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON")
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(final Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@CreatedBy
	@Column(name = "CCREATED_BY", length = 256)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@LastModifiedBy
	@Column(name = "CUPDATED_BY", length = 256)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}
