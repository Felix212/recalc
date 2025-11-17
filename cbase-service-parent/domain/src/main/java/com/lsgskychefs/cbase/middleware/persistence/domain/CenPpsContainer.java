package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.04.2016 09:24:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PPS_CONTAINER <br/>
 * Trolleys eines Flugereignis({@link CenPpsCateringOrder})
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PPS_CONTAINER")
public class CenPpsContainer implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncontainerKey;
	private CenStowage cenStowageByNstowageKey;
	private CenStowage cenStowageByNstowageKeyOld;
	private SysPpsObjectState sysPpsObjectState;
	private SysPpsActionTypes sysPpsActionTypes;
	private LocPpsBoxSegment locPpsBoxSegment;
	private CenPpsProdOrder cenPpsProdOrder;
	private CenPpsFlightSlot cenPpsFlightSlot;
	private CenPpsCateringOrder cenPpsCateringOrder;
	private LocPpsProdBom locPpsProdBom;
	private Long ncontainerTypeKey;
	private Integer nbellyFlag;
	private Long nquantity;
	private Integer nlabelKind;
	private String cclass;
	private Integer ncateringLeg;
	private String cloadinglist;
	private String caddOnText;
	private String cmealControlCode;
	private String czustautext;
	private String cpldetailText;
	private String cforToCode;
	private String cforToStation;
	private String cbellyContainer;
	private String cunitTime;
	private Integer nbellyContainer;
	private Integer nlabelCount;
	private String chost;
	private Date dprinted;
	private String crampbox;
	private Long nareaKey;
	private Long nworkstationKey;
	private Long ncoldstoreKey;
	private Set<CenPpsMealLayout> cenPpsMealLayouts = new HashSet<>(0);

	@Id
	@Column(name = "NCONTAINER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcontainerKey() {
		return this.ncontainerKey;
	}

	public void setNcontainerKey(final long ncontainerKey) {
		this.ncontainerKey = ncontainerKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTOWAGE_KEY")
	public CenStowage getCenStowageByNstowageKey() {
		return this.cenStowageByNstowageKey;
	}

	public void setCenStowageByNstowageKey(final CenStowage cenStowageByNstowageKey) {
		this.cenStowageByNstowageKey = cenStowageByNstowageKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSTOWAGE_KEY_OLD")
	public CenStowage getCenStowageByNstowageKeyOld() {
		return this.cenStowageByNstowageKeyOld;
	}

	public void setCenStowageByNstowageKeyOld(final CenStowage cenStowageByNstowageKeyOld) {
		this.cenStowageByNstowageKeyOld = cenStowageByNstowageKeyOld;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NOBJECT_STATE_KEY")
	public SysPpsObjectState getSysPpsObjectState() {
		return this.sysPpsObjectState;
	}

	public void setSysPpsObjectState(final SysPpsObjectState sysPpsObjectState) {
		this.sysPpsObjectState = sysPpsObjectState;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NACTION_TYPE_KEY")
	public SysPpsActionTypes getSysPpsActionTypes() {
		return this.sysPpsActionTypes;
	}

	public void setSysPpsActionTypes(final SysPpsActionTypes sysPpsActionTypes) {
		this.sysPpsActionTypes = sysPpsActionTypes;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBOX_SEGMENT_KEY")
	public LocPpsBoxSegment getLocPpsBoxSegment() {
		return this.locPpsBoxSegment;
	}

	public void setLocPpsBoxSegment(final LocPpsBoxSegment locPpsBoxSegment) {
		this.locPpsBoxSegment = locPpsBoxSegment;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROD_ORDER_KEY")
	public CenPpsProdOrder getCenPpsProdOrder() {
		return this.cenPpsProdOrder;
	}

	public void setCenPpsProdOrder(final CenPpsProdOrder cenPpsProdOrder) {
		this.cenPpsProdOrder = cenPpsProdOrder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFLIGHT_SLOT_KEY")
	public CenPpsFlightSlot getCenPpsFlightSlot() {
		return this.cenPpsFlightSlot;
	}

	public void setCenPpsFlightSlot(final CenPpsFlightSlot cenPpsFlightSlot) {
		this.cenPpsFlightSlot = cenPpsFlightSlot;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCO_KEY")
	public CenPpsCateringOrder getCenPpsCateringOrder() {
		return this.cenPpsCateringOrder;
	}

	public void setCenPpsCateringOrder(final CenPpsCateringOrder cenPpsCateringOrder) {
		this.cenPpsCateringOrder = cenPpsCateringOrder;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROD_BOM_KEY")
	public LocPpsProdBom getLocPpsProdBom() {
		return this.locPpsProdBom;
	}

	public void setLocPpsProdBom(final LocPpsProdBom locPpsProdBom) {
		this.locPpsProdBom = locPpsProdBom;
	}

	@Column(name = "NCONTAINER_TYPE_KEY", precision = 12, scale = 0)
	public Long getNcontainerTypeKey() {
		return this.ncontainerTypeKey;
	}

	public void setNcontainerTypeKey(final Long ncontainerTypeKey) {
		this.ncontainerTypeKey = ncontainerTypeKey;
	}

	@Column(name = "NBELLY_FLAG", precision = 1, scale = 0)
	public Integer getNbellyFlag() {
		return this.nbellyFlag;
	}

	public void setNbellyFlag(final Integer nbellyFlag) {
		this.nbellyFlag = nbellyFlag;
	}

	@Column(name = "NQUANTITY", precision = 12, scale = 0)
	public Long getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Long nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NLABEL_KIND", precision = 1, scale = 0)
	public Integer getNlabelKind() {
		return this.nlabelKind;
	}

	public void setNlabelKind(final Integer nlabelKind) {
		this.nlabelKind = nlabelKind;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NCATERING_LEG", precision = 5, scale = 0)
	public Integer getNcateringLeg() {
		return this.ncateringLeg;
	}

	public void setNcateringLeg(final Integer ncateringLeg) {
		this.ncateringLeg = ncateringLeg;
	}

	@Column(name = "CLOADINGLIST", length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "CZUSTAUTEXT", length = 40)
	public String getCzustautext() {
		return this.czustautext;
	}

	public void setCzustautext(final String czustautext) {
		this.czustautext = czustautext;
	}

	@Column(name = "CPLDETAIL_TEXT", length = 8)
	public String getCpldetailText() {
		return this.cpldetailText;
	}

	public void setCpldetailText(final String cpldetailText) {
		this.cpldetailText = cpldetailText;
	}

	@Column(name = "CFOR_TO_CODE", length = 5)
	public String getCforToCode() {
		return this.cforToCode;
	}

	public void setCforToCode(final String cforToCode) {
		this.cforToCode = cforToCode;
	}

	@Column(name = "CFOR_TO_STATION", length = 3)
	public String getCforToStation() {
		return this.cforToStation;
	}

	public void setCforToStation(final String cforToStation) {
		this.cforToStation = cforToStation;
	}

	@Column(name = "CBELLY_CONTAINER", length = 10)
	public String getCbellyContainer() {
		return this.cbellyContainer;
	}

	public void setCbellyContainer(final String cbellyContainer) {
		this.cbellyContainer = cbellyContainer;
	}

	@Column(name = "CUNIT_TIME", length = 5)
	public String getCunitTime() {
		return this.cunitTime;
	}

	public void setCunitTime(final String cunitTime) {
		this.cunitTime = cunitTime;
	}

	@Column(name = "NBELLY_CONTAINER", precision = 1, scale = 0)
	public Integer getNbellyContainer() {
		return this.nbellyContainer;
	}

	public void setNbellyContainer(final Integer nbellyContainer) {
		this.nbellyContainer = nbellyContainer;
	}

	@Column(name = "NLABEL_COUNT", precision = 6, scale = 0)
	public Integer getNlabelCount() {
		return this.nlabelCount;
	}

	public void setNlabelCount(final Integer nlabelCount) {
		this.nlabelCount = nlabelCount;
	}

	@Column(name = "CHOST", length = 40)
	public String getChost() {
		return this.chost;
	}

	public void setChost(final String chost) {
		this.chost = chost;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPRINTED", length = 7)
	public Date getDprinted() {
		return this.dprinted;
	}

	public void setDprinted(final Date dprinted) {
		this.dprinted = dprinted;
	}

	@Column(name = "CRAMPBOX", length = 20)
	public String getCrampbox() {
		return this.crampbox;
	}

	public void setCrampbox(final String crampbox) {
		this.crampbox = crampbox;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "NCOLDSTORE_KEY", precision = 12, scale = 0)
	public Long getNcoldstoreKey() {
		return this.ncoldstoreKey;
	}

	public void setNcoldstoreKey(final Long ncoldstoreKey) {
		this.ncoldstoreKey = ncoldstoreKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPpsContainer")
	public Set<CenPpsMealLayout> getCenPpsMealLayouts() {
		return this.cenPpsMealLayouts;
	}

	public void setCenPpsMealLayouts(final Set<CenPpsMealLayout> cenPpsMealLayouts) {
		this.cenPpsMealLayouts = cenPpsMealLayouts;
	}

}
