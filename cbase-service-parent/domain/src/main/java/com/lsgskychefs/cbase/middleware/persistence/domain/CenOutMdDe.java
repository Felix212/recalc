package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table CEN_OUT_MD_DE (Flight event Meal-Distribution Distribution-Errors)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD_DE")
public class CenOutMdDe implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdDeId id;
	private CenOut cenOut;
	private long ndetailKey;
	private long nhandlingKey;
	private long nhandlingDetailKey;
	private String chandlingText = " ";
	private long ncoverKey;
	private String ccoverText = " ";
	private int ncoverPrio;
	private long nhandlingMealKey;
	private long nclassNumber;
	private String cclass;
	private int nreserveQuantity;
	private int nreserveType;
	private int ntopoffQuantity;
	private int ntopoffType;
	private long nrotationKey;
	private long nrotationNameKey;
	private String crotation = " ";
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
	private BigDecimal nquantity;
	private BigDecimal nquantityOld;
	private int nmanualInput;
	private int nmanualProcessing;
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private BigDecimal nquantity1;
	private BigDecimal nquantity2;
	private BigDecimal nquantity3;
	private BigDecimal nquantity4;
	private BigDecimal nquantity5;
	private BigDecimal nquantity6;
	private BigDecimal nquantity7;
	private int nspmlQuantity;
	private String careaHost;
	private String ceffortHost;
	private String cadditionalAccount;
	private String ctext;
	private Integer nheight;
	private Integer nwidth;
	private Integer nquantityCps;
	private long npltypeKey;
	private Integer ndistribute;
	private Integer ndone;
	private Integer nspml;
	private String cstowagegroup;
	private Integer ngroupsort;
	private Long ndistributionKey;
	private String ccreatedBy;
	private Date dcreatedDate;
	private SysCalculator sysCalculator;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nrecordCount",
					column = @Column(name = "NRECORD_COUNT", nullable = false, precision = 12, scale = 0)) })
	public CenOutMdDeId getId() {
		return this.id;
	}

	public void setId(final CenOutMdDeId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Column(name = "NDETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
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
		this.chandlingText = CbaseMiddlewareStringUtils.defaultString(chandlingText);
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
		this.ccoverText = CbaseMiddlewareStringUtils.defaultString(ccoverText);
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
		this.crotation = CbaseMiddlewareStringUtils.defaultString(crotation);
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

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
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

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 100)
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

	@Column(name = "NVALUE", precision = 12, scale = 3)
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

	@Column(name = "NSPML_QUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNspmlQuantity() {
		return this.nspmlQuantity;
	}

	public void setNspmlQuantity(final int nspmlQuantity) {
		this.nspmlQuantity = nspmlQuantity;
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

	@Column(name = "CTEXT", nullable = false, length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "NHEIGHT", precision = 12, scale = 0)
	public Integer getNheight() {
		return this.nheight;
	}

	public void setNheight(final Integer nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 12, scale = 0)
	public Integer getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(final Integer nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NQUANTITY_CPS", precision = 6, scale = 0)
	public Integer getNquantityCps() {
		return this.nquantityCps;
	}

	public void setNquantityCps(final Integer nquantityCps) {
		this.nquantityCps = nquantityCps;
	}

	@Column(name = "NPLTYPE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpltypeKey() {
		return this.npltypeKey;
	}

	public void setNpltypeKey(final long npltypeKey) {
		this.npltypeKey = npltypeKey;
	}

	@Column(name = "NDISTRIBUTE", precision = 1, scale = 0)
	public Integer getNdistribute() {
		return this.ndistribute;
	}

	public void setNdistribute(final Integer ndistribute) {
		this.ndistribute = ndistribute;
	}

	@Column(name = "NDONE", precision = 1, scale = 0)
	public Integer getNdone() {
		return this.ndone;
	}

	public void setNdone(final Integer ndone) {
		this.ndone = ndone;
	}

	@Column(name = "NSPML", precision = 1, scale = 0)
	public Integer getNspml() {
		return this.nspml;
	}

	public void setNspml(final Integer nspml) {
		this.nspml = nspml;
	}

	@Column(name = "CSTOWAGEGROUP", length = 200)
	public String getCstowagegroup() {
		return this.cstowagegroup;
	}

	public void setCstowagegroup(final String cstowagegroup) {
		this.cstowagegroup = cstowagegroup;
	}

	@Column(name = "NGROUPSORT", precision = 6, scale = 0)
	public Integer getNgroupsort() {
		return this.ngroupsort;
	}

	public void setNgroupsort(final Integer ngroupsort) {
		this.ngroupsort = ngroupsort;
	}

	@Column(name = "NDISTRIBUTION_KEY", precision = 12, scale = 0)
	public Long getNdistributionKey() {
		return this.ndistributionKey;
	}

	public void setNdistributionKey(final Long ndistributionKey) {
		this.ndistributionKey = ndistributionKey;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCALC_ID", nullable = false, insertable = false, updatable = false)
	public SysCalculator getSysCalculator() {
		return this.sysCalculator;
	}

	public void setSysCalculator(final SysCalculator sysCalculator) {
		this.sysCalculator = sysCalculator;
	}
}
