package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21.03.2023 10:49:04 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.NamedEntityGraphs;
import javax.persistence.NamedSubgraph;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_PREPROD_PL_AREA
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PREPROD_PL_AREA"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "CUNIT", "NPL_INDEX_KEY", "DVALID_FROM", "NPL_INDEX_KEY_MASTER" })
)
@NamedEntityGraphs({
		@NamedEntityGraph(name = "locPreprodPlArea.fetchpackinglists", attributeNodes = {
				@NamedAttributeNode(value = "cenPackinglistIndexByNplIndexKey", subgraph = "locPreprodPlArea.packinglists")
		}, subgraphs = {
				@NamedSubgraph(name = "locPreprodPlArea.packinglists", attributeNodes = {
						@NamedAttributeNode(value = "cenPackinglistses", subgraph = "locPreprodPlArea.packinglist.details")
				}),
				@NamedSubgraph(name = "locPreprodPlArea.packinglist.details", attributeNodes = {
						@NamedAttributeNode(value = "sysPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistTypes"),
						@NamedAttributeNode(value = "cenPackinglistIndex"),
						@NamedAttributeNode(value = "cenPackinglistPictures"),
						@NamedAttributeNode(value = "cenPlRatingTotal"),
						@NamedAttributeNode(value = "cenPackinglistIf")
				})
		})
})
public class LocPreprodPlArea implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppPlAreaKey;
	private SysUnits sysUnits;
	private LocUnitAreas locUnitAreas;
	private LocUnitWorkstation locUnitWorkstation;
	private CenPackinglistIndex cenPackinglistIndexByNplIndexKey;
	private CenPackinglistIndex cenPackinglistIndexByNplIndexKeyMaster;
	private Date dvalidFrom;
	private Date dvalidTo;
	private Long nlabelTypeKey;
	private int nprint;
	private BigDecimal nmaxbatchsize;
	private BigDecimal nrunrate;
	private BigDecimal nsetuprate;
	private Integer noffsetKitchentime;

	public LocPreprodPlArea() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_PREPROD_PL_AREA")
	@SequenceGenerator(name = "SEQ_LOC_PREPROD_PL_AREA", sequenceName = "SEQ_LOC_PREPROD_PL_AREA", allocationSize = 1)
	@Column(name = "NPP_PL_AREA_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppPlAreaKey() {
		return this.nppPlAreaKey;
	}

	public void setNppPlAreaKey(long nppPlAreaKey) {
		this.nppPlAreaKey = nppPlAreaKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAREA_KEY", nullable = false)
	public LocUnitAreas getLocUnitAreas() {
		return this.locUnitAreas;
	}

	public void setLocUnitAreas(LocUnitAreas locUnitAreas) {
		this.locUnitAreas = locUnitAreas;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return this.locUnitWorkstation;
	}

	public void setLocUnitWorkstation(LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_INDEX_KEY", nullable = false)
	public CenPackinglistIndex getCenPackinglistIndexByNplIndexKey() {
		return this.cenPackinglistIndexByNplIndexKey;
	}

	public void setCenPackinglistIndexByNplIndexKey(CenPackinglistIndex cenPackinglistIndexByNplIndexKey) {
		this.cenPackinglistIndexByNplIndexKey = cenPackinglistIndexByNplIndexKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_INDEX_KEY_MASTER")
	public CenPackinglistIndex getCenPackinglistIndexByNplIndexKeyMaster() {
		return this.cenPackinglistIndexByNplIndexKeyMaster;
	}

	public void setCenPackinglistIndexByNplIndexKeyMaster(CenPackinglistIndex cenPackinglistIndexByNplIndexKeyMaster) {
		this.cenPackinglistIndexByNplIndexKeyMaster = cenPackinglistIndexByNplIndexKeyMaster;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NLABEL_TYPE_KEY", precision = 12, scale = 0)
	public Long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(Long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "NPRINT", nullable = false, precision = 1, scale = 0)
	public int getNprint() {
		return this.nprint;
	}

	public void setNprint(int nprint) {
		this.nprint = nprint;
	}

	@Column(name = "NMAXBATCHSIZE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNmaxbatchsize() {
		return this.nmaxbatchsize;
	}

	public void setNmaxbatchsize(BigDecimal nmaxbatchsize) {
		this.nmaxbatchsize = nmaxbatchsize;
	}

	@Column(name = "NRUNRATE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNrunrate() {
		return this.nrunrate;
	}

	public void setNrunrate(BigDecimal nrunrate) {
		this.nrunrate = nrunrate;
	}

	@Column(name = "NSETUPRATE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNsetuprate() {
		return this.nsetuprate;
	}

	public void setNsetuprate(BigDecimal nsetuprate) {
		this.nsetuprate = nsetuprate;
	}

	@Column(name = "NOFFSET_KITCHENTIME", precision = 4, scale = 0)
	public Integer getNoffsetKitchentime() {
		return this.noffsetKitchentime;
	}

	public void setNoffsetKitchentime(Integer noffsetKitchentime) {
		this.noffsetKitchentime = noffsetKitchentime;
	}

}


