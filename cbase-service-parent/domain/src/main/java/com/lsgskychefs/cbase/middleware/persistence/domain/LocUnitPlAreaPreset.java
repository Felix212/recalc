package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 16, 2023 6:57:52 PM by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table LOC_UNIT_PL_AREA_PRESET
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PL_AREA_PRESET"
)
public class LocUnitPlAreaPreset implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplAreaPresetKey;
	private CenLabelType prodLabelType;
	private CenLabelType flightLabelType;
	private LocUnitAreas locUnitAreas;
	private String cname;
	private String cdescription;
	private String cunit;
	private Long nairlineKey;
	private String cclient;
	private long nworkstationKey;
	private Date dvalidFrom;
	private Date dvalidTo;
	private BigDecimal nrunrate;
	private BigDecimal nsetuprate;
	private int nitemsPerUnit;
	private String cprodLabelUnit;
	private Integer nccplog5;
	private BigDecimal nmaxbatchsize;
	private Integer nmassProduction;
	private int ncartdiagram;
	private int nprodLabelPrint;
	private Set<LocUnitPlAreaPresetSchedule> locUnitPlAreaPresetSchedules = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_PL_AREA_PRESET")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_PL_AREA_PRESET", sequenceName = "SEQ_LOC_UNIT_PL_AREA_PRESET", allocationSize = 1)
	@Column(name = "NPL_AREA_PRESET_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplAreaPresetKey() {
		return this.nplAreaPresetKey;
	}

	public void setNplAreaPresetKey(long nplAreaPresetKey) {
		this.nplAreaPresetKey = nplAreaPresetKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROD_LABEL_TYPE_KEY", nullable = false)
	public CenLabelType getProdLabelType() {
		return this.prodLabelType;
	}

	public void setProdLabelType(CenLabelType prodLabelType) {
		this.prodLabelType = prodLabelType;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFLIGHT_LABEL_TYPE_KEY")
	public CenLabelType getFlightLabelType() {
		return this.flightLabelType;
	}

	public void setFlightLabelType(CenLabelType flightLabelType) {
		this.flightLabelType = flightLabelType;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAREA_KEY", nullable = false)
	public LocUnitAreas getLocUnitAreas() {
		return this.locUnitAreas;
	}

	public void setLocUnitAreas(LocUnitAreas locUnitAreas) {
		this.locUnitAreas = locUnitAreas;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 100)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", nullable = true, precision = 12, scale = 0)
	public Long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(Long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
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

	@Column(name = "NRUNRATE", precision = 15, scale = 3)
	public BigDecimal getNrunrate() {
		return this.nrunrate;
	}

	public void setNrunrate(BigDecimal nrunrate) {
		this.nrunrate = nrunrate;
	}

	@Column(name = "NSETUPRATE", precision = 15, scale = 3)
	public BigDecimal getNsetuprate() {
		return this.nsetuprate;
	}

	public void setNsetuprate(BigDecimal nsetuprate) {
		this.nsetuprate = nsetuprate;
	}

	@Column(name = "NITEMS_PER_UNIT", nullable = false, precision = 7, scale = 0)
	public int getNitemsPerUnit() {
		return this.nitemsPerUnit;
	}

	public void setNitemsPerUnit(int nitemsPerUnit) {
		this.nitemsPerUnit = nitemsPerUnit;
	}

	@Column(name = "CPROD_LABEL_UNIT", length = 40)
	public String getCprodLabelUnit() {
		return this.cprodLabelUnit;
	}

	public void setCprodLabelUnit(String cprodLabelUnit) {
		this.cprodLabelUnit = cprodLabelUnit;
	}

	@Column(name = "NCCPLOG5", precision = 1, scale = 0)
	public Integer getNccplog5() {
		return this.nccplog5;
	}

	public void setNccplog5(Integer nccplog5) {
		this.nccplog5 = nccplog5;
	}

	@Column(name = "NMAXBATCHSIZE", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNmaxbatchsize() {
		return this.nmaxbatchsize;
	}

	public void setNmaxbatchsize(BigDecimal nmaxbatchsize) {
		this.nmaxbatchsize = nmaxbatchsize;
	}

	@Column(name = "NMASS_PRODUCTION", precision = 1, scale = 0)
	public Integer getNmassProduction() {
		return this.nmassProduction;
	}

	public void setNmassProduction(Integer nmassProduction) {
		this.nmassProduction = nmassProduction;
	}

	@Column(name = "NCARTDIAGRAM", nullable = false, precision = 1, scale = 0)
	public int getNcartdiagram() {
		return this.ncartdiagram;
	}

	public void setNcartdiagram(int ncartdiagram) {
		this.ncartdiagram = ncartdiagram;
	}

	@Column(name = "NPROD_LABEL_PRINT", nullable = false, precision = 1, scale = 0)
	public int getNprodLabelPrint() {
		return this.nprodLabelPrint;
	}

	public void setNprodLabelPrint(int nprodLabelPrint) {
		this.nprodLabelPrint = nprodLabelPrint;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "locUnitPlAreaPreset")
	public Set<LocUnitPlAreaPresetSchedule> getLocUnitPlAreaPresetSchedules() {
		return this.locUnitPlAreaPresetSchedules;
	}

	public void setLocUnitPlAreaPresetSchedules(Set<LocUnitPlAreaPresetSchedule> locUnitPlAreaPresetSchedules) {
		this.locUnitPlAreaPresetSchedules = locUnitPlAreaPresetSchedules;
	}

}


