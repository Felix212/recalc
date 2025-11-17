package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 14.06.2022 14:16:47 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_PRICE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_PRICE"
)
public class CenPackinglistPrice implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplPriceKey;
	private long npackinglistIndexKey;
	private long ncustomerKey;
	private String cunit;
	private Date dvalidFrom;
	private Date dvalidTo;
	private BigDecimal nsalesprice;
	private BigDecimal nremittanceprice;
	private BigDecimal ncostPrice;
	private BigDecimal nmatCosts;
	private BigDecimal nlabourCosts;
	private BigDecimal nmatMarkupP;
	private BigDecimal ntotalMatCost;
	private BigDecimal nlabMarkupP;
	private BigDecimal nlabMarkupV;
	private BigDecimal ncalcSalesprice;
	private Integer nuseSellRate;
	private BigDecimal nseconds;
	private Integer nmodified;
	private Date dstamp;
	private Date dstampCosting;
	private Long npriceCalcTypeKey;
	private BigDecimal nbillingPrice;
	private BigDecimal nmatMarkupV;
	private BigDecimal ntotalLabCost;
	private BigDecimal nsumCosts;
	private BigDecimal nsumMarkupP;
	private BigDecimal nsumMarkupV;
	private BigDecimal ndiscount;
	private BigDecimal ndiscountedsalesprice;
	private BigDecimal naveragegroupprice;
	private Date dstampAverageCalc;
	private int navgPriceFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private BigDecimal noverheadMarkupP;
	private BigDecimal nsumOverhead;
	private String ccomment;
	private BigDecimal nskyscopeDiscount;
	private BigDecimal nmarkupindirectP;
	private BigDecimal nsumMarkupindirect;
	private BigDecimal nmarkupsgaP;
	private BigDecimal nsumMarkupsga;
	private BigDecimal nmarkupdb2P;
	private BigDecimal nsumMarkupdb2;

	@Id
	@Column(name = "NPL_PRICE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplPriceKey() {
		return this.nplPriceKey;
	}

	public void setNplPriceKey(long nplPriceKey) {
		this.nplPriceKey = nplPriceKey;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "NCUSTOMER_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcustomerKey() {
		return this.ncustomerKey;
	}

	public void setNcustomerKey(long ncustomerKey) {
		this.ncustomerKey = ncustomerKey;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(String cunit) {
		this.cunit = cunit;
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

	@Column(name = "NSALESPRICE", nullable = false, precision = 12)
	public BigDecimal getNsalesprice() {
		return this.nsalesprice;
	}

	public void setNsalesprice(BigDecimal nsalesprice) {
		this.nsalesprice = nsalesprice;
	}

	@Column(name = "NREMITTANCEPRICE", nullable = false, precision = 12)
	public BigDecimal getNremittanceprice() {
		return this.nremittanceprice;
	}

	public void setNremittanceprice(BigDecimal nremittanceprice) {
		this.nremittanceprice = nremittanceprice;
	}

	@Column(name = "NCOST_PRICE", nullable = false, precision = 12, scale = 4)
	public BigDecimal getNcostPrice() {
		return this.ncostPrice;
	}

	public void setNcostPrice(BigDecimal ncostPrice) {
		this.ncostPrice = ncostPrice;
	}

	@Column(name = "NMAT_COSTS", precision = 12, scale = 4)
	public BigDecimal getNmatCosts() {
		return this.nmatCosts;
	}

	public void setNmatCosts(BigDecimal nmatCosts) {
		this.nmatCosts = nmatCosts;
	}

	@Column(name = "NLABOUR_COSTS", precision = 12, scale = 4)
	public BigDecimal getNlabourCosts() {
		return this.nlabourCosts;
	}

	public void setNlabourCosts(BigDecimal nlabourCosts) {
		this.nlabourCosts = nlabourCosts;
	}

	@Column(name = "NMAT_MARKUP_P", precision = 8)
	public BigDecimal getNmatMarkupP() {
		return this.nmatMarkupP;
	}

	public void setNmatMarkupP(BigDecimal nmatMarkupP) {
		this.nmatMarkupP = nmatMarkupP;
	}

	@Column(name = "NTOTAL_MAT_COST", precision = 12, scale = 4)
	public BigDecimal getNtotalMatCost() {
		return this.ntotalMatCost;
	}

	public void setNtotalMatCost(BigDecimal ntotalMatCost) {
		this.ntotalMatCost = ntotalMatCost;
	}

	@Column(name = "NLAB_MARKUP_P", precision = 8)
	public BigDecimal getNlabMarkupP() {
		return this.nlabMarkupP;
	}

	public void setNlabMarkupP(BigDecimal nlabMarkupP) {
		this.nlabMarkupP = nlabMarkupP;
	}

	@Column(name = "NLAB_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNlabMarkupV() {
		return this.nlabMarkupV;
	}

	public void setNlabMarkupV(BigDecimal nlabMarkupV) {
		this.nlabMarkupV = nlabMarkupV;
	}

	@Column(name = "NCALC_SALESPRICE", precision = 12, scale = 4)
	public BigDecimal getNcalcSalesprice() {
		return this.ncalcSalesprice;
	}

	public void setNcalcSalesprice(BigDecimal ncalcSalesprice) {
		this.ncalcSalesprice = ncalcSalesprice;
	}

	@Column(name = "NUSE_SELL_RATE", precision = 1, scale = 0)
	public Integer getNuseSellRate() {
		return this.nuseSellRate;
	}

	public void setNuseSellRate(Integer nuseSellRate) {
		this.nuseSellRate = nuseSellRate;
	}

	@Column(name = "NSECONDS", precision = 8)
	public BigDecimal getNseconds() {
		return this.nseconds;
	}

	public void setNseconds(BigDecimal nseconds) {
		this.nseconds = nseconds;
	}

	@Column(name = "NMODIFIED", precision = 1, scale = 0)
	public Integer getNmodified() {
		return this.nmodified;
	}

	public void setNmodified(Integer nmodified) {
		this.nmodified = nmodified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP", length = 7)
	public Date getDstamp() {
		return this.dstamp;
	}

	public void setDstamp(Date dstamp) {
		this.dstamp = dstamp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP_COSTING", length = 7)
	public Date getDstampCosting() {
		return this.dstampCosting;
	}

	public void setDstampCosting(Date dstampCosting) {
		this.dstampCosting = dstampCosting;
	}

	@Column(name = "NPRICE_CALC_TYPE_KEY", precision = 12, scale = 0)
	public Long getNpriceCalcTypeKey() {
		return this.npriceCalcTypeKey;
	}

	public void setNpriceCalcTypeKey(Long npriceCalcTypeKey) {
		this.npriceCalcTypeKey = npriceCalcTypeKey;
	}

	@Column(name = "NBILLING_PRICE", precision = 12, scale = 4)
	public BigDecimal getNbillingPrice() {
		return this.nbillingPrice;
	}

	public void setNbillingPrice(BigDecimal nbillingPrice) {
		this.nbillingPrice = nbillingPrice;
	}

	@Column(name = "NMAT_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNmatMarkupV() {
		return this.nmatMarkupV;
	}

	public void setNmatMarkupV(BigDecimal nmatMarkupV) {
		this.nmatMarkupV = nmatMarkupV;
	}

	@Column(name = "NTOTAL_LAB_COST", precision = 12, scale = 4)
	public BigDecimal getNtotalLabCost() {
		return this.ntotalLabCost;
	}

	public void setNtotalLabCost(BigDecimal ntotalLabCost) {
		this.ntotalLabCost = ntotalLabCost;
	}

	@Column(name = "NSUM_COSTS", precision = 12, scale = 4)
	public BigDecimal getNsumCosts() {
		return this.nsumCosts;
	}

	public void setNsumCosts(BigDecimal nsumCosts) {
		this.nsumCosts = nsumCosts;
	}

	@Column(name = "NSUM_MARKUP_P", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupP() {
		return this.nsumMarkupP;
	}

	public void setNsumMarkupP(BigDecimal nsumMarkupP) {
		this.nsumMarkupP = nsumMarkupP;
	}

	@Column(name = "NSUM_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupV() {
		return this.nsumMarkupV;
	}

	public void setNsumMarkupV(BigDecimal nsumMarkupV) {
		this.nsumMarkupV = nsumMarkupV;
	}

	@Column(name = "NDISCOUNT", precision = 5)
	public BigDecimal getNdiscount() {
		return this.ndiscount;
	}

	public void setNdiscount(BigDecimal ndiscount) {
		this.ndiscount = ndiscount;
	}

	@Column(name = "NDISCOUNTEDSALESPRICE", precision = 12)
	public BigDecimal getNdiscountedsalesprice() {
		return this.ndiscountedsalesprice;
	}

	public void setNdiscountedsalesprice(BigDecimal ndiscountedsalesprice) {
		this.ndiscountedsalesprice = ndiscountedsalesprice;
	}

	@Column(name = "NAVERAGEGROUPPRICE", precision = 12)
	public BigDecimal getNaveragegroupprice() {
		return this.naveragegroupprice;
	}

	public void setNaveragegroupprice(BigDecimal naveragegroupprice) {
		this.naveragegroupprice = naveragegroupprice;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP_AVERAGE_CALC", length = 7)
	public Date getDstampAverageCalc() {
		return this.dstampAverageCalc;
	}

	public void setDstampAverageCalc(Date dstampAverageCalc) {
		this.dstampAverageCalc = dstampAverageCalc;
	}

	@Column(name = "NAVG_PRICE_FLAG", nullable = false, precision = 1, scale = 0)
	public int getNavgPriceFlag() {
		return this.navgPriceFlag;
	}

	public void setNavgPriceFlag(int navgPriceFlag) {
		this.navgPriceFlag = navgPriceFlag;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Column(name = "NOVERHEAD_MARKUP_P", nullable = false, precision = 12, scale = 4)
	public BigDecimal getNoverheadMarkupP() {
		return this.noverheadMarkupP;
	}

	public void setNoverheadMarkupP(BigDecimal noverheadMarkupP) {
		this.noverheadMarkupP = noverheadMarkupP;
	}

	@Column(name = "NSUM_OVERHEAD", precision = 12, scale = 4)
	public BigDecimal getNsumOverhead() {
		return this.nsumOverhead;
	}

	public void setNsumOverhead(BigDecimal nsumOverhead) {
		this.nsumOverhead = nsumOverhead;
	}

	@Column(name = "CCOMMENT", length = 50)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NSKYSCOPE_DISCOUNT", precision = 6, scale = 3)
	public BigDecimal getNskyscopeDiscount() {
		return this.nskyscopeDiscount;
	}

	public void setNskyscopeDiscount(BigDecimal nskyscopeDiscount) {
		this.nskyscopeDiscount = nskyscopeDiscount;
	}

	@Column(name = "NMARKUPINDIRECT_P", nullable = false, precision = 9, scale = 3)
	public BigDecimal getNmarkupindirectP() {
		return this.nmarkupindirectP;
	}

	public void setNmarkupindirectP(BigDecimal nmarkupindirectP) {
		this.nmarkupindirectP = nmarkupindirectP;
	}

	@Column(name = "NSUM_MARKUPINDIRECT", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupindirect() {
		return this.nsumMarkupindirect;
	}

	public void setNsumMarkupindirect(BigDecimal nsumMarkupindirect) {
		this.nsumMarkupindirect = nsumMarkupindirect;
	}

	@Column(name = "NMARKUPSGA_P", nullable = false, precision = 9, scale = 3)
	public BigDecimal getNmarkupsgaP() {
		return this.nmarkupsgaP;
	}

	public void setNmarkupsgaP(BigDecimal nmarkupsgaP) {
		this.nmarkupsgaP = nmarkupsgaP;
	}

	@Column(name = "NSUM_MARKUPSGA", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupsga() {
		return this.nsumMarkupsga;
	}

	public void setNsumMarkupsga(BigDecimal nsumMarkupsga) {
		this.nsumMarkupsga = nsumMarkupsga;
	}

	@Column(name = "NMARKUPDB2_P", nullable = false, precision = 9, scale = 3)
	public BigDecimal getNmarkupdb2P() {
		return this.nmarkupdb2P;
	}

	public void setNmarkupdb2P(BigDecimal nmarkupdb2P) {
		this.nmarkupdb2P = nmarkupdb2P;
	}

	@Column(name = "NSUM_MARKUPDB2", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupdb2() {
		return this.nsumMarkupdb2;
	}

	public void setNsumMarkupdb2(BigDecimal nsumMarkupdb2) {
		this.nsumMarkupdb2 = nsumMarkupdb2;
	}

}


