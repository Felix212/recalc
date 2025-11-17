package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.SequenceGenerator;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpGetChangeovertime;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpGetNextSched;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpHasDistributionErrors;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpUpdateSequences;
import com.lsgskychefs.cbase.middleware.persistence.constant.WorkOrderState;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM (Tablets, paltes,...)
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = PpHasDistributionErrors.PP_HAS_DISTRIBUTION_ERRORS, procedureName = "CBASE_DISTRIBUTION."
				+ PpHasDistributionErrors.PP_HAS_DISTRIBUTION_ERRORS, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpHasDistributionErrors.P_RESULT_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpHasDistributionErrors.P_TRANSACTION, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpHasDistributionErrors.P_PPM_SCHED_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpHasDistributionErrors.P_RET_VALUE, type = Integer.class)
		}),
		@NamedStoredProcedureQuery(name = PpGetChangeovertime.PP_GET_CHANGEOVERTIME, procedureName = "CBASE_PPM."
				+ PpGetChangeovertime.PP_GET_CHANGEOVERTIME, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetChangeovertime.P_BACTH_SEQ, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetChangeovertime.P_START_DATE, type = Date.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpGetChangeovertime.P_RET, type = Long.class)

		}),
		@NamedStoredProcedureQuery(name = PpUpdateSequences.PP_UPDATE_SEQUENCES, procedureName = "CBASE_PPM_UK."
				+ PpUpdateSequences.PP_UPDATE_SEQUENCES, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpUpdateSequences.P_PPM_SCHED_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpUpdateSequences.P_RET_VALUE, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpUpdateSequences.P_RET_MESSAGE, type = String.class)
		}),
		@NamedStoredProcedureQuery(name = PpGetNextSched.PP_GET_NEXT_SCHED, procedureName = "CBASE_PPM."
				+ PpGetNextSched.PP_GET_NEXT_SCHED, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = PpGetNextSched.P_NPPM_SCHED_KEY, type = Long.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = PpGetNextSched.P_NPPM_SCHED_KEY_NEXT, type = Long.class)
		})

})

