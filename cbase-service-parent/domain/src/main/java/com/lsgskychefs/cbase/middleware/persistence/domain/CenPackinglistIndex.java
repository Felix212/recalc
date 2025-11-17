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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_INDEX
 *
 * @author Hibernate Tools
 */
@Entity
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@Table(name = "CEN_PACKINGLIST_INDEX", uniqueConstraints = @UniqueConstraint(columnNames = { "CCLIENT", "CPACKINGLIST" }))
public class CenPackinglistIndex implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistIndexKey;
	@JsonIgnore
	private CenSupplier cenSupplier;
	private String cpackinglist;
	private String cclient;
	private String cpackinglistMatch;
	private Integer npackinglist1stGroup;
	private Integer npackinglist2ndGroup;
	private Integer nownerId;
	private Long nplKindKey;
	private Long npriceGroupKey;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private String cworkcenter;
	private Integer nyieldRecipe;
	private Long nmpNumber;
	private CenFollowUpMaster cenFollowUpMaster;
	@JsonIgnore
	private SysPackinglistKinds sysPackinglistKinds;
	@JsonIgnore
	private Set<CenPackinglists> cenPackinglistses = new HashSet<>(0);
	@JsonIgnore
	private Set<LocUnitPlAreas> locUnitPlAreases = new HashSet<>(0);
	@JsonIgnore
	private Set<CenLoadinglists> cenLoadinglistses = new HashSet<>(0);
	@JsonIgnore
	private Set<LocPlTimeFrame> locPlTimeFrames = new HashSet<>(0);
	@JsonIgnore
	private Set<LocPreprodPlArea> locPreprodPlAreasForNplIndexKey = new HashSet<>(0);
	@JsonIgnore
	private Set<LocPreprodPlArea> locPreprodPlAreasForNplIndexKeyMaster = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PACKINGLIST_INDEX")
	@SequenceGenerator(name = "SEQ_CEN_PACKINGLIST_INDEX", sequenceName = "SEQ_CEN_PACKINGLIST_INDEX", allocationSize = 1)
	@Column(name = "NPACKINGLIST_INDEX_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSUPPLIER_KEY")
	public CenSupplier getCenSupplier() {
		return this.cenSupplier;
	}

	public void setCenSupplier(final CenSupplier cenSupplier) {
		this.cenSupplier = cenSupplier;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CPACKINGLIST_MATCH", length = 18)
	public String getCpackinglistMatch() {
		return this.cpackinglistMatch;
	}

	public void setCpackinglistMatch(final String cpackinglistMatch) {
		this.cpackinglistMatch = cpackinglistMatch;
	}

	@Column(name = "NPACKINGLIST_1ST_GROUP", precision = 6, scale = 0)
	public Integer getNpackinglist1stGroup() {
		return this.npackinglist1stGroup;
	}

	public void setNpackinglist1stGroup(final Integer npackinglist1stGroup) {
		this.npackinglist1stGroup = npackinglist1stGroup;
	}

	@Column(name = "NPACKINGLIST_2ND_GROUP", precision = 6, scale = 0)
	public Integer getNpackinglist2ndGroup() {
		return this.npackinglist2ndGroup;
	}

	public void setNpackinglist2ndGroup(final Integer npackinglist2ndGroup) {
		this.npackinglist2ndGroup = npackinglist2ndGroup;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(final Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "NPRICE_GROUP_KEY", precision = 12, scale = 0)
	public Long getNpriceGroupKey() {
		return this.npriceGroupKey;
	}

	public void setNpriceGroupKey(final Long npriceGroupKey) {
		this.npriceGroupKey = npriceGroupKey;
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

	@Column(name = "CWORKCENTER", length = 8)
	public String getCworkcenter() {
		return this.cworkcenter;
	}

	public void setCworkcenter(final String cworkcenter) {
		this.cworkcenter = cworkcenter;
	}

	@Column(name = "NYIELD_RECIPE", precision = 1, scale = 0)
	public Integer getNyieldRecipe() {
		return this.nyieldRecipe;
	}

	public void setNyieldRecipe(final Integer nyieldRecipe) {
		this.nyieldRecipe = nyieldRecipe;
	}

	@Column(name = "NMP_NUMBER", precision = 12, scale = 0)
	public Long getNmpNumber() {
		return nmpNumber;
	}

	public void setNmpNumber(Long nmpNumber) {
		this.nmpNumber = nmpNumber;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_KIND_KEY", insertable = false, updatable = false)
	public SysPackinglistKinds getSysPackinglistKinds() {
		return sysPackinglistKinds;
	}

	public void setSysPackinglistKinds(final SysPackinglistKinds sysPackinglistKinds) {
		this.sysPackinglistKinds = sysPackinglistKinds;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndex")
	public Set<CenPackinglists> getCenPackinglistses() {
		return this.cenPackinglistses;
	}

	public void setCenPackinglistses(final Set<CenPackinglists> cenPackinglistses) {
		this.cenPackinglistses = cenPackinglistses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndex")
	public Set<LocUnitPlAreas> getLocUnitPlAreases() {
		return this.locUnitPlAreases;
	}

	public void setLocUnitPlAreases(final Set<LocUnitPlAreas> locUnitPlAreases) {
		this.locUnitPlAreases = locUnitPlAreases;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndex")
	public Set<CenLoadinglists> getCenLoadinglistses() {
		return this.cenLoadinglistses;
	}

	public void setCenLoadinglistses(final Set<CenLoadinglists> cenLoadinglistses) {
		this.cenLoadinglistses = cenLoadinglistses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndex")
	public Set<LocPlTimeFrame> getLocPlTimeFrames() {
		return locPlTimeFrames;
	}

	public void setLocPlTimeFrames(final Set<LocPlTimeFrame> locPlTimeFrames) {
		this.locPlTimeFrames = locPlTimeFrames;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndexByNplIndexKey")
	public Set<LocPreprodPlArea> getLocPreprodPlAreasForNplIndexKey() {
		return this.locPreprodPlAreasForNplIndexKey;
	}

	public void setLocPreprodPlAreasForNplIndexKey(Set<LocPreprodPlArea> locPreprodPlAreasForNplIndexKey) {
		this.locPreprodPlAreasForNplIndexKey = locPreprodPlAreasForNplIndexKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistIndexByNplIndexKeyMaster")
	public Set<LocPreprodPlArea> getLocPreprodPlAreasForNplIndexKeyMaster() {
		return this.locPreprodPlAreasForNplIndexKeyMaster;
	}

	public void setLocPreprodPlAreasForNplIndexKeyMaster(Set<LocPreprodPlArea> locPreprodPlAreasForNplIndexKeyMaster) {
		this.locPreprodPlAreasForNplIndexKeyMaster = locPreprodPlAreasForNplIndexKeyMaster;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}
}
