package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.02.2016 17:57:05 by Hibernate Tools 4.3.2-SNAPSHOT

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_SPML_DETAIL (special meal detail)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML_DETAIL")
public class CenOutSpmlDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndetailKey;
	private CenOutSpml cenOutSpml;
	private long ntransaction;
	private long nhandlingKey;
	private long nhandlingSpmlKey;
	private String chandlingText;
	private long nrotationKey;
	private long nrotationNameKey;
	private String crotation;
	private int nprio;
	private long npackinglistIndexKey;
	private String cpackinglist;
	private String cunit;
	private String cmealControlCode;
	private String cproductionText;
	private Long naccountKey;
	private String caccount;
	private int nbillingStatus;
	private int nacTransfer;
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
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private String cadditionalAccount;
	private Long npltypeKey;
	private Long npackinglistDetailKey;
	private String ctext;
	private Long nplKindKey;
	private Long npackinglistKey;
	private Integer ndistribute;
	private Integer npostingType;
	private BigDecimal nsalesPrice;
	private Long nsysaccountKey;
	private String ccode;
	private BigDecimal nremittanceprice;
	private BigDecimal ndiscount;
	private BigDecimal nportfee;
	private BigDecimal nvatValue;
	private Long ninvoiceCycleKey;
	private BigDecimal ncostPrice;
	private Integer ninvoiceStatus;
	private Integer nsalesPriceModified;
	private Long npriceCalcType;
	private Long ncosttype;
	private String ctaxcode;
	private BigDecimal nbillingPrice;
	private Integer nreleaseExclusion;
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
	private BigDecimal nvatValuePortfee;
	private Long nvatKey;
	private Long nvatKeyPortfee;
	private Integer nflagIsdefaultprice;
	private Integer nflagIsinvalidunit;
	private String cpackinglistXsl;
	private int nlocalSub;
	private Long nplIndexKeyOri;
	private String cpackinglistOri;
	private String ctextOri;
	private CenPackinglists cenPackinglists;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_SPML_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_OUT_SPML_DETAIL", sequenceName = "SEQ_CEN_OUT_SPML_DETAIL", allocationSize = 1)
	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMASTER_KEY", nullable = false)
	public CenOutSpml getCenOutSpml() {
		return this.cenOutSpml;
	}

	public void setCenOutSpml(final CenOutSpml cenOutSpml) {
		this.cenOutSpml = cenOutSpml;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NHANDLING_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(final long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
	}

	@Column(name = "NHANDLING_SPML_KEY", nullable = false, precision = 12, scale = 0)
	public long getNhandlingSpmlKey() {
		return this.nhandlingSpmlKey;
	}

	public void setNhandlingSpmlKey(final long nhandlingSpmlKey) {
		this.nhandlingSpmlKey = nhandlingSpmlKey;
	}

	@Column(name = "CHANDLING_TEXT", nullable = false, length = 30)
	public String getChandlingText() {
		return this.chandlingText;
	}

	public void setChandlingText(final String chandlingText) {
		this.chandlingText = chandlingText;
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

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 40)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
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

	@Column(name = "NAC_TRANSFER", nullable = false, precision = 1, scale = 0)
	public int getNacTransfer() {
		return this.nacTransfer;
	}

	public void setNacTransfer(final int nacTransfer) {
		this.nacTransfer = nacTransfer;
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

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_TEXT", length = 40)
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

	@Column(name = "CPACKINGLIST_XSL", length = 18)
	public String getCpackinglistXsl() {
		return this.cpackinglistXsl;
	}

	public void setCpackinglistXsl(final String cpackinglistXsl) {
		this.cpackinglistXsl = cpackinglistXsl;
	}

	@Column(name = "NLOCAL_SUB", nullable = false, precision = 1, scale = 0)
	public int getNlocalSub() {
		return this.nlocalSub;
	}

	public void setNlocalSub(final int nlocalSub) {
		this.nlocalSub = nlocalSub;
	}

	@Column(name = "NPL_INDEX_KEY_ORI", precision = 12, scale = 0)
	public Long getNplIndexKeyOri() {
		return this.nplIndexKeyOri;
	}

	public void setNplIndexKeyOri(final Long nplIndexKeyOri) {
		this.nplIndexKeyOri = nplIndexKeyOri;
	}

	@Column(name = "CPACKINGLIST_ORI", length = 18)
	public String getCpackinglistOri() {
		return this.cpackinglistOri;
	}

	public void setCpackinglistOri(final String cpackinglistOri) {
		this.cpackinglistOri = cpackinglistOri;
	}

	@Column(name = "CTEXT_ORI", length = 80)
	public String getCtextOri() {
		return this.ctextOri;
	}

	public void setCtextOri(final String ctextOri) {
		this.ctextOri = ctextOri;
	}

	/**
	 * Get cenPackinglists
	 *
	 * @return the cenPackinglists
	 */
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", insertable = false,
					updatable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", insertable = false,
					updatable = false) })
	public CenPackinglists getCenPackinglists() {
		return cenPackinglists;
	}

	/**
	 * set cenPackinglists
	 *
	 * @param cenPackinglists the cenPackinglists to set
	 */
	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}
}
