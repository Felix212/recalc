package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 15:45:54 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
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
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_STOWAGE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_STOWAGE", uniqueConstraints = @UniqueConstraint(columnNames = { "NGALLEY_KEY", "CSTOWAGE", "CPLACE" }))
public class CenStowage implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nstowageKey;
	@JsonIgnore
	private CenGalley cenGalley;
	private String cstowage;
	private String cplace;
	private int nbelly;
	private long nequipmentKey;
	private int nsort;
	private int npage;
	private int nxpos;
	private int nypos;
	private String ctext;
	private BigDecimal nweight;
	private Long ncartType;
	private Date dtimestamp;
	private String cstowageType;
	private String cweightUnit;
	private String cdescription;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Boolean nchilled;
	private Boolean nmandatory;
	private SysContainerUnits sysContainerUnits;
	private Integer ntrCartGroup;
	private int nflip;
	private int nfrontRear;
	private int nmustMatch;
	private Set<CenPpsContainer> cenPpsContainersForNstowageKey = new HashSet<>(0);
	private Set<CenPpsContainer> cenPpsContainersForNstowageKeyOld = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_STOWAGE")
	@SequenceGenerator(name = "SEQ_CEN_STOWAGE", sequenceName = "SEQ_CEN_STOWAGE", allocationSize = 1)
	@Column(name = "NSTOWAGE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(final long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGALLEY_KEY", nullable = false)
	public CenGalley getCenGalley() {
		return this.cenGalley;
	}

	public void setCenGalley(final CenGalley cenGalley) {
		this.cenGalley = cenGalley;
	}

	@Column(name = "CSTOWAGE", nullable = false, length = 5)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CPLACE", nullable = false, length = 3)
	public String getCplace() {
		return this.cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	@Column(name = "NBELLY", nullable = false, precision = 1, scale = 0)
	public int getNbelly() {
		return this.nbelly;
	}

	public void setNbelly(final int nbelly) {
		this.nbelly = nbelly;
	}

	@Column(name = "NEQUIPMENT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNequipmentKey() {
		return this.nequipmentKey;
	}

	public void setNequipmentKey(final long nequipmentKey) {
		this.nequipmentKey = nequipmentKey;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NPAGE", nullable = false, precision = 2, scale = 0)
	public int getNpage() {
		return this.npage;
	}

	public void setNpage(final int npage) {
		this.npage = npage;
	}

	@Column(name = "NXPOS", nullable = false, precision = 7, scale = 0)
	public int getNxpos() {
		return this.nxpos;
	}

	public void setNxpos(final int nxpos) {
		this.nxpos = nxpos;
	}

	@Column(name = "NYPOS", nullable = false, precision = 7, scale = 0)
	public int getNypos() {
		return this.nypos;
	}

	public void setNypos(final int nypos) {
		this.nypos = nypos;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NWEIGHT", nullable = false, precision = 10, scale = 3)
	public BigDecimal getNweight() {
		return this.nweight;
	}

	public void setNweight(final BigDecimal nweight) {
		this.nweight = nweight;
	}

	@Column(name = "NCART_TYPE", precision = 12, scale = 0)
	public Long getNcartType() {
		return this.ncartType;
	}

	public void setNcartType(final Long ncartType) {
		this.ncartType = ncartType;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CSTOWAGE_TYPE", length = 2)
	public String getCstowageType() {
		return this.cstowageType;
	}

	public void setCstowageType(final String cstowageType) {
		this.cstowageType = cstowageType;
	}

	@Column(name = "CWEIGHT_UNIT", length = 3)
	public String getCweightUnit() {
		return this.cweightUnit;
	}

	public void setCweightUnit(final String cweightUnit) {
		this.cweightUnit = cweightUnit;
	}

	@Column(name = "CDESCRIPTION", length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "NCHILLED", precision = 1, scale = 0)
	public Boolean getNchilled() {
		return this.nchilled;
	}

	public void setNchilled(final Boolean nchilled) {
		this.nchilled = nchilled;
	}

	@Column(name = "NMANDATORY", precision = 1, scale = 0)
	public Boolean getNmandatory() {
		return this.nmandatory;
	}

	public void setNmandatory(final Boolean nmandatory) {
		this.nmandatory = nmandatory;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenStowageByNstowageKey")
	public Set<CenPpsContainer> getCenPpsContainersForNstowageKey() {
		return this.cenPpsContainersForNstowageKey;
	}

	public void setCenPpsContainersForNstowageKey(final Set<CenPpsContainer> cenPpsContainersForNstowageKey) {
		this.cenPpsContainersForNstowageKey = cenPpsContainersForNstowageKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenStowageByNstowageKeyOld")
	public Set<CenPpsContainer> getCenPpsContainersForNstowageKeyOld() {
		return this.cenPpsContainersForNstowageKeyOld;
	}

	public void setCenPpsContainersForNstowageKeyOld(final Set<CenPpsContainer> cenPpsContainersForNstowageKeyOld) {
		this.cenPpsContainersForNstowageKeyOld = cenPpsContainersForNstowageKeyOld;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCONTAINER_UNITS_KEY")
	public SysContainerUnits getSysContainerUnits() {
		return this.sysContainerUnits;
	}

	public void setSysContainerUnits(SysContainerUnits sysContainerUnits) {
		this.sysContainerUnits = sysContainerUnits;
	}

	@Column(name = "NTR_CART_GROUP", precision = 3, scale = 0)
	public Integer getNtrCartGroup() {
		return this.ntrCartGroup;
	}

	public void setNtrCartGroup(Integer ntrCartGroup) {
		this.ntrCartGroup = ntrCartGroup;
	}

	@Column(name = "NFLIP", nullable = false, precision = 1, scale = 0)
	public int getNflip() {
		return this.nflip;
	}

	public void setNflip(int nflip) {
		this.nflip = nflip;
	}

	@Column(name = "NFRONT_REAR", nullable = false, precision = 1, scale = 0)
	public int getNfrontRear() {
		return this.nfrontRear;
	}

	public void setNfrontRear(int nfrontRear) {
		this.nfrontRear = nfrontRear;
	}

	@Column(name = "NMUST_MATCH", nullable = false, precision = 1, scale = 0)
	public int getNmustMatch() {
		return this.nmustMatch;
	}

	public void setNmustMatch(int nmustMatch) {
		this.nmustMatch = nmustMatch;
	}

}