@Entity
@Table(name = "CEN_OUT_PPM")
public class CenOutPpm implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private Long nppmDetailKey;

	private CenOutPpmFlights cenOutPpmFlights;

	private CenOutPpmSched cenOutPpmSched;

	private CenOutPpmTruck cenOutPpmTruck;

	private long ntype;

	private String cpackinglist;

	private String ctext;

	private String caddOnText;

	private Long nareaKey;

	private String careaCode;

	private String carea;

	private String cunitOfIssue;

	private Long nworkstationKey;

	private String cworkstation;

	private String cworkstationText;

	private long npackinglistIndexKey;

	private long npackinglistDetailKey;

	private BigDecimal nquantity;

	private Long nheight;

	private Long nwidth;

	private String cclass;

	private Long nclassNumber;

	private Long nplDistributionKey;

	private String cloadinglist;

	private Long nprint;

	private String cmealControlCode;

	private Long nlabelTypeKey;

	private Long nlabelType;

	private Long nduplicated;

	private Long nunitPriority;

	private Long ncomputeLeg;

	private Long nseparator;

	private Long nmodified;

	private Long ngalleyGroup;

	private Long npltimeframeIndex;

	private Date dprodDate;

	private Long npltypeKey;

	private String cplType;

	private Long nlabelCounter;

	private Long ncomputeNextLeg;

	private BigDecimal nseconds;

	/** potentially hazardous food */
	private int nphfFlag;

	private BigDecimal nquantityVers;

	private BigDecimal nreserve;

	private BigDecimal nquantityProd;

	private BigDecimal nquantityInventory;

	private BigDecimal nquantityOriginal;

	private BigDecimal nquantityMultiplier;

	private Long nbatchNo;

	private Long nbatchSeq;

	private Date dtimeStart;

	private Date dtimeStop;

	private BigDecimal ntempStart;

	private Boolean ntempStartManual;

	private BigDecimal ntempStop;

	private Boolean ntempStopManual;

	/** @see WorkOrderState */
	private int nstatus;

	private int nmanualSplit;

	private String cuserStart;

	private String cuserStop;

	private int nalertLevel;

	private String cunit;

	private String ccreatedBy;

	private Date dcreatedDate;

	private String cupdatedBy;

	private Date dupdatedDate;

	private String cancestorPackinglist;

	private String csequence;

	private String cuserDetails;

	private String cverificationUser;

	private Date dverificationDate;

	private String cremarkAction;

	private String cwoDescription;

	private Integer nwoOffset;

	private String cwoTimeFrom;

	private String cwoTimeTo;

	private Long nmaxBatchSize;

	private Integer nsequence;

	private Integer nempCount;

	private Date dplannedStart;

	private Date dplannedEnd;

	private Integer nduration;

	private Long nworkscheduleIndex;

	private String ctextShort;

	private String cuserStart2;

	private String cuserStart3;

	private String cschedule;

	private BigDecimal nroomTemp;

	private boolean ngoldStandard;

	private boolean nmoved;

	private BigDecimal nquantityProdPlanned;

	private Integer ndurationSync;

	private Integer ninsertBySync;

	private Integer ncapacity;

	private String cunitCapacity;

	private BigDecimal nrunrate;

	private BigDecimal nsetuprate;

	private Long npltfFlightIndexGroup;

	private String cuserLock;

	private Long nppmtrailKey;

	private String ctextLocUnitPlProdLabel;

	private Long nsectorKey;

	private String csector;

	private long nbatchSeqProdLabel;

	private boolean nambientTray;

	private Long nplKindKey;

	private Long ngalleyKey;

	private String cgalley;

	private Long nstowageKey;

	private String cstowage;

	private String cplace;

	private Long ngalleySort;

	private Long nstowageSort;

	private Long nbellyContainer;

	private Long nprodlabelHash;

	private int nprintFlightlabel;

	private Long nshortagewastageKey;

	private String cswReason;

	private Integer nbatch;

	private int ncontainerStatus;

	private Long npackinglistKey;

	private int nspmlQtyPrinted;

	private Integer nchangeOverTime;

	private int nblockBySmd;

	private int npreproduction;

	private long nsequenceGroup;

	private int ncsoStatus;

	private String ccsoUser;

	private Date dcsoDate;

	private String cservingUnit;

	private int nincreaseLabelsPrinted;

	private BigDecimal nquantityRecipe;

	private String cunitRecipe;

	private Date dexpiryDate;

	private Long nstowageKeyOld;

	private String cstorageOld;

	private boolean ndispose;

	private String ccustomerPl;

	private String ccustomerText;

	private Set<CenOutPpmCo> cenOutPpmCos = new HashSet<>(0);

	private Set<CenOutPpmCsoState> cenOutPpmCsoStates = new HashSet<>(0);

	private boolean noverproduction;

	private BigDecimal ntempCookingFinished;

	private Boolean ntempCookingFinishedManual;

	private Date dtimeCookingFinished;

	private String cuserCookingFinished;

	/** null -> not seared; false -> seared but no color change on all surfaces; yes -> seared, color change on all surfaces */
	private Boolean nproductSeared;

	private BigDecimal ntempChillingStarted;

	private Boolean ntempChillingStartedManual;

	private Date dtimeChillingStarted;

	private BigDecimal ntempChillingFinished;

	private Boolean ntempChillingFinishedManual;

	private Date dtimeChillingFinished;

	private String cuserChillingFinished;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM", sequenceName = "SEQ_CEN_OUT_PPM", allocationSize = 1)
	@Column(name = "NPPM_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNppmDetailKey() {
		return this.nppmDetailKey;
	}

	public void setNppmDetailKey(final Long nppmDetailKey) {
		this.nppmDetailKey = nppmDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPMTRUCK_KEY")
	public CenOutPpmTruck getCenOutPpmTruck() {
		return this.cenOutPpmTruck;
	}

	public void setCenOutPpmTruck(final CenOutPpmTruck cenOutPpmTruck) {
		this.cenOutPpmTruck = cenOutPpmTruck;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false) })
	public CenOutPpmFlights getCenOutPpmFlights() {
		return this.cenOutPpmFlights;
	}

	public void setCenOutPpmFlights(final CenOutPpmFlights cenOutPpmFlights) {
		this.cenOutPpmFlights = cenOutPpmFlights;
	}

	@Column(name = "NTYPE", nullable = false, precision = 12, scale = 0)
	public long getNtype() {
		return this.ntype;
	}

	public void setNtype(final long ntype) {
		this.ntype = ntype;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 40)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CTEXT", nullable = false, length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT_SHORT", nullable = false, length = 170)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "CADD_ON_TEXT", length = 80)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "NAREA_KEY", precision = 12, scale = 0)
	public Long getNareaKey() {
		return this.nareaKey;
	}

	public void setNareaKey(final Long nareaKey) {
		this.nareaKey = nareaKey;
	}

	@Column(name = "CAREA_CODE", length = 40)
	public String getCareaCode() {
		return this.careaCode;
	}

	public void setCareaCode(final String careaCode) {
		this.careaCode = careaCode;
	}

	@Column(name = "CAREA", length = 40)
	public String getCarea() {
		return this.carea;
	}

	public void setCarea(final String carea) {
		this.carea = carea;
	}

	@Column(name = "CUNIT_OF_ISSUE", length = 12)
	public String getCunitOfIssue() {
		return this.cunitOfIssue;
	}

	public void setCunitOfIssue(final String cunitOfIssue) {
		this.cunitOfIssue = cunitOfIssue;
	}

	@Column(name = "NWORKSTATION_KEY", precision = 12, scale = 0)
	public Long getNworkstationKey() {
		return this.nworkstationKey;
	}

	public void setNworkstationKey(final Long nworkstationKey) {
		this.nworkstationKey = nworkstationKey;
	}

	@Column(name = "CWORKSTATION", length = 80)
	public String getCworkstation() {
		return this.cworkstation;
	}

	public void setCworkstation(final String cworkstation) {
		this.cworkstation = cworkstation;
	}

	@Column(name = "CWORKSTATION_TEXT", length = 80)
	public String getCworkstationText() {
		return this.cworkstationText;
	}

	public void setCworkstationText(final String cworkstationText) {
		this.cworkstationText = cworkstationText;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NHEIGHT", precision = 12, scale = 0)
	public Long getNheight() {
		return this.nheight;
	}

	public void setNheight(final Long nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 12, scale = 0)
	public Long getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Long nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "CCLASS", length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NCLASS_NUMBER", precision = 12, scale = 0)
	public Long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final Long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NPL_DISTRIBUTION_KEY", precision = 12, scale = 0)
	public Long getNplDistributionKey() {
		return this.nplDistributionKey;
	}

	public void setNplDistributionKey(final Long nplDistributionKey) {
		this.nplDistributionKey = nplDistributionKey;
	}

	@Column(name = "CLOADINGLIST", length = 40)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "NPRINT", precision = 12, scale = 0)
	public Long getNprint() {
		return this.nprint;
	}

	public void setNprint(final Long nprint) {
		this.nprint = nprint;
	}

	@Column(name = "CMEAL_CONTROL_CODE", length = 12)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NLABEL_TYPE_KEY", precision = 12, scale = 0)
	public Long getNlabelTypeKey() {
		return this.nlabelTypeKey;
	}

	public void setNlabelTypeKey(final Long nlabelTypeKey) {
		this.nlabelTypeKey = nlabelTypeKey;
	}

	@Column(name = "NLABEL_TYPE", precision = 12, scale = 0)
	public Long getNlabelType() {
		return this.nlabelType;
	}

	public void setNlabelType(final Long nlabelType) {
		this.nlabelType = nlabelType;
	}

	@Column(name = "NDUPLICATED", precision = 12, scale = 0)
	public Long getNduplicated() {
		return this.nduplicated;
	}

	public void setNduplicated(final Long nduplicated) {
		this.nduplicated = nduplicated;
	}

	@Column(name = "NUNIT_PRIORITY", precision = 12, scale = 0)
	public Long getNunitPriority() {
		return this.nunitPriority;
	}

	public void setNunitPriority(final Long nunitPriority) {
		this.nunitPriority = nunitPriority;
	}

	@Column(name = "NCOMPUTE_LEG", precision = 12, scale = 0)
	public Long getNcomputeLeg() {
		return this.ncomputeLeg;
	}

	public void setNcomputeLeg(final Long ncomputeLeg) {
		this.ncomputeLeg = ncomputeLeg;
	}

	@Column(name = "NSEPARATOR", precision = 12, scale = 0)
	public Long getNseparator() {
		return this.nseparator;
	}

	public void setNseparator(final Long nseparator) {
		this.nseparator = nseparator;
	}

	@Column(name = "NMODIFIED", precision = 12, scale = 0)
	public Long getNmodified() {
		return this.nmodified;
	}

	public void setNmodified(final Long nmodified) {
		this.nmodified = nmodified;
	}

	@Column(name = "NGALLEY_GROUP", precision = 12, scale = 0)
	public Long getNgalleyGroup() {
		return this.ngalleyGroup;
	}

	public void setNgalleyGroup(final Long ngalleyGroup) {
		this.ngalleyGroup = ngalleyGroup;
	}

	@Column(name = "NPLTIMEFRAME_INDEX", precision = 12, scale = 0)
	public Long getNpltimeframeIndex() {
		return this.npltimeframeIndex;
	}

	public void setNpltimeframeIndex(final Long npltimeframeIndex) {
		this.npltimeframeIndex = npltimeframeIndex;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPROD_DATE", length = 7)
	public Date getDprodDate() {
		return this.dprodDate;
	}

	public void setDprodDate(final Date dprodDate) {
		this.dprodDate = dprodDate;
	}

	@Column(name = "NPLTYPE_KEY", precision = 12, scale = 0)
	public Long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "CPL_TYPE", length = 12)
	public String getCplType() {
		return this.cplType;
	}

	public void setCplType(final String cplType) {
		this.cplType = cplType;
	}

	@Column(name = "NLABEL_COUNTER", precision = 12, scale = 0)
	public Long getNlabelCounter() {
		return this.nlabelCounter;
	}

	public void setNlabelCounter(final Long nlabelCounter) {
		this.nlabelCounter = nlabelCounter;
	}

	@Column(name = "NCOMPUTE_NEXT_LEG", precision = 12, scale = 0)
	public Long getNcomputeNextLeg() {
		return this.ncomputeNextLeg;
	}

	public void setNcomputeNextLeg(final Long ncomputeNextLeg) {
		this.ncomputeNextLeg = ncomputeNextLeg;
	}

	@Column(name = "NSECONDS", precision = 13, scale = 5)
	public BigDecimal getNseconds() {
		return this.nseconds;
	}

	public void setNseconds(final BigDecimal nseconds) {
		this.nseconds = nseconds;
	}

	@Column(name = "NPHF_FLAG", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNphfFlag() {
		return this.nphfFlag;
	}

	public void setNphfFlag(final int nphfFlag) {
		this.nphfFlag = nphfFlag;
	}

	@Column(name = "NQUANTITY_VERS", precision = 15, scale = 3)
	public BigDecimal getNquantityVers() {
		return this.nquantityVers;
	}

	public void setNquantityVers(final BigDecimal nquantityVers) {
		this.nquantityVers = nquantityVers;
	}

	@Column(name = "NRESERVE", precision = 15, scale = 3)
	public BigDecimal getNreserve() {
		return this.nreserve;
	}

	public void setNreserve(final BigDecimal nreserve) {
		this.nreserve = nreserve;
	}

	@Column(name = "NQUANTITY_PROD", precision = 15, scale = 3)
	public BigDecimal getNquantityProd() {
		return this.nquantityProd;
	}

	public void setNquantityProd(final BigDecimal nquantityProd) {
		this.nquantityProd = nquantityProd;
	}

	@Column(name = "NQUANTITY_INVENTORY", precision = 15, scale = 3)
	public BigDecimal getNquantityInventory() {
		return this.nquantityInventory;
	}

	public void setNquantityInventory(final BigDecimal nquantityInventory) {
		this.nquantityInventory = nquantityInventory;
	}

	@Column(name = "NQUANTITY_ORIGINAL", precision = 15, scale = 3)
	public BigDecimal getNquantityOriginal() {
		return this.nquantityOriginal;
	}

	public void setNquantityOriginal(BigDecimal nquantityOriginal) {
		this.nquantityOriginal = nquantityOriginal;
	}

	@Column(name = "NQUANTITY_MULTIPLIER", precision = 15, scale = 3)
	public BigDecimal getNquantityMultiplier() {
		return this.nquantityMultiplier;
	}

	public void setNquantityMultiplier(BigDecimal nquantityMultiplier) {
		this.nquantityMultiplier = nquantityMultiplier;
	}

	@Column(name = "NBATCH_NO", precision = 12, scale = 0)
	public Long getNbatchNo() {
		return this.nbatchNo;
	}

	public void setNbatchNo(final Long nbatchNo) {
		this.nbatchNo = nbatchNo;
	}

	@Column(name = "NBATCH_SEQ", precision = 12, scale = 0)
	public Long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final Long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_START", length = 7)
	public Date getDtimeStart() {
		return this.dtimeStart;
	}

	public void setDtimeStart(final Date dtimeStart) {
		this.dtimeStart = dtimeStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_STOP", length = 7)
	public Date getDtimeStop() {
		return this.dtimeStop;
	}

	public void setDtimeStop(final Date dtimeStop) {
		this.dtimeStop = dtimeStop;
	}

	@Column(name = "NTEMP_START", precision = 12)
	public BigDecimal getNtempStart() {
		return this.ntempStart;
	}

	public void setNtempStart(final BigDecimal ntempStart) {
		this.ntempStart = ntempStart;
	}

	@Column(name = "NTEMP_START_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempStartManual() {
		return this.ntempStartManual;
	}

	public void setNtempStartManual(final Boolean ntempStartManual) {
		this.ntempStartManual = ntempStartManual;
	}

	@Column(name = "NTEMP_STOP", precision = 12)
	public BigDecimal getNtempStop() {
		return this.ntempStop;
	}

	public void setNtempStop(final BigDecimal ntempStop) {
		this.ntempStop = ntempStop;
	}

	@Column(name = "NTEMP_STOP_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempStopManual() {
		return this.ntempStopManual;
	}

	public void setNtempStopManual(final Boolean ntempStopManual) {
		this.ntempStopManual = ntempStopManual;
	}

	/**
	 * @return work order state value
	 * @see WorkOrderState
	 */
	@Column(name = "NSTATUS", nullable = false, precision = 3, scale = 0, columnDefinition = "number(3) default 0")
	public int getNstatus() {
		return this.nstatus;
	}

	/**
	 * @param nstatus work order state value
	 * @see WorkOrderState
	 */
	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "NMANUAL_SPLIT", nullable = false, precision = 3, scale = 0, columnDefinition = "number(3) default 0")
	public int getNmanualSplit() {
		return this.nmanualSplit;
	}

	public void setNmanualSplit(final int nmanualSplit) {
		this.nmanualSplit = nmanualSplit;
	}

	@Column(name = "CUSER_START", length = 40)
	public String getCuserStart() {
		return this.cuserStart;
	}

	public void setCuserStart(final String cuserStart) {
		this.cuserStart = cuserStart;
	}

	@Column(name = "CUSER_START2", length = 40)
	public String getCuserStart2() {
		return this.cuserStart2;
	}

	public void setCuserStart2(final String cuserStart2) {
		this.cuserStart2 = cuserStart2;
	}

	@Column(name = "CUSER_START3", length = 40)
	public String getCuserStart3() {
		return this.cuserStart3;
	}

	public void setCuserStart3(final String cuserStart3) {
		this.cuserStart3 = cuserStart3;
	}

	@Column(name = "CUSER_STOP", length = 40)
	public String getCuserStop() {
		return this.cuserStop;
	}

	public void setCuserStop(final String cuserStop) {
		this.cuserStop = cuserStop;
	}

	@Column(name = "NALERT_LEVEL", nullable = false, precision = 6, scale = 0, columnDefinition = "number(6) default 0")
	public int getNalertLevel() {
		return this.nalertLevel;
	}

	public void setNalertLevel(final int nalertLevel) {
		this.nalertLevel = nalertLevel;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
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

	@Column(name = "CANCESTOR_PACKINGLIST", length = 40)
	public String getCancestorPackinglist() {
		return this.cancestorPackinglist;
	}

	public void setCancestorPackinglist(final String cancestorPackinglist) {
		this.cancestorPackinglist = cancestorPackinglist;
	}

	@Column(name = "CSEQUENCE", length = 40)
	public String getCsequence() {
		return this.csequence;
	}

	public void setCsequence(final String csequence) {
		this.csequence = csequence;
	}

	public String getCschedule() {
		return cschedule;
	}

	public void setCschedule(final String cschedule) {
		this.cschedule = cschedule;
	}

	@Column(name = "CUSER_DETAILS", length = 40)
	public String getCuserDetails() {
		return this.cuserDetails;
	}

	public void setCuserDetails(final String cuserDetails) {
		this.cuserDetails = cuserDetails;
	}

	@Column(name = "CVERIFICATION_USER", length = 40)
	public String getCverificationUser() {
		return this.cverificationUser;
	}

	public void setCverificationUser(final String cverificationUser) {
		this.cverificationUser = cverificationUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVERIFICATION_DATE", length = 7)
	public Date getDverificationDate() {
		return this.dverificationDate;
	}

	public void setDverificationDate(final Date dverificationDate) {
		this.dverificationDate = dverificationDate;
	}

	@Column(name = "CREMARK_ACTION", length = 256)
	public String getCremarkAction() {
		return this.cremarkAction;
	}

	public void setCremarkAction(final String cremarkAction) {
		this.cremarkAction = cremarkAction;
	}

	@Column(name = "CWO_DESCRIPTION", length = 40)
	public String getCwoDescription() {
		return this.cwoDescription;
	}

	public void setCwoDescription(final String cwoDescription) {
		this.cwoDescription = cwoDescription;
	}

	@Column(name = "NWO_OFFSET", precision = 3, scale = 0)
	public Integer getNwoOffset() {
		return this.nwoOffset;
	}

	public void setNwoOffset(final Integer nwoOffset) {
		this.nwoOffset = nwoOffset;
	}

	@Column(name = "CWO_TIME_FROM", length = 5)
	public String getCwoTimeFrom() {
		return this.cwoTimeFrom;
	}

	public void setCwoTimeFrom(final String cwoTimeFrom) {
		this.cwoTimeFrom = cwoTimeFrom;
	}

	@Column(name = "CWO_TIME_TO", length = 5)
	public String getCwoTimeTo() {
		return this.cwoTimeTo;
	}

	public void setCwoTimeTo(final String cwoTimeTo) {
		this.cwoTimeTo = cwoTimeTo;
	}

	@Column(name = "NMAX_BATCH_SIZE", precision = 12, scale = 0)
	public Long getNmaxBatchSize() {
		return this.nmaxBatchSize;
	}

	public void setNmaxBatchSize(final Long nmaxBatchSize) {
		this.nmaxBatchSize = nmaxBatchSize;
	}

	@Column(name = "NSEQUENCE", precision = 6, scale = 0)
	public Integer getNsequence() {
		return this.nsequence;
	}

	public void setNsequence(final Integer nsequence) {
		this.nsequence = nsequence;
	}

	@Column(name = "NEMP_COUNT", precision = 3, scale = 0)
	public Integer getNempCount() {
		return this.nempCount;
	}

	public void setNempCount(final Integer nempCount) {
		this.nempCount = nempCount;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPLANNED_START", length = 7)
	public Date getDplannedStart() {
		return this.dplannedStart;
	}

	public void setDplannedStart(final Date dplannedStart) {
		this.dplannedStart = dplannedStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPLANNED_END", length = 7)
	public Date getDplannedEnd() {
		return this.dplannedEnd;
	}

	public void setDplannedEnd(final Date dplannedEnd) {
		this.dplannedEnd = dplannedEnd;
	}

	@Column(name = "NDURATION", precision = 6, scale = 0)
	public Integer getNduration() {
		return this.nduration;
	}

	public void setNduration(final Integer nduration) {
		this.nduration = nduration;
	}

	@Column(name = "NWORKSCHEDULE_INDEX", precision = 12, scale = 0)
	public Long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(final Long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@Column(name = "NROOM_TEMP", precision = 12)
	public BigDecimal getNroomTemp() {
		return this.nroomTemp;
	}

	public void setNroomTemp(final BigDecimal nroomTemp) {
		this.nroomTemp = nroomTemp;
	}

	@Column(name = "NGOLD_STANDARD", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNgoldStandard() {
		return this.ngoldStandard;
	}

	public void setNgoldStandard(final boolean ngoldStandard) {
		this.ngoldStandard = ngoldStandard;
	}

	@Column(name = "NAMBIENT_TRAY", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNambientTray() {
		return this.nambientTray;
	}

	public void setNambientTray(final boolean nambientTray) {
		this.nambientTray = nambientTray;
	}

	@Column(name = "NMOVED", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNmoved() {
		return this.nmoved;
	}

	public void setNmoved(final boolean nmoved) {
		this.nmoved = nmoved;
	}

	@Column(name = "NQUANTITY_PROD_PLANNED", precision = 15, scale = 3)
	public BigDecimal getNquantityProdPlanned() {
		return this.nquantityProdPlanned;
	}

	public void setNquantityProdPlanned(final BigDecimal nquantityProdPlanned) {
		this.nquantityProdPlanned = nquantityProdPlanned;
	}

	@Column(name = "NDURATION_SYNC", precision = 6, scale = 0)
	public Integer getNdurationSync() {
		return this.ndurationSync;
	}

	public void setNdurationSync(final Integer ndurationSync) {
		this.ndurationSync = ndurationSync;
	}

	@Column(name = "NINSERT_BY_SYNC", precision = 1, scale = 0)
	public Integer getNinsertBySync() {
		return ninsertBySync;
	}

	public void setNinsertBySync(final Integer ninsertBySync) {
		this.ninsertBySync = ninsertBySync;
	}

	@Column(name = "NCAPACITY", precision = 7, scale = 0)
	public Integer getNcapacity() {
		return this.ncapacity;
	}

	public void setNcapacity(final Integer ncapacity) {
		this.ncapacity = ncapacity;
	}

	@Column(name = "CUNIT_CAPACITY", length = 40)
	public String getCunitCapacity() {
		return this.cunitCapacity;
	}

	public void setCunitCapacity(final String cunitCapacity) {
		this.cunitCapacity = cunitCapacity;
	}

	@Column(name = "NRUNRATE", precision = 15, scale = 3)
	public BigDecimal getNrunrate() {
		return this.nrunrate;
	}

	public void setNrunrate(final BigDecimal nrunrate) {
		this.nrunrate = nrunrate;
	}

	@Column(name = "NSETUPRATE", precision = 15, scale = 3)
	public BigDecimal getNsetuprate() {
		return this.nsetuprate;
	}

	public void setNsetuprate(final BigDecimal nsetuprate) {
		this.nsetuprate = nsetuprate;
	}

	@Column(name = "NPLTF_FLIGHT_INDEX_GROUP", precision = 12, scale = 0)
	public Long getNpltfFlightIndexGroup() {
		return this.npltfFlightIndexGroup;
	}

	public void setNpltfFlightIndexGroup(final Long npltfFlightIndexGroup) {
		this.npltfFlightIndexGroup = npltfFlightIndexGroup;
	}

	@Column(name = "CUSER_LOCK", length = 40)
	public String getCuserLock() {
		return this.cuserLock;
	}

	public void setCuserLock(final String cuserLock) {
		this.cuserLock = cuserLock;
	}

	@Column(name = "NPPMTRAIL_KEY", precision = 12, scale = 0)
	public Long getNppmtrailKey() {
		return this.nppmtrailKey;
	}

	public void setNppmtrailKey(final Long nppmtrailKey) {
		this.nppmtrailKey = nppmtrailKey;
	}

	@Column(name = "CTEXT_LOC_UNIT_PL_PROD_LABEL", length = 40)
	public String getCtextLocUnitPlProdLabel() {
		return this.ctextLocUnitPlProdLabel;
	}

	public void setCtextLocUnitPlProdLabel(final String ctextLocUnitPlProdLabel) {
		this.ctextLocUnitPlProdLabel = ctextLocUnitPlProdLabel;
	}

	@Column(name = "NSECTOR_KEY", precision = 12, scale = 0)
	public Long getNsectorKey() {
		return this.nsectorKey;
	}

	public void setNsectorKey(final Long nsectorKey) {
		this.nsectorKey = nsectorKey;
	}

	@Column(name = "CSECTOR", length = 40)
	public String getCsector() {
		return this.csector;
	}

	public void setCsector(final String csector) {
		this.csector = csector;
	}

	@Column(name = "NBATCH_SEQ_PROD_LABEL", nullable = false, precision = 12, scale = 0, columnDefinition = "number(12) default 0")
	public long getNbatchSeqProdLabel() {
		return this.nbatchSeqProdLabel;
	}

	public void setNbatchSeqProdLabel(final long nbatchSeqProdLabel) {
		this.nbatchSeqProdLabel = nbatchSeqProdLabel;
	}

	@Column(name = "NBATCH", precision = 1, scale = 0)
	public Integer getNbatch() {
		return this.nbatch;
	}

	public void setNbatch(final Integer nbatch) {
		this.nbatch = nbatch;
	}

	@Column(name = "NCONTAINER_STATUS", nullable = false, precision = 3, scale = 0, columnDefinition = "number(3) default 0")
	public int getNcontainerStatus() {
		return this.ncontainerStatus;
	}

	public void setNcontainerStatus(final int ncontainerStatus) {
		this.ncontainerStatus = ncontainerStatus;
	}

	@Column(name = "NPACKINGLIST_KEY", precision = 12, scale = 0)
	public Long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "NSPML_QTY_PRINTED", nullable = false, precision = 3, scale = 0, columnDefinition = "number(3) default -1")
	public int getNspmlQtyPrinted() {
		return this.nspmlQtyPrinted;
	}

	public void setNspmlQtyPrinted(final int nspmlQtyPrinted) {
		this.nspmlQtyPrinted = nspmlQtyPrinted;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpm")
	public Set<CenOutPpmCo> getCenOutPpmCos() {
		return this.cenOutPpmCos;
	}

	public void setCenOutPpmCos(final Set<CenOutPpmCo> cenOutPpmCos) {
		this.cenOutPpmCos = cenOutPpmCos;
	}

	/**
	 * Get cenOutPpmSched
	 *
	 * @return the cenOutPpmSched
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_SCHED_KEY", nullable = false)
	public CenOutPpmSched getCenOutPpmSched() {
		return cenOutPpmSched;
	}

	/**
	 * set cenOutPpmSched
	 *
	 * @param cenOutPpmSched the cenOutPpmSched to set
	 */
	public void setCenOutPpmSched(final CenOutPpmSched cenOutPpmSched) {
		this.cenOutPpmSched = cenOutPpmSched;
	}

	/**
	 * Checks if the given corresponds to the current status.
	 *
	 * @param status for check
	 * @return {@code true} if current state corresponds to given status, otherwise {@code false}
	 */
	public boolean isNstatus(final WorkOrderState status) {
		return getNstatus() == status.getStateValue();

	}

	/**
	 * Checks if the current status is higher than the given
	 *
	 * @param status for check
	 * @return {@code true} if the current state is higher, otherwise {@code false}
	 */
	public boolean isNstatusGreaterOrEqual(final WorkOrderState status) {
		return getNstatus() >= status.getStateValue();
	}

	/** {@inheritDoc} */
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toStringExclude(this, new String[] { "cenOutPpmFlights", "cenOutPpmCos" });
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "NGALLEY_KEY", precision = 12, scale = 0)
	public Long getNgalleyKey() {
		return this.ngalleyKey;
	}

	public void setNgalleyKey(final Long ngalleyKey) {
		this.ngalleyKey = ngalleyKey;
	}

	@Column(name = "CGALLEY", length = 12)
	public String getCgalley() {
		return this.cgalley;
	}

	public void setCgalley(final String cgalley) {
		this.cgalley = cgalley;
	}

	@Column(name = "NSTOWAGE_KEY", precision = 12, scale = 0)
	public Long getNstowageKey() {
		return this.nstowageKey;
	}

	public void setNstowageKey(final Long nstowageKey) {
		this.nstowageKey = nstowageKey;
	}

	@Column(name = "CSTOWAGE", length = 12)
	public String getCstowage() {
		return this.cstowage;
	}

	public void setCstowage(final String cstowage) {
		this.cstowage = cstowage;
	}

	@Column(name = "CPLACE", length = 12)
	public String getCplace() {
		return this.cplace;
	}

	public void setCplace(final String cplace) {
		this.cplace = cplace;
	}

	@Column(name = "NGALLEY_SORT", precision = 12, scale = 0)
	public Long getNgalleySort() {
		return this.ngalleySort;
	}

	public void setNgalleySort(final Long ngalleySort) {
		this.ngalleySort = ngalleySort;
	}

	@Column(name = "NSTOWAGE_SORT", precision = 12, scale = 0)
	public Long getNstowageSort() {
		return this.nstowageSort;
	}

	public void setNstowageSort(final Long nstowageSort) {
		this.nstowageSort = nstowageSort;
	}

	@Column(name = "NBELLY_CONTAINER", precision = 12, scale = 0)
	public Long getNbellyContainer() {
		return this.nbellyContainer;
	}

	public void setNbellyContainer(final Long nbellyContainer) {
		this.nbellyContainer = nbellyContainer;
	}

	@Column(name = "NPRODLABEL_HASH", precision = 15, scale = 0)
	public Long getNprodlabelHash() {
		return this.nprodlabelHash;
	}

	public void setNprodlabelHash(final Long nprodlabelHash) {
		this.nprodlabelHash = nprodlabelHash;
	}

	@Column(name = "NPRINT_FLIGHTLABEL", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNprintFlightlabel() {
		return this.nprintFlightlabel;
	}

	public void setNprintFlightlabel(final int nprintFlightlabel) {
		this.nprintFlightlabel = nprintFlightlabel;
	}

	@Column(name = "NSHORTAGEWASTAGE_KEY", precision = 12, scale = 0)
	public Long getNshortagewastageKey() {
		return this.nshortagewastageKey;
	}

	public void setNshortagewastageKey(final Long nshortagewastageKey) {
		this.nshortagewastageKey = nshortagewastageKey;
	}

	@Column(name = "CSW_REASON", length = 50)
	public String getCswReason() {
		return this.cswReason;
	}

	public void setCswReason(final String cswReason) {
		this.cswReason = cswReason;
	}

	@Column(name = "NCHANGE_OVER_TIME", precision = 7, scale = 0)
	public Integer getNchangeOverTime() {
		return this.nchangeOverTime;
	}

	public void setNchangeOverTime(final Integer nchangeOverTime) {
		this.nchangeOverTime = nchangeOverTime;
	}

	@Column(name = "NBLOCK_BY_SMD", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNblockBySmd() {
		return this.nblockBySmd;
	}

	public void setNblockBySmd(final int nblockBySmd) {
		this.nblockBySmd = nblockBySmd;
	}

	@Column(name = "NPREPRODUCTION", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public int getNpreproduction() {
		return this.npreproduction;
	}

	public void setNpreproduction(final int npreproduction) {
		this.npreproduction = npreproduction;
	}

	@Column(name = "NSEQUENCE_GROUP", nullable = false, precision = 12, scale = 0, columnDefinition = "number(12) default 0")
	public long getNsequenceGroup() {
		return this.nsequenceGroup;
	}

	public void setNsequenceGroup(final long nsequenceGroup) {
		this.nsequenceGroup = nsequenceGroup;
	}

	@Column(name = "NCSO_STATUS", nullable = false, precision = 5, scale = 0, columnDefinition = "number(5) default 0")
	public int getNcsoStatus() {
		return this.ncsoStatus;
	}

	public void setNcsoStatus(final int ncsoStatus) {
		this.ncsoStatus = ncsoStatus;
	}

	@Column(name = "CCSO_USER", length = 40)
	public String getCcsoUser() {
		return this.ccsoUser;
	}

	public void setCcsoUser(final String ccsoUser) {
		this.ccsoUser = ccsoUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCSO_DATE", length = 7)
	public Date getDcsoDate() {
		return this.dcsoDate;
	}

	public void setDcsoDate(final Date dcsoDate) {
		this.dcsoDate = dcsoDate;
	}

	@Column(name = "CSERVING_UNIT", length = 4)
	public String getCservingUnit() {
		return cservingUnit;
	}

	public void setCservingUnit(final String cservingUnit) {
		this.cservingUnit = cservingUnit;
	}

	@Column(name = "NINCREASE_LABELS_PRINTED", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default -1")
	public int getNincreaseLabelsPrinted() {
		return this.nincreaseLabelsPrinted;
	}

	public void setNincreaseLabelsPrinted(final int nincreaseLabelsPrinted) {
		this.nincreaseLabelsPrinted = nincreaseLabelsPrinted;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 15, scale = 6)
	public BigDecimal getNquantityRecipe() {
		return this.nquantityRecipe;
	}

	public void setNquantityRecipe(final BigDecimal nquantityRecipe) {
		this.nquantityRecipe = nquantityRecipe;
	}

	@Column(name = "CUNIT_RECIPE", length = 5)
	public String getCunitRecipe() {
		return this.cunitRecipe;
	}

	public void setCunitRecipe(final String cunitRecipe) {
		this.cunitRecipe = cunitRecipe;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DEXPIRY_DATE", length = 7)
	public Date getDexpiryDate() {
		return this.dexpiryDate;
	}

	public void setDexpiryDate(final Date dexpiryDate) {
		this.dexpiryDate = dexpiryDate;
	}

	@Column(name = "NSTOWAGE_KEY_OLD", nullable = true, precision = 12, scale = 0)
	public Long getNstowageKeyOld() {
		return nstowageKeyOld;
	}

	public void setNstowageKeyOld(final Long nstowageKeyOld) {
		this.nstowageKeyOld = nstowageKeyOld;
	}

	@Column(name = "CSTORAGE_OLD", nullable = true, length = 40)
	public String getCstorageOld() {
		return cstorageOld;
	}

	public void setCstorageOld(final String cstorageOld) {
		this.cstorageOld = cstorageOld;
	}

	@Column(name = "NDISPOSE", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNdispose() {
		return ndispose;
	}

	/**
	 * @param ndispose the ndispose to set
	 */
	public void setNdispose(final boolean ndispose) {
		this.ndispose = ndispose;
	}

	@Column(name = "CCUSTOMER_PL", length = 54)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 150)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutPpm")
	public Set<CenOutPpmCsoState> getCenOutPpmCsoStates() {
		return this.cenOutPpmCsoStates;
	}

	public void setCenOutPpmCsoStates(final Set<CenOutPpmCsoState> cenOutPpmCsoStates) {
		this.cenOutPpmCsoStates = cenOutPpmCsoStates;
	}

	@Column(name = "NOVERPRODUCTION", nullable = false, precision = 1, scale = 0, columnDefinition = "number(1) default 0")
	public boolean isNoverproduction() {
		return this.noverproduction;
	}

	public void setNoverproduction(final boolean noverproduction) {
		this.noverproduction = noverproduction;
	}

	@Column(name = "NTEMP_COOKING_FINISHED", precision = 12)
	public BigDecimal getNtempCookingFinished() {
		return this.ntempCookingFinished;
	}

	public void setNtempCookingFinished(BigDecimal ntempCookingFinished) {
		this.ntempCookingFinished = ntempCookingFinished;
	}

	@Column(name = "NTEMP_COOKING_FINISHED_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempCookingFinishedManual() {
		return this.ntempCookingFinishedManual;
	}

	public void setNtempCookingFinishedManual(final Boolean ntempCookingFinishedManual) {
		this.ntempCookingFinishedManual = ntempCookingFinishedManual;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_COOKING_FINISHED", length = 7)
	public Date getDtimeCookingFinished() {
		return this.dtimeCookingFinished;
	}

	public void setDtimeCookingFinished(Date dtimeCookingFinished) {
		this.dtimeCookingFinished = dtimeCookingFinished;
	}

	@Column(name = "CUSER_COOKING_FINISHED", length = 40)
	public String getCuserCookingFinished() {
		return this.cuserCookingFinished;
	}

	public void setCuserCookingFinished(String cuserCookingFinished) {
		this.cuserCookingFinished = cuserCookingFinished;
	}

	@Column(name = "NPRODUCT_SEARED", precision = 1, scale = 0)
	public Boolean getNproductSeared() {
		return this.nproductSeared;
	}

	public void setNproductSeared(Boolean nproductSeared) {
		this.nproductSeared = nproductSeared;
	}

	@Column(name = "NTEMP_CHILLING_STARTED", precision = 12)
	public BigDecimal getNtempChillingStarted() {
		return this.ntempChillingStarted;
	}

	public void setNtempChillingStarted(BigDecimal ntempChillingStarted) {
		this.ntempChillingStarted = ntempChillingStarted;
	}

	@Column(name = "NTEMP_CHILLING_STARTED_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempChillingStartedManual() {
		return this.ntempChillingStartedManual;
	}

	public void setNtempChillingStartedManual(final Boolean ntempChillingStartedManual) {
		this.ntempChillingStartedManual = ntempChillingStartedManual;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_CHILLING_STARTED", length = 7)
	public Date getDtimeChillingStarted() {
		return this.dtimeChillingStarted;
	}

	public void setDtimeChillingStarted(Date dtimeChillingStarted) {
		this.dtimeChillingStarted = dtimeChillingStarted;
	}

	@Column(name = "NTEMP_CHILLING_FINISHED", precision = 12)
	public BigDecimal getNtempChillingFinished() {
		return this.ntempChillingFinished;
	}

	public void setNtempChillingFinished(BigDecimal ntempChillingFinished) {
		this.ntempChillingFinished = ntempChillingFinished;
	}

	@Column(name = "NTEMP_CHILLING_FINISHED_MANUAL", precision = 1, scale = 0)
	public Boolean getNtempChillingFinishedManual() {
		return this.ntempChillingFinishedManual;
	}

	public void setNtempChillingFinishedManual(final Boolean ntempChillingFinishedManual) {
		this.ntempChillingFinishedManual = ntempChillingFinishedManual;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIME_CHILLING_FINISHED", length = 7)
	public Date getDtimeChillingFinished() {
		return this.dtimeChillingFinished;
	}

	public void setDtimeChillingFinished(Date dtimeChillingFinished) {
		this.dtimeChillingFinished = dtimeChillingFinished;
	}

	@Column(name = "CUSER_CHILLING_FINISHED", length = 40)
	public String getCuserChillingFinished() {
		return this.cuserChillingFinished;
	}

	public void setCuserChillingFinished(String cuserChillingFinished) {
		this.cuserChillingFinished = cuserChillingFinished;
	}

}
