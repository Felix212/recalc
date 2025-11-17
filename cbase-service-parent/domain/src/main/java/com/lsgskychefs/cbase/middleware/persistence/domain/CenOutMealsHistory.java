package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.10.2022 09:36:43 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_MEALS_HISTORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MEALS_HISTORY"
)
public class CenOutMealsHistory implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMealsHistoryId id;
	private CenOutHistory cenOutHistory;
	private long nhandlingKey;
	private long nhandlingDetailKey;
	private String chandlingText;
	private long ncoverKey;
	private String ccoverText;
	private int ncoverPrio;
	private long nhandlingMealKey;
	private long nclassNumber;
	private String cclass;
	private int nreserveQuantity;
	private int nreserveType;
	private int ntopoffQuantity;
	private int ntopoffType;
	private int nspmlQuantity;
	private long nrotationKey;
	private long nrotationNameKey;
	private String crotation;
	private int nmoduleType;
	private int nprio;
	private long npackinglistIndexKey;
	private String cpackinglist;
	private String cunit;
	private String cmealControlCode;
	private String cproductionText;
	private int ncomponentGroup;
	private Long nforeignObject;
	private Integer nforeignGroup;
	private int nask4passenger;
	private String cquestionText;
	private int npassengerGroup;
	private Integer nquantityGroup;
	private String cremark;
	private Long naccountKey;
	private String caccount;
	private int nbillingStatus;
	private long ncalcId;
	private Long ncalcDetailKey;
	private int npercentage;
	private BigDecimal nvalue;
	private int nspmlDeduction;
	private int nacTransfer;
	private int npax;
	private int npaxManual;
	private int ncalcBasis;
	private BigDecimal nquantity1;
	private BigDecimal nquantity2;
	private BigDecimal nquantity3;
	private BigDecimal nquantity4;
	private BigDecimal nquantity5;
	private BigDecimal nquantity6;
	private BigDecimal nquantity7;
	private BigDecimal nquantity;
	private BigDecimal nquantityOld;
	private int nmanualInput;
	private int nmanualProcessing;
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private String careaHost;
	private String ceffortHost;
	private String cadditionalAccount;
	private Long npltypeKey;
	private Long nplKindKey;
	private Long npackinglistKey;
	private Long npackinglistDetailKey;
	private String ctext;
	private Integer ndistribute;
	private Integer npostingType;
	private BigDecimal nsalesPrice;
	private Integer ndeliveryNote;
	private String cdeliverySnr;
	private String cdeliveryText;
	private Integer ncontrolling;
	private Long nsysaccountKey;
	private String ccode;
	private BigDecimal nremittanceprice;
	private BigDecimal ndiscount;
	private BigDecimal nportfee;
	private BigDecimal nvatValue;
	private Long ninvoiceCycleKey;
	private BigDecimal ncostPrice;
	private Integer ninvoiceStatus;
	private String cclasses;
	private Integer nsalesPriceModified;
	private Long npriceCalcType;
	private Long ncosttype;
	private String ctaxcode;
	private BigDecimal nbillingPrice;
	private Integer nreleaseExclusion;
	private Integer nstationentry;
	private String ccustomerPl;
	private String ccustomerText;
	private BigDecimal nquantityRecalc;
	private BigDecimal nsalesPriceRecalc;
	private BigDecimal nbillingPriceRecalc;
	private BigDecimal ncostPriceRecalc;
	private BigDecimal nremittencepriceRecalc;
	private BigDecimal nvatValueRecalc;
	private BigDecimal ndiscountRecalc;
	private BigDecimal nportfeeRecalc;
	private Integer ncalcBasisRecalc;
	private Integer nimportFromBob;
	private BigDecimal nvatValuePortfee;
	private Long nvatKey;
	private Long nvatKeyPortfee;
	private Integer nreductionFlag;
	private Integer nremarkManual;
	private Integer nlocalSub;
	private Long nplIndexKeyOri;
	private String cpackinglistOri;
	private String ctextOri;
	private Long ncalcIdOri;
	private Long ncalcDetailKeyOri;
	private Integer npercentageOri;
	private BigDecimal nvalueOri;
	private BigDecimal nmaxValueOri;
	private BigDecimal nquantityVersion;
	private Integer nflagIsdefaultprice;
	private Integer nflagIsinvalidunit;
	private String cpackinglistXsl;
	private Integer nmaxValue;
	private Integer nminValue;
	private Integer nmanualComp;
	private Integer ninputFromTopOff;
	private BigDecimal ntbTopUp;
	private BigDecimal ntbTopDown;
	private BigDecimal ntbWRecy;
	private BigDecimal ntbWCold;
	private BigDecimal ntbWPack;
	private BigDecimal ntbWPeris;
	private BigDecimal ntbWSamp;
	private BigDecimal ntbWBrok;
	private BigDecimal ntbWLook;
	private BigDecimal ntbWOther;
	private BigDecimal ntbWUndef1;
	private BigDecimal ntbWUndef2;
	private BigDecimal ntbWUndef3;
	private BigDecimal ntbTemp;
	private String ctbRemark;
	private BigDecimal nquantityMis;
	private Integer nplanningPercent;
	private String cprefix;
	private Integer nreduce;
	private String coverunderload;
	private Integer nserviceSequence;
	private String csapCode;
	private Integer nqtyLockedFlag;
	private Integer npriceLockedFlag;
	private Long npreorderKey;
	private Integer naddDeliveryFlag;
	private String csalesBom;
	private Long ngalleyRegionKey;
	private Integer ndynamicMeals;
	private String cdmCcustomerPl;
	private Integer ndmUseParent;

	public CenOutMealsHistory() {
	}

	public CenOutMealsHistory(final CenOutMealsHistoryId id, final CenOutHistory cenOutHistory, final long nhandlingKey, final long nhandlingDetailKey,
			final String chandlingText, final long ncoverKey, final String ccoverText, final int ncoverPrio, final long nhandlingMealKey, final long nclassNumber,
			final String cclass, final int nreserveQuantity, final int nreserveType, final int ntopoffQuantity, final int ntopoffType, final int nspmlQuantity,
			final long nrotationKey, final long nrotationNameKey, final String crotation, final int nmoduleType, final int nprio, final long npackinglistIndexKey,
			final String cpackinglist, final String cmealControlCode, final String cproductionText, final int ncomponentGroup, final int nask4passenger,
			final int npassengerGroup, final int nbillingStatus, final long ncalcId, final int npercentage, final BigDecimal nvalue, final int nspmlDeduction, final int nacTransfer,
			final int npax, final int npaxManual, final int ncalcBasis, final BigDecimal nquantity, final BigDecimal nquantityOld, final int nmanualInput,
			final int nmanualProcessing, final Date dtimestamp, final int nstatus, final BigDecimal ntbTopDown, final BigDecimal ntbWRecy, final BigDecimal ntbWCold,
			final BigDecimal ntbWPack, final BigDecimal ntbWPeris, final BigDecimal ntbWSamp, final BigDecimal ntbWBrok, final BigDecimal ntbWLook, final BigDecimal ntbWOther,
			final BigDecimal ntbWUndef1, final BigDecimal ntbWUndef2, final BigDecimal ntbWUndef3) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.nhandlingKey = nhandlingKey;
		this.nhandlingDetailKey = nhandlingDetailKey;
		this.chandlingText = chandlingText;
		this.ncoverKey = ncoverKey;
		this.ccoverText = ccoverText;
		this.ncoverPrio = ncoverPrio;
		this.nhandlingMealKey = nhandlingMealKey;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nreserveQuantity = nreserveQuantity;
		this.nreserveType = nreserveType;
		this.ntopoffQuantity = ntopoffQuantity;
		this.ntopoffType = ntopoffType;
		this.nspmlQuantity = nspmlQuantity;
		this.nrotationKey = nrotationKey;
		this.nrotationNameKey = nrotationNameKey;
		this.crotation = crotation;
		this.nmoduleType = nmoduleType;
		this.nprio = nprio;
		this.npackinglistIndexKey = npackinglistIndexKey;
		this.cpackinglist = cpackinglist;
		this.cmealControlCode = cmealControlCode;
		this.cproductionText = cproductionText;
		this.ncomponentGroup = ncomponentGroup;
		this.nask4passenger = nask4passenger;
		this.npassengerGroup = npassengerGroup;
		this.nbillingStatus = nbillingStatus;
		this.ncalcId = ncalcId;
		this.npercentage = npercentage;
		this.nvalue = nvalue;
		this.nspmlDeduction = nspmlDeduction;
		this.nacTransfer = nacTransfer;
		this.npax = npax;
		this.npaxManual = npaxManual;
		this.ncalcBasis = ncalcBasis;
		this.nquantity = nquantity;
		this.nquantityOld = nquantityOld;
		this.nmanualInput = nmanualInput;
		this.nmanualProcessing = nmanualProcessing;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.ntbTopDown = ntbTopDown;
		this.ntbWRecy = ntbWRecy;
		this.ntbWCold = ntbWCold;
		this.ntbWPack = ntbWPack;
		this.ntbWPeris = ntbWPeris;
		this.ntbWSamp = ntbWSamp;
		this.ntbWBrok = ntbWBrok;
		this.ntbWLook = ntbWLook;
		this.ntbWOther = ntbWOther;
		this.ntbWUndef1 = ntbWUndef1;
		this.ntbWUndef2 = ntbWUndef2;
		this.ntbWUndef3 = ntbWUndef3;
	}

	public CenOutMealsHistory(final CenOutMealsHistoryId id, final CenOutHistory cenOutHistory, final long nhandlingKey, final long nhandlingDetailKey,
			final String chandlingText, final long ncoverKey, final String ccoverText, final int ncoverPrio, final long nhandlingMealKey, final long nclassNumber,
			final String cclass, final int nreserveQuantity, final int nreserveType, final int ntopoffQuantity, final int ntopoffType, final int nspmlQuantity,
			final long nrotationKey, final long nrotationNameKey, final String crotation, final int nmoduleType, final int nprio, final long npackinglistIndexKey,
			final String cpackinglist, final String cunit, final String cmealControlCode, final String cproductionText, final int ncomponentGroup, final Long nforeignObject,
			final Integer nforeignGroup, final int nask4passenger, final String cquestionText, final int npassengerGroup, final Integer nquantityGroup, final String cremark,
			final Long naccountKey, final String caccount, final int nbillingStatus, final long ncalcId, final Long ncalcDetailKey, final int npercentage, final BigDecimal nvalue,
			final int nspmlDeduction, final int nacTransfer, final int npax, final int npaxManual, final int ncalcBasis, final BigDecimal nquantity1, final BigDecimal nquantity2,
			final BigDecimal nquantity3, final BigDecimal nquantity4, final BigDecimal nquantity5, final BigDecimal nquantity6, final BigDecimal nquantity7,
			final BigDecimal nquantity, final BigDecimal nquantityOld, final int nmanualInput, final int nmanualProcessing, final Date dtimestamp, final int nstatus,
			final String cdescription, final String careaHost, final String ceffortHost, final String cadditionalAccount, final Long npltypeKey, final Long nplKindKey,
			final Long npackinglistKey, final Long npackinglistDetailKey, final String ctext, final Integer ndistribute, final Integer npostingType,
			final BigDecimal nsalesPrice, final Integer ndeliveryNote, final String cdeliverySnr, final String cdeliveryText, final Integer ncontrolling,
			final Long nsysaccountKey, final String ccode, final BigDecimal nremittanceprice, final BigDecimal ndiscount, final BigDecimal nportfee, final BigDecimal nvatValue,
			final Long ninvoiceCycleKey, final BigDecimal ncostPrice, final Integer ninvoiceStatus, final String cclasses, final Integer nsalesPriceModified,
			final Long npriceCalcType, final Long ncosttype, final String ctaxcode, final BigDecimal nbillingPrice, final Integer nreleaseExclusion,
			final Integer nstationentry, final String ccustomerPl, final String ccustomerText, final BigDecimal nquantityRecalc, final BigDecimal nsalesPriceRecalc,
			final BigDecimal nbillingPriceRecalc, final BigDecimal ncostPriceRecalc, final BigDecimal nremittencepriceRecalc, final BigDecimal nvatValueRecalc,
			final BigDecimal ndiscountRecalc, final BigDecimal nportfeeRecalc, final Integer ncalcBasisRecalc, final Integer nimportFromBob,
			final BigDecimal nvatValuePortfee, final Long nvatKey, final Long nvatKeyPortfee, final Integer nreductionFlag, final Integer nremarkManual,
			final Integer nlocalSub, final Long nplIndexKeyOri, final String cpackinglistOri, final String ctextOri, final Long ncalcIdOri, final Long ncalcDetailKeyOri,
			final Integer npercentageOri, final BigDecimal nvalueOri, final BigDecimal nmaxValueOri, final BigDecimal nquantityVersion, final Integer nflagIsdefaultprice,
			final Integer nflagIsinvalidunit, final String cpackinglistXsl, final Integer nmaxValue, final Integer nminValue, final Integer nmanualComp,
			final Integer ninputFromTopOff, final BigDecimal ntbTopUp, final BigDecimal ntbTopDown, final BigDecimal ntbWRecy, final BigDecimal ntbWCold,
			final BigDecimal ntbWPack, final BigDecimal ntbWPeris, final BigDecimal ntbWSamp, final BigDecimal ntbWBrok, final BigDecimal ntbWLook, final BigDecimal ntbWOther,
			final BigDecimal ntbWUndef1, final BigDecimal ntbWUndef2, final BigDecimal ntbWUndef3, final BigDecimal ntbTemp, final String ctbRemark,
			final BigDecimal nquantityMis, final Integer nplanningPercent, final String cprefix, final Integer nreduce, final String coverunderload,
			final Integer nserviceSequence, final String csapCode, final Integer nqtyLockedFlag, final Integer npriceLockedFlag, final Long npreorderKey,
			final Integer naddDeliveryFlag, final String csalesBom, final Long ngalleyRegionKey, final Integer ndynamicMeals, final String cdmCcustomerPl,
			final Integer ndmUseParent) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.nhandlingKey = nhandlingKey;
		this.nhandlingDetailKey = nhandlingDetailKey;
		this.chandlingText = chandlingText;
		this.ncoverKey = ncoverKey;
		this.ccoverText = ccoverText;
		this.ncoverPrio = ncoverPrio;
		this.nhandlingMealKey = nhandlingMealKey;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nreserveQuantity = nreserveQuantity;
		this.nreserveType = nreserveType;
		this.ntopoffQuantity = ntopoffQuantity;
		this.ntopoffType = ntopoffType;
		this.nspmlQuantity = nspmlQuantity;
		this.nrotationKey = nrotationKey;
		this.nrotationNameKey = nrotationNameKey;
		this.crotation = crotation;
		this.nmoduleType = nmoduleType;
		this.nprio = nprio;
		this.npackinglistIndexKey = npackinglistIndexKey;
		this.cpackinglist = cpackinglist;
		this.cunit = cunit;
		this.cmealControlCode = cmealControlCode;
		this.cproductionText = cproductionText;
		this.ncomponentGroup = ncomponentGroup;
		this.nforeignObject = nforeignObject;
		this.nforeignGroup = nforeignGroup;
		this.nask4passenger = nask4passenger;
		this.cquestionText = cquestionText;
		this.npassengerGroup = npassengerGroup;
		this.nquantityGroup = nquantityGroup;
		this.cremark = cremark;
		this.naccountKey = naccountKey;
		this.caccount = caccount;
		this.nbillingStatus = nbillingStatus;
		this.ncalcId = ncalcId;
		this.ncalcDetailKey = ncalcDetailKey;
		this.npercentage = npercentage;
		this.nvalue = nvalue;
		this.nspmlDeduction = nspmlDeduction;
		this.nacTransfer = nacTransfer;
		this.npax = npax;
		this.npaxManual = npaxManual;
		this.ncalcBasis = ncalcBasis;
		this.nquantity1 = nquantity1;
		this.nquantity2 = nquantity2;
		this.nquantity3 = nquantity3;
		this.nquantity4 = nquantity4;
		this.nquantity5 = nquantity5;
		this.nquantity6 = nquantity6;
		this.nquantity7 = nquantity7;
		this.nquantity = nquantity;
		this.nquantityOld = nquantityOld;
		this.nmanualInput = nmanualInput;
		this.nmanualProcessing = nmanualProcessing;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.cdescription = cdescription;
		this.careaHost = careaHost;
		this.ceffortHost = ceffortHost;
		this.cadditionalAccount = cadditionalAccount;
		this.npltypeKey = npltypeKey;
		this.nplKindKey = nplKindKey;
		this.npackinglistKey = npackinglistKey;
		this.npackinglistDetailKey = npackinglistDetailKey;
		this.ctext = ctext;
		this.ndistribute = ndistribute;
		this.npostingType = npostingType;
		this.nsalesPrice = nsalesPrice;
		this.ndeliveryNote = ndeliveryNote;
		this.cdeliverySnr = cdeliverySnr;
		this.cdeliveryText = cdeliveryText;
		this.ncontrolling = ncontrolling;
		this.nsysaccountKey = nsysaccountKey;
		this.ccode = ccode;
		this.nremittanceprice = nremittanceprice;
		this.ndiscount = ndiscount;
		this.nportfee = nportfee;
		this.nvatValue = nvatValue;
		this.ninvoiceCycleKey = ninvoiceCycleKey;
		this.ncostPrice = ncostPrice;
		this.ninvoiceStatus = ninvoiceStatus;
		this.cclasses = cclasses;
		this.nsalesPriceModified = nsalesPriceModified;
		this.npriceCalcType = npriceCalcType;
		this.ncosttype = ncosttype;
		this.ctaxcode = ctaxcode;
		this.nbillingPrice = nbillingPrice;
		this.nreleaseExclusion = nreleaseExclusion;
		this.nstationentry = nstationentry;
		this.ccustomerPl = ccustomerPl;
		this.ccustomerText = ccustomerText;
		this.nquantityRecalc = nquantityRecalc;
		this.nsalesPriceRecalc = nsalesPriceRecalc;
		this.nbillingPriceRecalc = nbillingPriceRecalc;
		this.ncostPriceRecalc = ncostPriceRecalc;
		this.nremittencepriceRecalc = nremittencepriceRecalc;
		this.nvatValueRecalc = nvatValueRecalc;
		this.ndiscountRecalc = ndiscountRecalc;
		this.nportfeeRecalc = nportfeeRecalc;
		this.ncalcBasisRecalc = ncalcBasisRecalc;
		this.nimportFromBob = nimportFromBob;
		this.nvatValuePortfee = nvatValuePortfee;
		this.nvatKey = nvatKey;
		this.nvatKeyPortfee = nvatKeyPortfee;
		this.nreductionFlag = nreductionFlag;
		this.nremarkManual = nremarkManual;
		this.nlocalSub = nlocalSub;
		this.nplIndexKeyOri = nplIndexKeyOri;
		this.cpackinglistOri = cpackinglistOri;
		this.ctextOri = ctextOri;
		this.ncalcIdOri = ncalcIdOri;
		this.ncalcDetailKeyOri = ncalcDetailKeyOri;
		this.npercentageOri = npercentageOri;
		this.nvalueOri = nvalueOri;
		this.nmaxValueOri = nmaxValueOri;
		this.nquantityVersion = nquantityVersion;
		this.nflagIsdefaultprice = nflagIsdefaultprice;
		this.nflagIsinvalidunit = nflagIsinvalidunit;
		this.cpackinglistXsl = cpackinglistXsl;
		this.nmaxValue = nmaxValue;
		this.nminValue = nminValue;
		this.nmanualComp = nmanualComp;
		this.ninputFromTopOff = ninputFromTopOff;
		this.ntbTopUp = ntbTopUp;
		this.ntbTopDown = ntbTopDown;
		this.ntbWRecy = ntbWRecy;
		this.ntbWCold = ntbWCold;
		this.ntbWPack = ntbWPack;
		this.ntbWPeris = ntbWPeris;
		this.ntbWSamp = ntbWSamp;
		this.ntbWBrok = ntbWBrok;
		this.ntbWLook = ntbWLook;
		this.ntbWOther = ntbWOther;
		this.ntbWUndef1 = ntbWUndef1;
		this.ntbWUndef2 = ntbWUndef2;
		this.ntbWUndef3 = ntbWUndef3;
		this.ntbTemp = ntbTemp;
		this.ctbRemark = ctbRemark;
		this.nquantityMis = nquantityMis;
		this.nplanningPercent = nplanningPercent;
		this.cprefix = cprefix;
		this.nreduce = nreduce;
		this.coverunderload = coverunderload;
		this.nserviceSequence = nserviceSequence;
		this.csapCode = csapCode;
		this.nqtyLockedFlag = nqtyLockedFlag;
		this.npriceLockedFlag = npriceLockedFlag;
		this.npreorderKey = npreorderKey;
		this.naddDeliveryFlag = naddDeliveryFlag;
		this.csalesBom = csalesBom;
		this.ngalleyRegionKey = ngalleyRegionKey;
		this.ndynamicMeals = ndynamicMeals;
		this.cdmCcustomerPl = cdmCcustomerPl;
		this.ndmUseParent = ndmUseParent;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "ndetailKey", column = @Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)) })
	public CenOutMealsHistoryId getId() {
		return this.id;
	}

	public void setId(final CenOutMealsHistoryId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false, insertable = false, updatable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false, insertable = false, updatable = false) })
	public CenOutHistory getCenOutHistory() {
		return this.cenOutHistory;
	}

	public void setCenOutHistory(final CenOutHistory cenOutHistory) {
		this.cenOutHistory = cenOutHistory;
	}

	@Column(name = "NHANDLING_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(final long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "NHANDLING_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingDetailKey() {
		return this.nhandlingDetailKey;
	}

	public void setNhandlingDetailKey(final long nhandlingDetailKey) {
		this.nhandlingDetailKey = nhandlingDetailKey;
	}

	@Column(name = "CHANDLING_TEXT", nullable = false, length = 30)
	public String getChandlingText() {
		return this.chandlingText;
	}

	public void setChandlingText(final String chandlingText) {
		this.chandlingText = chandlingText;
	}

	@Column(name = "NCOVER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcoverKey() {
		return this.ncoverKey;
	}

	public void setNcoverKey(final long ncoverKey) {
		this.ncoverKey = ncoverKey;
	}

	@Column(name = "CCOVER_TEXT", nullable = false, length = 30)
	public String getCcoverText() {
		return this.ccoverText;
	}

	public void setCcoverText(final String ccoverText) {
		this.ccoverText = ccoverText;
	}

	@Column(name = "NCOVER_PRIO", nullable = false, precision = 6, scale = 0)
	public int getNcoverPrio() {
		return this.ncoverPrio;
	}

	public void setNcoverPrio(final int ncoverPrio) {
		this.ncoverPrio = ncoverPrio;
	}

	@Column(name = "NHANDLING_MEAL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingMealKey() {
		return this.nhandlingMealKey;
	}

	public void setNhandlingMealKey(final long nhandlingMealKey) {
		this.nhandlingMealKey = nhandlingMealKey;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(final long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "CCLASS", nullable = false, length = 10)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NRESERVE_QUANTITY", nullable = false, precision = 3, scale = 0)
	public int getNreserveQuantity() {
		return this.nreserveQuantity;
	}

	public void setNreserveQuantity(final int nreserveQuantity) {
		this.nreserveQuantity = nreserveQuantity;
	}

	@Column(name = "NRESERVE_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNreserveType() {
		return this.nreserveType;
	}

	public void setNreserveType(final int nreserveType) {
		this.nreserveType = nreserveType;
	}

	@Column(name = "NTOPOFF_QUANTITY", nullable = false, precision = 3, scale = 0)
	public int getNtopoffQuantity() {
		return this.ntopoffQuantity;
	}

	public void setNtopoffQuantity(final int ntopoffQuantity) {
		this.ntopoffQuantity = ntopoffQuantity;
	}

	@Column(name = "NTOPOFF_TYPE", nullable = false, precision = 1, scale = 0)
	public int getNtopoffType() {
		return this.ntopoffType;
	}

	public void setNtopoffType(final int ntopoffType) {
		this.ntopoffType = ntopoffType;
	}

	@Column(name = "NSPML_QUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNspmlQuantity() {
		return this.nspmlQuantity;
	}

	public void setNspmlQuantity(final int nspmlQuantity) {
		this.nspmlQuantity = nspmlQuantity;
	}

	@Column(name = "NROTATION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNrotationKey() {
		return this.nrotationKey;
	}

	public void setNrotationKey(final long nrotationKey) {
		this.nrotationKey = nrotationKey;
	}

	@Column(name = "NROTATION_NAME_KEY", nullable = false, precision = 12, scale = 0)
	public long getNrotationNameKey() {
		return this.nrotationNameKey;
	}

	public void setNrotationNameKey(final long nrotationNameKey) {
		this.nrotationNameKey = nrotationNameKey;
	}

	@Column(name = "CROTATION", nullable = false, length = 10)
	public String getCrotation() {
		return this.crotation;
	}

	public void setCrotation(final String crotation) {
		this.crotation = crotation;
	}

	@Column(name = "NMODULE_TYPE", nullable = false, precision = 2, scale = 0)
	public int getNmoduleType() {
		return this.nmoduleType;
	}

	public void setNmoduleType(final int nmoduleType) {
		this.nmoduleType = nmoduleType;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(final long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 36)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(final String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 84)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
	}

	@Column(name = "NCOMPONENT_GROUP", nullable = false, precision = 3, scale = 0)
	public int getNcomponentGroup() {
		return this.ncomponentGroup;
	}

	public void setNcomponentGroup(final int ncomponentGroup) {
		this.ncomponentGroup = ncomponentGroup;
	}

	@Column(name = "NFOREIGN_OBJECT", precision = 12, scale = 0)
	public Long getNforeignObject() {
		return this.nforeignObject;
	}

	public void setNforeignObject(final Long nforeignObject) {
		this.nforeignObject = nforeignObject;
	}

	@Column(name = "NFOREIGN_GROUP", precision = 3, scale = 0)
	public Integer getNforeignGroup() {
		return this.nforeignGroup;
	}

	public void setNforeignGroup(final Integer nforeignGroup) {
		this.nforeignGroup = nforeignGroup;
	}

	@Column(name = "NASK4PASSENGER", nullable = false, precision = 1, scale = 0)
	public int getNask4passenger() {
		return this.nask4passenger;
	}

	public void setNask4passenger(final int nask4passenger) {
		this.nask4passenger = nask4passenger;
	}

	@Column(name = "CQUESTION_TEXT", length = 40)
	public String getCquestionText() {
		return this.cquestionText;
	}

	public void setCquestionText(final String cquestionText) {
		this.cquestionText = cquestionText;
	}

	@Column(name = "NPASSENGER_GROUP", nullable = false, precision = 1, scale = 0)
	public int getNpassengerGroup() {
		return this.npassengerGroup;
	}

	public void setNpassengerGroup(final int npassengerGroup) {
		this.npassengerGroup = npassengerGroup;
	}

	@Column(name = "NQUANTITY_GROUP", precision = 6, scale = 0)
	public Integer getNquantityGroup() {
		return this.nquantityGroup;
	}

	public void setNquantityGroup(final Integer nquantityGroup) {
		this.nquantityGroup = nquantityGroup;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(final Long naccountKey) {
		this.naccountKey = naccountKey;
	}

	@Column(name = "CACCOUNT", length = 18)
	public String getCaccount() {
		return this.caccount;
	}

	public void setCaccount(final String caccount) {
		this.caccount = caccount;
	}

	@Column(name = "NBILLING_STATUS", nullable = false, precision = 1, scale = 0)
	public int getNbillingStatus() {
		return this.nbillingStatus;
	}

	public void setNbillingStatus(final int nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	@Column(name = "NCALC_ID", nullable = false, precision = 12, scale = 0)
	public long getNcalcId() {
		return this.ncalcId;
	}

	public void setNcalcId(final long ncalcId) {
		this.ncalcId = ncalcId;
	}

	@Column(name = "NCALC_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNcalcDetailKey() {
		return this.ncalcDetailKey;
	}

	public void setNcalcDetailKey(final Long ncalcDetailKey) {
		this.ncalcDetailKey = ncalcDetailKey;
	}

	@Column(name = "NPERCENTAGE", nullable = false, precision = 3, scale = 0)
	public int getNpercentage() {
		return this.npercentage;
	}

	public void setNpercentage(final int npercentage) {
		this.npercentage = npercentage;
	}

	@Column(name = "NVALUE", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNvalue() {
		return this.nvalue;
	}

	public void setNvalue(final BigDecimal nvalue) {
		this.nvalue = nvalue;
	}

	@Column(name = "NSPML_DEDUCTION", nullable = false, precision = 1, scale = 0)
	public int getNspmlDeduction() {
		return this.nspmlDeduction;
	}

	public void setNspmlDeduction(final int nspmlDeduction) {
		this.nspmlDeduction = nspmlDeduction;
	}

	@Column(name = "NAC_TRANSFER", nullable = false, precision = 1, scale = 0)
	public int getNacTransfer() {
		return this.nacTransfer;
	}

	public void setNacTransfer(final int nacTransfer) {
		this.nacTransfer = nacTransfer;
	}

	@Column(name = "NPAX", nullable = false, precision = 4, scale = 0)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(final int npax) {
		this.npax = npax;
	}

	@Column(name = "NPAX_MANUAL", nullable = false, precision = 4, scale = 0)
	public int getNpaxManual() {
		return this.npaxManual;
	}

	public void setNpaxManual(final int npaxManual) {
		this.npaxManual = npaxManual;
	}

	@Column(name = "NCALC_BASIS", nullable = false, precision = 6, scale = 0)
	public int getNcalcBasis() {
		return this.ncalcBasis;
	}

	public void setNcalcBasis(final int ncalcBasis) {
		this.ncalcBasis = ncalcBasis;
	}

	@Column(name = "NQUANTITY1", precision = 12, scale = 3)
	public BigDecimal getNquantity1() {
		return this.nquantity1;
	}

	public void setNquantity1(final BigDecimal nquantity1) {
		this.nquantity1 = nquantity1;
	}

	@Column(name = "NQUANTITY2", precision = 12, scale = 3)
	public BigDecimal getNquantity2() {
		return this.nquantity2;
	}

	public void setNquantity2(final BigDecimal nquantity2) {
		this.nquantity2 = nquantity2;
	}

	@Column(name = "NQUANTITY3", precision = 12, scale = 3)
	public BigDecimal getNquantity3() {
		return this.nquantity3;
	}

	public void setNquantity3(final BigDecimal nquantity3) {
		this.nquantity3 = nquantity3;
	}

	@Column(name = "NQUANTITY4", precision = 12, scale = 3)
	public BigDecimal getNquantity4() {
		return this.nquantity4;
	}

	public void setNquantity4(final BigDecimal nquantity4) {
		this.nquantity4 = nquantity4;
	}

	@Column(name = "NQUANTITY5", precision = 12, scale = 3)
	public BigDecimal getNquantity5() {
		return this.nquantity5;
	}

	public void setNquantity5(final BigDecimal nquantity5) {
		this.nquantity5 = nquantity5;
	}

	@Column(name = "NQUANTITY6", precision = 12, scale = 3)
	public BigDecimal getNquantity6() {
		return this.nquantity6;
	}

	public void setNquantity6(final BigDecimal nquantity6) {
		this.nquantity6 = nquantity6;
	}

	@Column(name = "NQUANTITY7", precision = 12, scale = 3)
	public BigDecimal getNquantity7() {
		return this.nquantity7;
	}

	public void setNquantity7(final BigDecimal nquantity7) {
		this.nquantity7 = nquantity7;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NQUANTITY_OLD", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantityOld() {
		return this.nquantityOld;
	}

	public void setNquantityOld(final BigDecimal nquantityOld) {
		this.nquantityOld = nquantityOld;
	}

	@Column(name = "NMANUAL_INPUT", nullable = false, precision = 1, scale = 0)
	public int getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final int nmanualInput) {
		this.nmanualInput = nmanualInput;
	}

	@Column(name = "NMANUAL_PROCESSING", nullable = false, precision = 1, scale = 0)
	public int getNmanualProcessing() {
		return this.nmanualProcessing;
	}

	public void setNmanualProcessing(final int nmanualProcessing) {
		this.nmanualProcessing = nmanualProcessing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CDESCRIPTION", length = 30)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CAREA_HOST", length = 3)
	public String getCareaHost() {
		return this.careaHost;
	}

	public void setCareaHost(final String careaHost) {
		this.careaHost = careaHost;
	}

	@Column(name = "CEFFORT_HOST", length = 2)
	public String getCeffortHost() {
		return this.ceffortHost;
	}

	public void setCeffortHost(final String ceffortHost) {
		this.ceffortHost = ceffortHost;
	}

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(final String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
	}

	@Column(name = "NPLTYPE_KEY", precision = 12, scale = 0)
	public Long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final Long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "NPL_KIND_KEY", precision = 12, scale = 0)
	public Long getNplKindKey() {
		return this.nplKindKey;
	}

	public void setNplKindKey(final Long nplKindKey) {
		this.nplKindKey = nplKindKey;
	}

	@Column(name = "NPACKINGLIST_KEY", precision = 12, scale = 0)
	public Long getNpackinglistKey() {
		return this.npackinglistKey;
	}

	public void setNpackinglistKey(final Long npackinglistKey) {
		this.npackinglistKey = npackinglistKey;
	}

	@Column(name = "NPACKINGLIST_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNpackinglistDetailKey() {
		return this.npackinglistDetailKey;
	}

	public void setNpackinglistDetailKey(final Long npackinglistDetailKey) {
		this.npackinglistDetailKey = npackinglistDetailKey;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NDISTRIBUTE", precision = 1, scale = 0)
	public Integer getNdistribute() {
		return this.ndistribute;
	}

	public void setNdistribute(final Integer ndistribute) {
		this.ndistribute = ndistribute;
	}

	@Column(name = "NPOSTING_TYPE", precision = 1, scale = 0)
	public Integer getNpostingType() {
		return this.npostingType;
	}

	public void setNpostingType(final Integer npostingType) {
		this.npostingType = npostingType;
	}

	@Column(name = "NSALES_PRICE", precision = 12)
	public BigDecimal getNsalesPrice() {
		return this.nsalesPrice;
	}

	public void setNsalesPrice(final BigDecimal nsalesPrice) {
		this.nsalesPrice = nsalesPrice;
	}

	@Column(name = "NDELIVERY_NOTE", precision = 1, scale = 0)
	public Integer getNdeliveryNote() {
		return this.ndeliveryNote;
	}

	public void setNdeliveryNote(final Integer ndeliveryNote) {
		this.ndeliveryNote = ndeliveryNote;
	}

	@Column(name = "CDELIVERY_SNR", length = 18)
	public String getCdeliverySnr() {
		return this.cdeliverySnr;
	}

	public void setCdeliverySnr(final String cdeliverySnr) {
		this.cdeliverySnr = cdeliverySnr;
	}

	@Column(name = "CDELIVERY_TEXT", length = 40)
	public String getCdeliveryText() {
		return this.cdeliveryText;
	}

	public void setCdeliveryText(final String cdeliveryText) {
		this.cdeliveryText = cdeliveryText;
	}

	@Column(name = "NCONTROLLING", precision = 1, scale = 0)
	public Integer getNcontrolling() {
		return this.ncontrolling;
	}

	public void setNcontrolling(final Integer ncontrolling) {
		this.ncontrolling = ncontrolling;
	}

	@Column(name = "NSYSACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(final Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "CCODE", length = 5)
	public String getCcode() {
		return this.ccode;
	}

	public void setCcode(final String ccode) {
		this.ccode = ccode;
	}

	@Column(name = "NREMITTANCEPRICE", precision = 12)
	public BigDecimal getNremittanceprice() {
		return this.nremittanceprice;
	}

	public void setNremittanceprice(final BigDecimal nremittanceprice) {
		this.nremittanceprice = nremittanceprice;
	}

	@Column(name = "NDISCOUNT", precision = 5)
	public BigDecimal getNdiscount() {
		return this.ndiscount;
	}

	public void setNdiscount(final BigDecimal ndiscount) {
		this.ndiscount = ndiscount;
	}

	@Column(name = "NPORTFEE", precision = 5)
	public BigDecimal getNportfee() {
		return this.nportfee;
	}

	public void setNportfee(final BigDecimal nportfee) {
		this.nportfee = nportfee;
	}

	@Column(name = "NVAT_VALUE", precision = 5)
	public BigDecimal getNvatValue() {
		return this.nvatValue;
	}

	public void setNvatValue(final BigDecimal nvatValue) {
		this.nvatValue = nvatValue;
	}

	@Column(name = "NINVOICE_CYCLE_KEY", precision = 12, scale = 0)
	public Long getNinvoiceCycleKey() {
		return this.ninvoiceCycleKey;
	}

	public void setNinvoiceCycleKey(final Long ninvoiceCycleKey) {
		this.ninvoiceCycleKey = ninvoiceCycleKey;
	}

	@Column(name = "NCOST_PRICE", precision = 12)
	public BigDecimal getNcostPrice() {
		return this.ncostPrice;
	}

	public void setNcostPrice(final BigDecimal ncostPrice) {
		this.ncostPrice = ncostPrice;
	}

	@Column(name = "NINVOICE_STATUS", precision = 1, scale = 0)
	public Integer getNinvoiceStatus() {
		return this.ninvoiceStatus;
	}

	public void setNinvoiceStatus(final Integer ninvoiceStatus) {
		this.ninvoiceStatus = ninvoiceStatus;
	}

	@Column(name = "CCLASSES", length = 40)
	public String getCclasses() {
		return this.cclasses;
	}

	public void setCclasses(final String cclasses) {
		this.cclasses = cclasses;
	}

	@Column(name = "NSALES_PRICE_MODIFIED", precision = 1, scale = 0)
	public Integer getNsalesPriceModified() {
		return this.nsalesPriceModified;
	}

	public void setNsalesPriceModified(final Integer nsalesPriceModified) {
		this.nsalesPriceModified = nsalesPriceModified;
	}

	@Column(name = "NPRICE_CALC_TYPE", precision = 12, scale = 0)
	public Long getNpriceCalcType() {
		return this.npriceCalcType;
	}

	public void setNpriceCalcType(final Long npriceCalcType) {
		this.npriceCalcType = npriceCalcType;
	}

	@Column(name = "NCOSTTYPE", precision = 12, scale = 0)
	public Long getNcosttype() {
		return this.ncosttype;
	}

	public void setNcosttype(final Long ncosttype) {
		this.ncosttype = ncosttype;
	}

	@Column(name = "CTAXCODE", length = 2)
	public String getCtaxcode() {
		return this.ctaxcode;
	}

	public void setCtaxcode(final String ctaxcode) {
		this.ctaxcode = ctaxcode;
	}

	@Column(name = "NBILLING_PRICE", precision = 12, scale = 4)
	public BigDecimal getNbillingPrice() {
		return this.nbillingPrice;
	}

	public void setNbillingPrice(final BigDecimal nbillingPrice) {
		this.nbillingPrice = nbillingPrice;
	}

	@Column(name = "NRELEASE_EXCLUSION", precision = 1, scale = 0)
	public Integer getNreleaseExclusion() {
		return this.nreleaseExclusion;
	}

	public void setNreleaseExclusion(final Integer nreleaseExclusion) {
		this.nreleaseExclusion = nreleaseExclusion;
	}

	@Column(name = "NSTATIONENTRY", precision = 1, scale = 0)
	public Integer getNstationentry() {
		return this.nstationentry;
	}

	public void setNstationentry(final Integer nstationentry) {
		this.nstationentry = nstationentry;
	}

	@Column(name = "CCUSTOMER_PL", length = 36)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 84)
	public String getCcustomerText() {
		return this.ccustomerText;
	}

	public void setCcustomerText(final String ccustomerText) {
		this.ccustomerText = ccustomerText;
	}

	@Column(name = "NQUANTITY_RECALC", precision = 12, scale = 3)
	public BigDecimal getNquantityRecalc() {
		return this.nquantityRecalc;
	}

	public void setNquantityRecalc(final BigDecimal nquantityRecalc) {
		this.nquantityRecalc = nquantityRecalc;
	}

	@Column(name = "NSALES_PRICE_RECALC", precision = 12)
	public BigDecimal getNsalesPriceRecalc() {
		return this.nsalesPriceRecalc;
	}

	public void setNsalesPriceRecalc(final BigDecimal nsalesPriceRecalc) {
		this.nsalesPriceRecalc = nsalesPriceRecalc;
	}

	@Column(name = "NBILLING_PRICE_RECALC", precision = 12, scale = 4)
	public BigDecimal getNbillingPriceRecalc() {
		return this.nbillingPriceRecalc;
	}

	public void setNbillingPriceRecalc(final BigDecimal nbillingPriceRecalc) {
		this.nbillingPriceRecalc = nbillingPriceRecalc;
	}

	@Column(name = "NCOST_PRICE_RECALC", precision = 12)
	public BigDecimal getNcostPriceRecalc() {
		return this.ncostPriceRecalc;
	}

	public void setNcostPriceRecalc(final BigDecimal ncostPriceRecalc) {
		this.ncostPriceRecalc = ncostPriceRecalc;
	}

	@Column(name = "NREMITTENCEPRICE_RECALC", precision = 12)
	public BigDecimal getNremittencepriceRecalc() {
		return this.nremittencepriceRecalc;
	}

	public void setNremittencepriceRecalc(final BigDecimal nremittencepriceRecalc) {
		this.nremittencepriceRecalc = nremittencepriceRecalc;
	}

	@Column(name = "NVAT_VALUE_RECALC", precision = 5)
	public BigDecimal getNvatValueRecalc() {
		return this.nvatValueRecalc;
	}

	public void setNvatValueRecalc(final BigDecimal nvatValueRecalc) {
		this.nvatValueRecalc = nvatValueRecalc;
	}

	@Column(name = "NDISCOUNT_RECALC", precision = 5)
	public BigDecimal getNdiscountRecalc() {
		return this.ndiscountRecalc;
	}

	public void setNdiscountRecalc(final BigDecimal ndiscountRecalc) {
		this.ndiscountRecalc = ndiscountRecalc;
	}

	@Column(name = "NPORTFEE_RECALC", precision = 5)
	public BigDecimal getNportfeeRecalc() {
		return this.nportfeeRecalc;
	}

	public void setNportfeeRecalc(final BigDecimal nportfeeRecalc) {
		this.nportfeeRecalc = nportfeeRecalc;
	}

	@Column(name = "NCALC_BASIS_RECALC", precision = 6, scale = 0)
	public Integer getNcalcBasisRecalc() {
		return this.ncalcBasisRecalc;
	}

	public void setNcalcBasisRecalc(final Integer ncalcBasisRecalc) {
		this.ncalcBasisRecalc = ncalcBasisRecalc;
	}

	@Column(name = "NIMPORT_FROM_BOB", precision = 1, scale = 0)
	public Integer getNimportFromBob() {
		return this.nimportFromBob;
	}

	public void setNimportFromBob(final Integer nimportFromBob) {
		this.nimportFromBob = nimportFromBob;
	}

	@Column(name = "NVAT_VALUE_PORTFEE", precision = 5)
	public BigDecimal getNvatValuePortfee() {
		return this.nvatValuePortfee;
	}

	public void setNvatValuePortfee(final BigDecimal nvatValuePortfee) {
		this.nvatValuePortfee = nvatValuePortfee;
	}

	@Column(name = "NVAT_KEY", precision = 12, scale = 0)
	public Long getNvatKey() {
		return this.nvatKey;
	}

	public void setNvatKey(final Long nvatKey) {
		this.nvatKey = nvatKey;
	}

	@Column(name = "NVAT_KEY_PORTFEE", precision = 12, scale = 0)
	public Long getNvatKeyPortfee() {
		return this.nvatKeyPortfee;
	}

	public void setNvatKeyPortfee(final Long nvatKeyPortfee) {
		this.nvatKeyPortfee = nvatKeyPortfee;
	}

	@Column(name = "NREDUCTION_FLAG", precision = 1, scale = 0)
	public Integer getNreductionFlag() {
		return this.nreductionFlag;
	}

	public void setNreductionFlag(final Integer nreductionFlag) {
		this.nreductionFlag = nreductionFlag;
	}

	@Column(name = "NREMARK_MANUAL", precision = 1, scale = 0)
	public Integer getNremarkManual() {
		return this.nremarkManual;
	}

	public void setNremarkManual(final Integer nremarkManual) {
		this.nremarkManual = nremarkManual;
	}

	@Column(name = "NLOCAL_SUB", precision = 1, scale = 0)
	public Integer getNlocalSub() {
		return this.nlocalSub;
	}

	public void setNlocalSub(final Integer nlocalSub) {
		this.nlocalSub = nlocalSub;
	}

	@Column(name = "NPL_INDEX_KEY_ORI", precision = 12, scale = 0)
	public Long getNplIndexKeyOri() {
		return this.nplIndexKeyOri;
	}

	public void setNplIndexKeyOri(final Long nplIndexKeyOri) {
		this.nplIndexKeyOri = nplIndexKeyOri;
	}

	@Column(name = "CPACKINGLIST_ORI", length = 36)
	public String getCpackinglistOri() {
		return this.cpackinglistOri;
	}

	public void setCpackinglistOri(final String cpackinglistOri) {
		this.cpackinglistOri = cpackinglistOri;
	}

	@Column(name = "CTEXT_ORI", length = 84)
	public String getCtextOri() {
		return this.ctextOri;
	}

	public void setCtextOri(final String ctextOri) {
		this.ctextOri = ctextOri;
	}

	@Column(name = "NCALC_ID_ORI", precision = 12, scale = 0)
	public Long getNcalcIdOri() {
		return this.ncalcIdOri;
	}

	public void setNcalcIdOri(final Long ncalcIdOri) {
		this.ncalcIdOri = ncalcIdOri;
	}

	@Column(name = "NCALC_DETAIL_KEY_ORI", precision = 12, scale = 0)
	public Long getNcalcDetailKeyOri() {
		return this.ncalcDetailKeyOri;
	}

	public void setNcalcDetailKeyOri(final Long ncalcDetailKeyOri) {
		this.ncalcDetailKeyOri = ncalcDetailKeyOri;
	}

	@Column(name = "NPERCENTAGE_ORI", precision = 3, scale = 0)
	public Integer getNpercentageOri() {
		return this.npercentageOri;
	}

	public void setNpercentageOri(final Integer npercentageOri) {
		this.npercentageOri = npercentageOri;
	}

	@Column(name = "NVALUE_ORI", precision = 12, scale = 3)
	public BigDecimal getNvalueOri() {
		return this.nvalueOri;
	}

	public void setNvalueOri(final BigDecimal nvalueOri) {
		this.nvalueOri = nvalueOri;
	}

	@Column(name = "NMAX_VALUE_ORI", precision = 12, scale = 3)
	public BigDecimal getNmaxValueOri() {
		return this.nmaxValueOri;
	}

	public void setNmaxValueOri(final BigDecimal nmaxValueOri) {
		this.nmaxValueOri = nmaxValueOri;
	}

	@Column(name = "NQUANTITY_VERSION", precision = 12, scale = 3)
	public BigDecimal getNquantityVersion() {
		return this.nquantityVersion;
	}

	public void setNquantityVersion(final BigDecimal nquantityVersion) {
		this.nquantityVersion = nquantityVersion;
	}

	@Column(name = "NFLAG_ISDEFAULTPRICE", precision = 1, scale = 0)
	public Integer getNflagIsdefaultprice() {
		return this.nflagIsdefaultprice;
	}

	public void setNflagIsdefaultprice(final Integer nflagIsdefaultprice) {
		this.nflagIsdefaultprice = nflagIsdefaultprice;
	}

	@Column(name = "NFLAG_ISINVALIDUNIT", precision = 1, scale = 0)
	public Integer getNflagIsinvalidunit() {
		return this.nflagIsinvalidunit;
	}

	public void setNflagIsinvalidunit(final Integer nflagIsinvalidunit) {
		this.nflagIsinvalidunit = nflagIsinvalidunit;
	}

	@Column(name = "CPACKINGLIST_XSL", length = 36)
	public String getCpackinglistXsl() {
		return this.cpackinglistXsl;
	}

	public void setCpackinglistXsl(final String cpackinglistXsl) {
		this.cpackinglistXsl = cpackinglistXsl;
	}

	@Column(name = "NMAX_VALUE", precision = 4, scale = 0)
	public Integer getNmaxValue() {
		return this.nmaxValue;
	}

	public void setNmaxValue(final Integer nmaxValue) {
		this.nmaxValue = nmaxValue;
	}

	@Column(name = "NMIN_VALUE", precision = 4, scale = 0)
	public Integer getNminValue() {
		return this.nminValue;
	}

	public void setNminValue(final Integer nminValue) {
		this.nminValue = nminValue;
	}

	@Column(name = "NMANUAL_COMP", precision = 1, scale = 0)
	public Integer getNmanualComp() {
		return this.nmanualComp;
	}

	public void setNmanualComp(final Integer nmanualComp) {
		this.nmanualComp = nmanualComp;
	}

	@Column(name = "NINPUT_FROM_TOP_OFF", precision = 1, scale = 0)
	public Integer getNinputFromTopOff() {
		return this.ninputFromTopOff;
	}

	public void setNinputFromTopOff(final Integer ninputFromTopOff) {
		this.ninputFromTopOff = ninputFromTopOff;
	}

	@Column(name = "NTB_TOP_UP", precision = 12, scale = 3)
	public BigDecimal getNtbTopUp() {
		return this.ntbTopUp;
	}

	public void setNtbTopUp(final BigDecimal ntbTopUp) {
		this.ntbTopUp = ntbTopUp;
	}

	@Column(name = "NTB_TOP_DOWN", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbTopDown() {
		return this.ntbTopDown;
	}

	public void setNtbTopDown(final BigDecimal ntbTopDown) {
		this.ntbTopDown = ntbTopDown;
	}

	@Column(name = "NTB_W_RECY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWRecy() {
		return this.ntbWRecy;
	}

	public void setNtbWRecy(final BigDecimal ntbWRecy) {
		this.ntbWRecy = ntbWRecy;
	}

	@Column(name = "NTB_W_COLD", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWCold() {
		return this.ntbWCold;
	}

	public void setNtbWCold(final BigDecimal ntbWCold) {
		this.ntbWCold = ntbWCold;
	}

	@Column(name = "NTB_W_PACK", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWPack() {
		return this.ntbWPack;
	}

	public void setNtbWPack(final BigDecimal ntbWPack) {
		this.ntbWPack = ntbWPack;
	}

	@Column(name = "NTB_W_PERIS", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWPeris() {
		return this.ntbWPeris;
	}

	public void setNtbWPeris(final BigDecimal ntbWPeris) {
		this.ntbWPeris = ntbWPeris;
	}

	@Column(name = "NTB_W_SAMP", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWSamp() {
		return this.ntbWSamp;
	}

	public void setNtbWSamp(final BigDecimal ntbWSamp) {
		this.ntbWSamp = ntbWSamp;
	}

	@Column(name = "NTB_W_BROK", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWBrok() {
		return this.ntbWBrok;
	}

	public void setNtbWBrok(final BigDecimal ntbWBrok) {
		this.ntbWBrok = ntbWBrok;
	}

	@Column(name = "NTB_W_LOOK", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWLook() {
		return this.ntbWLook;
	}

	public void setNtbWLook(final BigDecimal ntbWLook) {
		this.ntbWLook = ntbWLook;
	}

	@Column(name = "NTB_W_OTHER", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWOther() {
		return this.ntbWOther;
	}

	public void setNtbWOther(final BigDecimal ntbWOther) {
		this.ntbWOther = ntbWOther;
	}

	@Column(name = "NTB_W_UNDEF_1", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWUndef1() {
		return this.ntbWUndef1;
	}

	public void setNtbWUndef1(final BigDecimal ntbWUndef1) {
		this.ntbWUndef1 = ntbWUndef1;
	}

	@Column(name = "NTB_W_UNDEF_2", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWUndef2() {
		return this.ntbWUndef2;
	}

	public void setNtbWUndef2(final BigDecimal ntbWUndef2) {
		this.ntbWUndef2 = ntbWUndef2;
	}

	@Column(name = "NTB_W_UNDEF_3", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNtbWUndef3() {
		return this.ntbWUndef3;
	}

	public void setNtbWUndef3(final BigDecimal ntbWUndef3) {
		this.ntbWUndef3 = ntbWUndef3;
	}

	@Column(name = "NTB_TEMP", precision = 12, scale = 3)
	public BigDecimal getNtbTemp() {
		return this.ntbTemp;
	}

	public void setNtbTemp(final BigDecimal ntbTemp) {
		this.ntbTemp = ntbTemp;
	}

	@Column(name = "CTB_REMARK", length = 80)
	public String getCtbRemark() {
		return this.ctbRemark;
	}

	public void setCtbRemark(final String ctbRemark) {
		this.ctbRemark = ctbRemark;
	}

	@Column(name = "NQUANTITY_MIS", precision = 12, scale = 3)
	public BigDecimal getNquantityMis() {
		return this.nquantityMis;
	}

	public void setNquantityMis(final BigDecimal nquantityMis) {
		this.nquantityMis = nquantityMis;
	}

	@Column(name = "NPLANNING_PERCENT", precision = 3, scale = 0)
	public Integer getNplanningPercent() {
		return this.nplanningPercent;
	}

	public void setNplanningPercent(final Integer nplanningPercent) {
		this.nplanningPercent = nplanningPercent;
	}

	@Column(name = "CPREFIX", length = 10)
	public String getCprefix() {
		return this.cprefix;
	}

	public void setCprefix(final String cprefix) {
		this.cprefix = cprefix;
	}

	@Column(name = "NREDUCE", precision = 1, scale = 0)
	public Integer getNreduce() {
		return this.nreduce;
	}

	public void setNreduce(final Integer nreduce) {
		this.nreduce = nreduce;
	}

	@Column(name = "COVERUNDERLOAD", length = 4)
	public String getCoverunderload() {
		return this.coverunderload;
	}

	public void setCoverunderload(final String coverunderload) {
		this.coverunderload = coverunderload;
	}

	@Column(name = "NSERVICE_SEQUENCE", precision = 1, scale = 0)
	public Integer getNserviceSequence() {
		return this.nserviceSequence;
	}

	public void setNserviceSequence(final Integer nserviceSequence) {
		this.nserviceSequence = nserviceSequence;
	}

	@Column(name = "CSAP_CODE", length = 3)
	public String getCsapCode() {
		return this.csapCode;
	}

	public void setCsapCode(final String csapCode) {
		this.csapCode = csapCode;
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

	@Column(name = "NPREORDER_KEY", precision = 12, scale = 0)
	public Long getNpreorderKey() {
		return this.npreorderKey;
	}

	public void setNpreorderKey(final Long npreorderKey) {
		this.npreorderKey = npreorderKey;
	}

	@Column(name = "NADD_DELIVERY_FLAG", precision = 1, scale = 0)
	public Integer getNaddDeliveryFlag() {
		return this.naddDeliveryFlag;
	}

	public void setNaddDeliveryFlag(final Integer naddDeliveryFlag) {
		this.naddDeliveryFlag = naddDeliveryFlag;
	}

	@Column(name = "CSALES_BOM", length = 18)
	public String getCsalesBom() {
		return this.csalesBom;
	}

	public void setCsalesBom(final String csalesBom) {
		this.csalesBom = csalesBom;
	}

	@Column(name = "NGALLEY_REGION_KEY", precision = 12, scale = 0)
	public Long getNgalleyRegionKey() {
		return this.ngalleyRegionKey;
	}

	public void setNgalleyRegionKey(final Long ngalleyRegionKey) {
		this.ngalleyRegionKey = ngalleyRegionKey;
	}

	@Column(name = "NDYNAMIC_MEALS", precision = 1, scale = 0)
	public Integer getNdynamicMeals() {
		return this.ndynamicMeals;
	}

	public void setNdynamicMeals(final Integer ndynamicMeals) {
		this.ndynamicMeals = ndynamicMeals;
	}

	@Column(name = "CDM_CCUSTOMER_PL", length = 36)
	public String getCdmCcustomerPl() {
		return this.cdmCcustomerPl;
	}

	public void setCdmCcustomerPl(final String cdmCcustomerPl) {
		this.cdmCcustomerPl = cdmCcustomerPl;
	}

	@Column(name = "NDM_USE_PARENT", precision = 1, scale = 0)
	public Integer getNdmUseParent() {
		return this.ndmUseParent;
	}

	public void setNdmUseParent(final Integer ndmUseParent) {
		this.ndmUseParent = ndmUseParent;
	}

}


