package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Formula;
import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;

/**
 * Entity(DomainObject) for table CEN_PACKINGLISTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLISTS",
		uniqueConstraints = @UniqueConstraint(columnNames = { "NPACKINGLIST_INDEX_KEY", "DVALID_FROM", "DVALID_TO" }))
public class CenPackinglists implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenPackinglistsId id;
	private CenAirlineAccounts cenAirlineAccounts;
	private CenPackinglistIndex cenPackinglistIndex;
	private SysPackinglistTypes sysPackinglistTypes;
	private CenPackinglistTypes cenPackinglistTypes;
	private CenLabelType cenLabelType;
	private Date dvalidFrom;
	private Date dvalidTo;
	private long npackinglistKey;
	private long nequipmentSizeKey;
	private int nnumberPackages;
	private String cunit;
	private String ctext;
	private String ctextShort;
	private String caddOnText;
	private int npackingListLevel;
	private BigDecimal nweight;
	private Integer nreleaseNumber;
	private String cclassRemark;
	private String ctoken;
	private Date dtimestampModification;
	private Long nairlineKey;
	private String ccustomerPl;
	private Date dtimestampImport;
	private Long nsysaccountKey;
	private Integer nrefund;
	private Integer nportions;
	private BigDecimal nyield;
	private String cunitWeight;
	private String ctextMenu;
	private Long ncostTypeKey;
	private String ctextLong;
	private String cdistance;
	private BigDecimal nquantityRecipe;
	private String cunitRecipe;
	private Integer nmealFlag;
	private Integer nsalvage;
	private Long npriceGroupKey;
	private String ccustomerText;
	private Long nmaterialStatusKey;
	private Integer ndrawerHeight;
	private String coldPackinglistno;
	private String cbaseQntyUnit;
	private String cphfTag;
	private Long npackinglistStateKey;
	private String clsgClass1;
	private String clsgClass2;
	private String clsgClass3;
	private String clsgClass4;
	private String crotation1;
	private String crotation2;
	private String crotation3;
	private String cservice1;
	private String cservice2;
	private String cservice3;
	private String cprodType;
	private String cplUsage;
	private String cregional;
	private String cseasonal;
	private String cmealCat;
	private String cplLoadingType;
	private String cvalueLoadingType;
	private String cweightType;
	private String crouting1;
	private String crouting2;
	private String crouting3;
	private String cdefStorageLocation;
	private String ctopLevel;
	private String crevLevel;
	private String cprocessingStatus;
	private String csortl;
	private String cfertart;
	private String cmatText;
	private String cusername;
	private String cchangeNo;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private int nphfFlag;
	private String cskategorie;
	private int niscompleteCosting;
	private String cusernameCosting;
	private Date dtimestampCosting;
	private int niscompletePricing;
	private String cusernamePricing;
	private Date dtimestampPricing;
	private String cworkcenter;
	private long nccplog3;
	private int nccplog4;
	private int nalgRelv;
	private int nalgAppr;
	private String cunitareaUk;
	private Long njasperKey;
	private Integer nlvormSap;
	private String cprodCat;
	private int nprodRating;
	private Integer naddDeliveryFlag;
	private Integer nqtyLockedFlag;
	private Integer npriceLockedFlag;
	private String ctext1;
	private String ctext2;
	private String ctext3;
	private Long nvaluechaincatKey;
	private String ctextShort2;
	private Integer nmmdFlag;
	private Long ncuisineCatKey;
	private String csequence;
	private Long nmatGrpValKey1;
	private Long nmatGrpValKey2;
	private String ccountryOfOriginAnimalProtein;
	private BigDecimal nalcoholPercentage;
	private Integer nserviceClass;
	private Integer nconsumable;
	private BigDecimal nrotableConsumableFactor;
	private BigDecimal nrotableConsumableFactorManual;
	private String cpurchasingSource;
	private CenPackinglistInstructions cenPackinglistInstructions;
	private CenPackinglistPictures cenPackinglistPictures;
	private Set<CenPackinglistDetail> cenPackinglistDetails = new HashSet<>(0);
	private Set<CenPackinglistEuAlg> cenPackinglistEuAlgs = new HashSet<>(0);
	private Set<CenPackinglistProject> cenPackinglistProjects = new HashSet<>(0);
	private Set<CenPackinglistCscVal> cenPackinglistCscVals = new HashSet<>(0);
	private Set<CenPriceDefSnapshotPl> cenPriceDefSnapshotPls = new HashSet<>(0);
	private Set<CenPriceSnapshotPl> cenPriceSnapshotPls = new HashSet<>(0);
	private Set<CenCostSnapPlSum> cenCostSnapPlSums = new HashSet<>(0);
	/** List of Ratings because of multiple {@link SysPlRatingType} */
	private Set<CenPlRatingType> cenPlRatingTypes = new HashSet<>(0);

	private Set<CenPlMpProject> cenPlMpProjects = new HashSet<CenPlMpProject>(0);

	/** Total Rating of all rating types */
	private CenPlRatingTotal cenPlRatingTotal;
	/** To know if there is an instruction avail */
	private boolean instructionFound;
	/** to know if more than one validity is existing. */
	private boolean multipleValiditiesFound;
	/** Additional inflight related attributes */
	private CenPackinglistIf cenPackinglistIf;
	private CenPackinglistMaterial cenPackinglistMaterial;

	/** Additional menu presentation related attributes */
	private CenMpDesignItemlist cenMpDesignItemlist;

	/** List of packing list dimensions */
	private Set<CenPackinglistSize> cenPackinglistSizes = new HashSet<>(0);

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "npackinglistIndexKey", column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistDetailKey", column = @Column(name = "NPACKINGLIST_DETAIL_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenPackinglistsId getId() {
		return this.id;
	}

	public void setId(final CenPackinglistsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NACCOUNT_KEY")
	public CenAirlineAccounts getCenAirlineAccounts() {
		return this.cenAirlineAccounts;
	}

	public void setCenAirlineAccounts(final CenAirlineAccounts cenAirlineAccounts) {
		this.cenAirlineAccounts = cenAirlineAccounts;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false)
	public CenPackinglistIndex getCenPackinglistIndex() {
		return this.cenPackinglistIndex;
	}

	public void setCenPackinglistIndex(final CenPackinglistIndex cenPackinglistIndex) {
		this.cenPackinglistIndex = cenPackinglistIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPLTYPE_KEY", nullable = false)
	public SysPackinglistTypes getSysPackinglistTypes() {
		return this.sysPackinglistTypes;
	}

	public void setSysPackinglistTypes(final SysPackinglistTypes sysPackinglistTypes) {
		this.sysPackinglistTypes = sysPackinglistTypes;
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

	@Column(name = "NPACKINGLIST_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "NEQUIPMENT_SIZE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNequipmentSizeKey() {
		return this.nequipmentSizeKey;
	}

	public void setNequipmentSizeKey(final long nequipmentSizeKey) {
		this.nequipmentSizeKey = nequipmentSizeKey;
	}

	@Column(name = "NNUMBER_PACKAGES", nullable = false, precision = 6, scale = 0)
	public int getNnumberPackages() {
		return this.nnumberPackages;
	}

	public void setNnumberPackages(final int nnumberPackages) {
		this.nnumberPackages = nnumberPackages;
	}

	@Column(name = "CUNIT", nullable = false, length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CTEXT_SHORT", length = 40)
	public String getCtextShort() {
		return this.ctextShort;
	}

	public void setCtextShort(final String ctextShort) {
		this.ctextShort = ctextShort;
	}

	@Column(name = "CADD_ON_TEXT", length = 40)
	public String getCaddOnText() {
		return this.caddOnText;
	}

	public void setCaddOnText(final String caddOnText) {
		this.caddOnText = caddOnText;
	}

	@Column(name = "NPACKING_LIST_LEVEL", nullable = false, precision = 2, scale = 0)
	public int getNpackingListLevel() {
		return this.npackingListLevel;
	}

	public void setNpackingListLevel(final int npackingListLevel) {
		this.npackingListLevel = npackingListLevel;
	}

	@Column(name = "NWEIGHT", nullable = false, precision = 10, scale = 3)
	public BigDecimal getNweight() {
		return this.nweight;
	}

	public void setNweight(final BigDecimal nweight) {
		this.nweight = nweight;
	}

	@Column(name = "NRELEASE_NUMBER", precision = 6, scale = 0)
	public Integer getNreleaseNumber() {
		return this.nreleaseNumber;
	}

	public void setNreleaseNumber(final Integer nreleaseNumber) {
		this.nreleaseNumber = nreleaseNumber;
	}

	@Column(name = "CCLASS_REMARK", length = 5)
	public String getCclassRemark() {
		return this.cclassRemark;
	}

	public void setCclassRemark(final String cclassRemark) {
		this.cclassRemark = cclassRemark;
	}

	@Column(name = "CTOKEN", length = 5)
	public String getCtoken() {
		return this.ctoken;
	}

	public void setCtoken(final String ctoken) {
		this.ctoken = ctoken;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_MODIFICATION", length = 7)
	public Date getDtimestampModification() {
		return this.dtimestampModification;
	}

	public void setDtimestampModification(final Date dtimestampModification) {
		this.dtimestampModification = dtimestampModification;
	}

	@Column(name = "NAIRLINE_KEY", precision = 12, scale = 0)
	public Long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final Long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_IMPORT", length = 7)
	public Date getDtimestampImport() {
		return this.dtimestampImport;
	}

	public void setDtimestampImport(final Date dtimestampImport) {
		this.dtimestampImport = dtimestampImport;
	}

	@Column(name = "NSYSACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(final Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "NREFUND", precision = 1, scale = 0)
	public Integer getNrefund() {
		return this.nrefund;
	}

	public void setNrefund(final Integer nrefund) {
		this.nrefund = nrefund;
	}

	@Column(name = "NPORTIONS", precision = 3, scale = 0)
	public Integer getNportions() {
		return this.nportions;
	}

	public void setNportions(final Integer nportions) {
		this.nportions = nportions;
	}

	@Column(name = "NYIELD", precision = 6)
	public BigDecimal getNyield() {
		return this.nyield;
	}

	public void setNyield(final BigDecimal nyield) {
		this.nyield = nyield;
	}

	@Column(name = "CUNIT_WEIGHT", length = 5)
	public String getCunitWeight() {
		return this.cunitWeight;
	}

	public void setCunitWeight(final String cunitWeight) {
		this.cunitWeight = cunitWeight;
	}

	@Column(name = "CTEXT_MENU", length = 1000)
	public String getCtextMenu() {
		return this.ctextMenu;
	}

	public void setCtextMenu(final String ctextMenu) {
		this.ctextMenu = ctextMenu;
	}

	@Column(name = "NCOST_TYPE_KEY", precision = 12, scale = 0)
	public Long getNcostTypeKey() {
		return this.ncostTypeKey;
	}

	public void setNcostTypeKey(final Long ncostTypeKey) {
		this.ncostTypeKey = ncostTypeKey;
	}

	@Column(name = "CTEXT_LONG", length = 70)
	public String getCtextLong() {
		return this.ctextLong;
	}

	public void setCtextLong(final String ctextLong) {
		this.ctextLong = ctextLong;
	}

	@Column(name = "CDISTANCE", length = 15)
	public String getCdistance() {
		return this.cdistance;
	}

	public void setCdistance(final String cdistance) {
		this.cdistance = cdistance;
	}

	@Column(name = "NQUANTITY_RECIPE", precision = 12, scale = 6)
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

	@Column(name = "NMEAL_FLAG", precision = 1, scale = 0)
	public Integer getNmealFlag() {
		return this.nmealFlag;
	}

	public void setNmealFlag(final Integer nmealFlag) {
		this.nmealFlag = nmealFlag;
	}

	@Column(name = "NSALVAGE", precision = 1, scale = 0)
	public Integer getNsalvage() {
		return this.nsalvage;
	}

	public void setNsalvage(final Integer nsalvage) {
		this.nsalvage = nsalvage;
	}

	@Column(name = "NPRICE_GROUP_KEY", precision = 12, scale = 0)
	public Long getNpriceGroupKey() {
		return this.npriceGroupKey;
	}

	public void setNpriceGroupKey(final Long npriceGroupKey) {
		this.npriceGroupKey = npriceGroupKey;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 50)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@Column(name = "NMATERIAL_STATUS_KEY", precision = 12, scale = 0)
	public Long getNmaterialStatusKey() {
		return this.nmaterialStatusKey;
	}

	public void setNmaterialStatusKey(final Long nmaterialStatusKey) {
		this.nmaterialStatusKey = nmaterialStatusKey;
	}

	@Column(name = "NDRAWER_HEIGHT", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNdrawerHeight() {
		return this.ndrawerHeight;
	}

	public void setNdrawerHeight(final Integer ndrawerHeight) {
		this.ndrawerHeight = ndrawerHeight;
	}

	@Column(name = "COLD_PACKINGLISTNO", length = 18)
	public String getColdPackinglistno() {
		return this.coldPackinglistno;
	}

	public void setColdPackinglistno(final String coldPackinglistno) {
		this.coldPackinglistno = coldPackinglistno;
	}

	@Column(name = "CBASE_QNTY_UNIT", length = 3)
	public String getCbaseQntyUnit() {
		return this.cbaseQntyUnit;
	}

	public void setCbaseQntyUnit(final String cbaseQntyUnit) {
		this.cbaseQntyUnit = cbaseQntyUnit;
	}

	@Column(name = "CPHF_TAG", length = 2)
	public String getCphfTag() {
		return this.cphfTag;
	}

	public void setCphfTag(final String cphfTag) {
		this.cphfTag = cphfTag;
	}

	@Column(name = "NPACKINGLIST_STATE_KEY", precision = 13, scale = 0)
	public Long getNpackinglistStateKey() {
		return this.npackinglistStateKey;
	}

	public void setNpackinglistStateKey(final Long npackinglistStateKey) {
		this.npackinglistStateKey = npackinglistStateKey;
	}

	@Column(name = "CLSG_CLASS1", length = 2)
	public String getClsgClass1() {
		return this.clsgClass1;
	}

	public void setClsgClass1(final String clsgClass1) {
		this.clsgClass1 = clsgClass1;
	}

	@Column(name = "CLSG_CLASS2", length = 2)
	public String getClsgClass2() {
		return this.clsgClass2;
	}

	public void setClsgClass2(final String clsgClass2) {
		this.clsgClass2 = clsgClass2;
	}

	@Column(name = "CLSG_CLASS3", length = 2)
	public String getClsgClass3() {
		return this.clsgClass3;
	}

	public void setClsgClass3(final String clsgClass3) {
		this.clsgClass3 = clsgClass3;
	}

	@Column(name = "CLSG_CLASS4", length = 2)
	public String getClsgClass4() {
		return this.clsgClass4;
	}

	public void setClsgClass4(final String clsgClass4) {
		this.clsgClass4 = clsgClass4;
	}

	@Column(name = "CROTATION1", length = 2)
	public String getCrotation1() {
		return this.crotation1;
	}

	public void setCrotation1(final String crotation1) {
		this.crotation1 = crotation1;
	}

	@Column(name = "CROTATION2", length = 2)
	public String getCrotation2() {
		return this.crotation2;
	}

	public void setCrotation2(final String crotation2) {
		this.crotation2 = crotation2;
	}

	@Column(name = "CROTATION3", length = 2)
	public String getCrotation3() {
		return this.crotation3;
	}

	public void setCrotation3(final String crotation3) {
		this.crotation3 = crotation3;
	}

	@Column(name = "CSERVICE1", length = 3)
	public String getCservice1() {
		return this.cservice1;
	}

	public void setCservice1(final String cservice1) {
		this.cservice1 = cservice1;
	}

	@Column(name = "CSERVICE2", length = 3)
	public String getCservice2() {
		return this.cservice2;
	}

	public void setCservice2(final String cservice2) {
		this.cservice2 = cservice2;
	}

	@Column(name = "CSERVICE3", length = 3)
	public String getCservice3() {
		return this.cservice3;
	}

	public void setCservice3(final String cservice3) {
		this.cservice3 = cservice3;
	}

	@Column(name = "CPROD_TYPE", length = 2)
	public String getCprodType() {
		return this.cprodType;
	}

	public void setCprodType(final String cprodType) {
		this.cprodType = cprodType;
	}

	@Column(name = "CPL_USAGE", length = 1)
	public String getCplUsage() {
		return this.cplUsage;
	}

	public void setCplUsage(final String cplUsage) {
		this.cplUsage = cplUsage;
	}

	@Column(name = "CREGIONAL", length = 2)
	public String getCregional() {
		return this.cregional;
	}

	public void setCregional(final String cregional) {
		this.cregional = cregional;
	}

	@Column(name = "CSEASONAL", length = 1)
	public String getCseasonal() {
		return this.cseasonal;
	}

	public void setCseasonal(final String cseasonal) {
		this.cseasonal = cseasonal;
	}

	@Column(name = "CMEAL_CAT", length = 3)
	public String getCmealCat() {
		return this.cmealCat;
	}

	public void setCmealCat(final String cmealCat) {
		this.cmealCat = cmealCat;
	}

	@Column(name = "CPL_LOADING_TYPE", length = 1)
	public String getCplLoadingType() {
		return this.cplLoadingType;
	}

	public void setCplLoadingType(final String cplLoadingType) {
		this.cplLoadingType = cplLoadingType;
	}

	@Column(name = "CVALUE_LOADING_TYPE", length = 30)
	public String getCvalueLoadingType() {
		return this.cvalueLoadingType;
	}

	public void setCvalueLoadingType(final String cvalueLoadingType) {
		this.cvalueLoadingType = cvalueLoadingType;
	}

	@Column(name = "CWEIGHT_TYPE", length = 1)
	public String getCweightType() {
		return this.cweightType;
	}

	public void setCweightType(final String cweightType) {
		this.cweightType = cweightType;
	}

	@Column(name = "CROUTING1", length = 1)
	public String getCrouting1() {
		return this.crouting1;
	}

	public void setCrouting1(final String crouting1) {
		this.crouting1 = crouting1;
	}

	@Column(name = "CROUTING2", length = 1)
	public String getCrouting2() {
		return this.crouting2;
	}

	public void setCrouting2(final String crouting2) {
		this.crouting2 = crouting2;
	}

	@Column(name = "CROUTING3", length = 1)
	public String getCrouting3() {
		return this.crouting3;
	}

	public void setCrouting3(final String crouting3) {
		this.crouting3 = crouting3;
	}

	@Column(name = "CDEF_STORAGE_LOCATION", length = 4)
	public String getCdefStorageLocation() {
		return this.cdefStorageLocation;
	}

	public void setCdefStorageLocation(final String cdefStorageLocation) {
		this.cdefStorageLocation = cdefStorageLocation;
	}

	@Column(name = "CTOP_LEVEL", length = 1)
	public String getCtopLevel() {
		return this.ctopLevel;
	}

	public void setCtopLevel(final String ctopLevel) {
		this.ctopLevel = ctopLevel;
	}

	@Column(name = "CREV_LEVEL", length = 2)
	public String getCrevLevel() {
		return this.crevLevel;
	}

	public void setCrevLevel(final String crevLevel) {
		this.crevLevel = crevLevel;
	}

	@Column(name = "CPROCESSING_STATUS", length = 1)
	public String getCprocessingStatus() {
		return this.cprocessingStatus;
	}

	public void setCprocessingStatus(final String cprocessingStatus) {
		this.cprocessingStatus = cprocessingStatus;
	}

	@Column(name = "CSORTL", length = 10)
	public String getCsortl() {
		return this.csortl;
	}

	public void setCsortl(final String csortl) {
		this.csortl = csortl;
	}

	@Column(name = "CFERTART", length = 1)
	public String getCfertart() {
		return this.cfertart;
	}

	public void setCfertart(final String cfertart) {
		this.cfertart = cfertart;
	}

	@Column(name = "CMAT_TEXT", length = 40)
	public String getCmatText() {
		return this.cmatText;
	}

	public void setCmatText(final String cmatText) {
		this.cmatText = cmatText;
	}

	@Column(name = "CUSERNAME", length = 40)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(final String cusername) {
		this.cusername = cusername;
	}

	@Column(name = "CCHANGE_NO", length = 12)
	public String getCchangeNo() {
		return this.cchangeNo;
	}

	public void setCchangeNo(final String cchangeNo) {
		this.cchangeNo = cchangeNo;
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

	@Column(name = "NPHF_FLAG", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNphfFlag() {
		return this.nphfFlag;
	}

	public void setNphfFlag(final int nphfFlag) {
		this.nphfFlag = nphfFlag;
	}

	@Column(name = "CSKATEGORIE", length = 6)
	public String getCskategorie() {
		return this.cskategorie;
	}

	public void setCskategorie(final String cskategorie) {
		this.cskategorie = cskategorie;
	}

	@Column(name = "NISCOMPLETE_COSTING", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNiscompleteCosting() {
		return this.niscompleteCosting;
	}

	public void setNiscompleteCosting(final int niscompleteCosting) {
		this.niscompleteCosting = niscompleteCosting;
	}

	@Column(name = "CUSERNAME_COSTING", length = 40)
	public String getCusernameCosting() {
		return this.cusernameCosting;
	}

	public void setCusernameCosting(final String cusernameCosting) {
		this.cusernameCosting = cusernameCosting;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_COSTING", length = 7)
	public Date getDtimestampCosting() {
		return this.dtimestampCosting;
	}

	public void setDtimestampCosting(final Date dtimestampCosting) {
		this.dtimestampCosting = dtimestampCosting;
	}

	@Column(name = "NISCOMPLETE_PRICING", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNiscompletePricing() {
		return this.niscompletePricing;
	}

	public void setNiscompletePricing(final int niscompletePricing) {
		this.niscompletePricing = niscompletePricing;
	}

	@Column(name = "CUSERNAME_PRICING", length = 40)
	public String getCusernamePricing() {
		return this.cusernamePricing;
	}

	public void setCusernamePricing(final String cusernamePricing) {
		this.cusernamePricing = cusernamePricing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP_PRICING", length = 7)
	public Date getDtimestampPricing() {
		return this.dtimestampPricing;
	}

	public void setDtimestampPricing(final Date dtimestampPricing) {
		this.dtimestampPricing = dtimestampPricing;
	}

	@Column(name = "CWORKCENTER", length = 8)
	public String getCworkcenter() {
		return this.cworkcenter;
	}

	public void setCworkcenter(final String cworkcenter) {
		this.cworkcenter = cworkcenter;
	}

	@Column(name = "NCCPLOG3", nullable = false, precision = 12, scale = 0, columnDefinition = "NUMBER(12) DEFAULT -1")
	public long getNccplog3() {
		return this.nccplog3;
	}

	public void setNccplog3(final long nccplog3) {
		this.nccplog3 = nccplog3;
	}

	@Column(name = "NCCPLOG4", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNccplog4() {
		return this.nccplog4;
	}

	public void setNccplog4(final int nccplog4) {
		this.nccplog4 = nccplog4;
	}

	@Column(name = "NALG_RELV", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public int getNalgRelv() {
		return this.nalgRelv;
	}

	public void setNalgRelv(final int nalgRelv) {
		this.nalgRelv = nalgRelv;
	}

	@Column(name = "NALG_APPR", nullable = false, precision = 2, scale = 0, columnDefinition = "NUMBER(2) DEFAULT 0")
	public int getNalgAppr() {
		return this.nalgAppr;
	}

	public void setNalgAppr(final int nalgAppr) {
		this.nalgAppr = nalgAppr;
	}

	@Column(name = "CUNITAREA_UK", length = 5)
	public String getCunitareaUk() {
		return this.cunitareaUk;
	}

	public void setCunitareaUk(final String cunitareaUk) {
		this.cunitareaUk = cunitareaUk;
	}

	public Long getNjasperKey() {
		return njasperKey;
	}

	public void setNjasperKey(final Long njasperKey) {
		this.njasperKey = njasperKey;
	}

	@Column(name = "NLVORM_SAP", precision = 1, scale = 0)
	public Integer getNlvormSap() {
		return this.nlvormSap;
	}

	public void setNlvormSap(final Integer nlvormSap) {
		this.nlvormSap = nlvormSap;
	}

	@Column(name = "CPROD_CAT", length = 1)
	public String getCprodCat() {
		return this.cprodCat;
	}

	public void setCprodCat(final String cprodCat) {
		this.cprodCat = cprodCat;
	}

	@Column(name = "NPROD_RATING", nullable = false, precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT -1")
	public int getNprodRating() {
		return this.nprodRating;
	}

	public void setNprodRating(final int nprodRating) {
		this.nprodRating = nprodRating;
	}

	@Column(name = "NADD_DELIVERY_FLAG", precision = 1, scale = 0)
	public Integer getNaddDeliveryFlag() {
		return this.naddDeliveryFlag;
	}

	public void setNaddDeliveryFlag(final Integer naddDeliveryFlag) {
		this.naddDeliveryFlag = naddDeliveryFlag;
	}

	@Column(name = "NQTY_LOCKED_FLAG", precision = 1, scale = 0)
	public Integer getNqtyLockedFlag() {
		return this.nqtyLockedFlag;
	}

	public void setNqtyLockedFlag(final Integer nqtyLockedFlag) {
		this.nqtyLockedFlag = nqtyLockedFlag;
	}

	@Column(name = "NPRICE_LOCKED_FLAG", precision = 1, scale = 0)
	public Integer getNpriceLockedFlag() {
		return this.npriceLockedFlag;
	}

	public void setNpriceLockedFlag(final Integer npriceLockedFlag) {
		this.npriceLockedFlag = npriceLockedFlag;
	}

	@Column(name = "CTEXT1", length = 50)
	public String getCtext1() {
		return this.ctext1;
	}

	public void setCtext1(final String ctext1) {
		this.ctext1 = ctext1;
	}

	@Column(name = "CTEXT2", length = 50)
	public String getCtext2() {
		return this.ctext2;
	}

	public void setCtext2(final String ctext2) {
		this.ctext2 = ctext2;
	}

	@Column(name = "CTEXT3", length = 50)
	public String getCtext3() {
		return this.ctext3;
	}

	public void setCtext3(final String ctext3) {
		this.ctext3 = ctext3;
	}

	@Column(name = "NVALUECHAINCAT_KEY", precision = 12, scale = 0)
	public Long getNvaluechaincatKey() {
		return this.nvaluechaincatKey;
	}

	public void setNvaluechaincatKey(final Long nvaluechaincatKey) {
		this.nvaluechaincatKey = nvaluechaincatKey;
	}

	@Column(name = "CTEXT_SHORT2", length = 40)
	public String getCtextShort2() {
		return this.ctextShort2;
	}

	public void setCtextShort2(final String ctextShort2) {
		this.ctextShort2 = ctextShort2;
	}

	@Column(name = "NMMD_FLAG", precision = 1, scale = 0, columnDefinition = "NUMBER(1) DEFAULT 0")
	public Integer getNmmdFlag() {
		return this.nmmdFlag;
	}

	public void setNmmdFlag(final Integer nmmdFlag) {
		this.nmmdFlag = nmmdFlag;
	}

	@Column(name = "NCUISINE_CAT_KEY", precision = 12, scale = 0)
	public Long getNcuisineCatKey() {
		return this.ncuisineCatKey;
	}

	public void setNcuisineCatKey(final Long ncuisineCatKey) {
		this.ncuisineCatKey = ncuisineCatKey;
	}

	@Column(name = "CSEQUENCE", length = 6)
	public String getCsequence() {
		return csequence;
	}

	public void setCsequence(String csequence) {
		this.csequence = csequence;
	}

	@Column(name = "NMAT_GRP_VAL_KEY_1", precision = 12, scale = 0)
	public Long getNmatGrpValKey1() {
		return nmatGrpValKey1;
	}

	public void setNmatGrpValKey1(Long nmatGrpValKey1) {
		this.nmatGrpValKey1 = nmatGrpValKey1;
	}

	@Column(name = "NMAT_GRP_VAL_KEY_2", precision = 12, scale = 0)
	public Long getNmatGrpValKey2() {
		return nmatGrpValKey2;
	}

	public void setNmatGrpValKey2(Long nmatGrpValKey2) {
		this.nmatGrpValKey2 = nmatGrpValKey2;
	}

	@Column(name = "CCOUNTRY_OF_ORIGIN_ANIMAL_PROTEIN", length = 100)
	public String getCcountryOfOriginAnimalProtein() {
		return ccountryOfOriginAnimalProtein;
	}

	public void setCcountryOfOriginAnimalProtein(String ccountryOfOriginAnimalProtein) {
		this.ccountryOfOriginAnimalProtein = ccountryOfOriginAnimalProtein;
	}

	@Column(name = "NALCOHOL_PERCENTAGE", precision = 5, scale = 2)
	public BigDecimal getNalcoholPercentage() {
		return nalcoholPercentage;
	}

	public void setNalcoholPercentage(BigDecimal nalcoholPercentage) {
		this.nalcoholPercentage = nalcoholPercentage;
	}

	@Column(name = "NSERVICE_CLASS", precision = 1, scale = 0)
	public Integer getNserviceClass() {
		return nserviceClass;
	}

	public void setNserviceClass(Integer nserviceClass) {
		this.nserviceClass = nserviceClass;
	}

	@Column(name = "NCONSUMABLE", precision = 1, scale = 0)
	public Integer getNconsumable() {
		return nconsumable;
	}

	public void setNconsumable(Integer nconsumable) {
		this.nconsumable = nconsumable;
	}

	@Column(name = "NROTABLE_CONSUMABLE_FACTOR", precision = 5, scale = 2)
	public BigDecimal getNrotableConsumableFactor() {
		return nrotableConsumableFactor;
	}

	public void setNrotableConsumableFactor(BigDecimal nrotableConsumableFactor) {
		this.nrotableConsumableFactor = nrotableConsumableFactor;
	}

	@Column(name = "NROTABLE_CONSUMABLE_FACTOR_MANUAL", precision = 5, scale = 2)
	public BigDecimal getNrotableConsumableFactorManual() {
		return nrotableConsumableFactorManual;
	}

	public void setNrotableConsumableFactorManual(BigDecimal nrotableConsumableFactorManual) {
		this.nrotableConsumableFactorManual = nrotableConsumableFactorManual;
	}

	@Column(name = "CPURCHASING_SOURCE")
	public String getCpurchasingSource() {
		return cpurchasingSource;
	}

	public void setCpurchasingSource(String cpurchasingSource) {
		this.cpurchasingSource = cpurchasingSource;
	}

	// TODO iri: will loaded (is optional), lazy loading can only realized with byte code enhancement
	// https://stackoverflow.com/questions/71787020/why-spring-jpa-still-retrieves-associated-entities-with-fetchmode-lazy
	// https://docs.jboss.org/hibernate/orm/5.6/userguide/html_single/Hibernate_User_Guide.html#BytecodeEnhancement
	// Solution 1: Use Many-To-One relation instead 	--> Was tried out experimentally but all bidirectional optional ...toOne relations where still eagerly loaded
	// Solution 2: Bytecode Enhancement 				--> TODO: Currently used and will be observed
	// Solution 3: Make relation mandatory
	// ORIGINAL mapping -> @OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	// 11:34:17.127 [main] WARN  org.hibernate.cfg.AnnotationBinder - HHH000491: The [cenPackinglistInstructions] association in the [com.lsgskychefs.cbase.middleware.persistence.domain.CenPackinglists]
	// entity uses both @NotFound(action = NotFoundAction.IGNORE) and FetchType.LAZY. The NotFoundAction.IGNORE @ManyToOne and @OneToOne associations are always fetched eagerly.
	// if you use distinct somewhere it will fail when you fetch instructions because binarys cannot be distinct ....
	// like in com.lsgskychefs.cbase.middleware.workorder.persistence.PreproductionAllocationRepository#findUnallocatedMs1PreprodItemlists
	/* was tried for solution 1 ->
	@ManyToOne(fetch = FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false, insertable = false, updatable = false) })*/

	/**
	 * soo much drama ... everytime you touch that class intellij will compile and overwrite the byte code enhancement
	 * https://youtrack.jetbrains.com/issue/IDEA-159903/Hibernate-bytecode-instrumentation-code-is-being-overridden-by-IDEA
	 * So in case you "still" have subsequent sql statements for instruction you may need to run
	 * mvn clean install -DskipTests -> reload all mvn projects -> generate sources and update folders
	 */
	@LazyToOne(LazyToOneOption.NO_PROXY)
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenPackinglistInstructions getCenPackinglistInstructions() {
		return this.cenPackinglistInstructions;
	}

	public void setCenPackinglistInstructions(final CenPackinglistInstructions cenPackinglistInstructions) {
		this.cenPackinglistInstructions = cenPackinglistInstructions;
	}

	@Formula("("
			+ "SELECT count(*) "
			+ "FROM cen_packinglist_instructions inst "
			+ "WHERE inst.npackinglist_index_key = npackinglist_index_key and inst.npackinglist_detail_key = npackinglist_detail_key "
			+ "AND length(inst.brichtext) > 165" // the magic number of empty rtfs 
			+ ")")
	@Basic(fetch = FetchType.EAGER)
	public boolean isInstructionFound() {
		return this.instructionFound;
	}

	public void setInstructionFound(boolean instructionFound) {
		this.instructionFound = instructionFound;
	}

	@Formula("("
			+ "SELECT (case when count(*) > 1 then 1 else 0 end) "
			+ "FROM cen_packinglists detail "
			+ "WHERE detail.npackinglist_index_key = npackinglist_index_key"
			+ ")")
	@Basic(fetch = FetchType.EAGER)
	public boolean isMultipleValiditiesFound() {
		return this.multipleValiditiesFound;
	}

	public void setMultipleValiditiesFound(boolean multipleValiditiesFound) {
		this.multipleValiditiesFound = multipleValiditiesFound;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenPackinglistPictures getCenPackinglistPictures() {
		return this.cenPackinglistPictures;
	}

	public void setCenPackinglistPictures(final CenPackinglistPictures cenPackinglistPictures) {
		this.cenPackinglistPictures = cenPackinglistPictures;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPackinglistDetail> getCenPackinglistDetails() {
		return this.cenPackinglistDetails;
	}

	public void setCenPackinglistDetails(final Set<CenPackinglistDetail> cenPackinglistDetails) {
		this.cenPackinglistDetails = cenPackinglistDetails;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_KEY", nullable = false, insertable = false, updatable = false)
	public CenPackinglistTypes getCenPackinglistTypes() {
		return this.cenPackinglistTypes;
	}

	public void setCenPackinglistTypes(final CenPackinglistTypes cenPackinglistTypes) {
		this.cenPackinglistTypes = cenPackinglistTypes;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLABEL_TYPE_KEY", nullable = false)
	public CenLabelType getCenLabelType() {
		return this.cenLabelType;
	}

	public void setCenLabelType(final CenLabelType cenLabelType) {
		this.cenLabelType = cenLabelType;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPackinglistEuAlg> getCenPackinglistEuAlgs() {
		return this.cenPackinglistEuAlgs;
	}

	public void setCenPackinglistEuAlgs(final Set<CenPackinglistEuAlg> cenPackinglistEuAlgs) {
		this.cenPackinglistEuAlgs = cenPackinglistEuAlgs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPackinglistProject> getCenPackinglistProjects() {
		return this.cenPackinglistProjects;
	}

	public void setCenPackinglistProjects(final Set<CenPackinglistProject> cenPackinglistProjects) {
		this.cenPackinglistProjects = cenPackinglistProjects;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPackinglistCscVal> getCenPackinglistCscVals() {
		return this.cenPackinglistCscVals;
	}

	public void setCenPackinglistCscVals(final Set<CenPackinglistCscVal> cenPackinglistCscVals) {
		this.cenPackinglistCscVals = cenPackinglistCscVals;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPriceDefSnapshotPl> getCenPriceDefSnapshotPls() {
		return this.cenPriceDefSnapshotPls;
	}

	public void setCenPriceDefSnapshotPls(final Set<CenPriceDefSnapshotPl> cenPriceDefSnapshotPls) {
		this.cenPriceDefSnapshotPls = cenPriceDefSnapshotPls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPriceSnapshotPl> getCenPriceSnapshotPls() {
		return this.cenPriceSnapshotPls;
	}

	public void setCenPriceSnapshotPls(final Set<CenPriceSnapshotPl> cenPriceSnapshotPls) {
		this.cenPriceSnapshotPls = cenPriceSnapshotPls;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenCostSnapPlSum> getCenCostSnapPlSums() {
		return this.cenCostSnapPlSums;
	}

	public void setCenCostSnapPlSums(final Set<CenCostSnapPlSum> cenCostSnapPlSums) {
		this.cenCostSnapPlSums = cenCostSnapPlSums;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPlRatingType> getCenPlRatingTypes() {
		return this.cenPlRatingTypes;
	}

	public void setCenPlRatingTypes(final Set<CenPlRatingType> cenPlRatingTypes) {
		this.cenPlRatingTypes = cenPlRatingTypes;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenPlRatingTotal getCenPlRatingTotal() {
		return this.cenPlRatingTotal;
	}

	public void setCenPlRatingTotal(CenPlRatingTotal cenPlRatingTotal) {
		this.cenPlRatingTotal = cenPlRatingTotal;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenPackinglistIf getCenPackinglistIf() {
		return this.cenPackinglistIf;
	}

	public void setCenPackinglistIf(CenPackinglistIf cenPackinglistIf) {
		this.cenPackinglistIf = cenPackinglistIf;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenPackinglistMaterial getCenPackinglistMaterial() {
		return this.cenPackinglistMaterial;
	}

	public void setCenPackinglistMaterial(CenPackinglistMaterial cenPackinglistMaterial) {
		this.cenPackinglistMaterial = cenPackinglistMaterial;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPlMpProject> getCenPlMpProjects() {
		return this.cenPlMpProjects;
	}

	public void setCenPlMpProjects(Set<CenPlMpProject> cenPlMpProjects) {
		this.cenPlMpProjects = cenPlMpProjects;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public CenMpDesignItemlist getCenMpDesignItemlist() {
		return cenMpDesignItemlist;
	}

	public void setCenMpDesignItemlist(CenMpDesignItemlist cenMpDesignItemlist) {
		this.cenMpDesignItemlist = cenMpDesignItemlist;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglists")
	public Set<CenPackinglistSize> getCenPackinglistSizes() {
		return cenPackinglistSizes;
	}

	public void setCenPackinglistSizes(Set<CenPackinglistSize> cenPackinglistSizes) {
		this.cenPackinglistSizes = cenPackinglistSizes;
	}
}
