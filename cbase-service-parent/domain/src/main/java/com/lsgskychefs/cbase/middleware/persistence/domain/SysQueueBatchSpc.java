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

/**
 * Entity(DomainObject) for table SYS_QUEUE_BATCH_SPC
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_BATCH_SPC")
public class SysQueueBatchSpc implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private SysQueueBatchSpcId id;
	private SysQueueBatch sysQueueBatch;
	private Date dvalidTo;
	private BigDecimal ncalcSalesprice;
	private BigDecimal nsalesprice;
	private BigDecimal nremittanceprice;
	private BigDecimal nbillingPrice;
	private BigDecimal ndiscountedsalesprice;
	private BigDecimal naveragegroupprice;
	private BigDecimal ncostPrice;
	private BigDecimal nmatCosts;
	private BigDecimal nlabourCosts;
	private BigDecimal nmatMarkupV;
	private BigDecimal nmatMarkupP;
	private BigDecimal ntotalMatCost;
	private BigDecimal nlabMarkupV;
	private BigDecimal nlabMarkupP;
	private BigDecimal ntotalLabCost;
	private BigDecimal nsumMarkupV;
	private BigDecimal nsumMarkupP;
	private BigDecimal nsumCosts;
	private BigDecimal noverheadMarkupP;
	private BigDecimal nsumOverhead;
	private Integer nuseSellRate;
	private Long npriceCalcTypeKey;
	private BigDecimal ndiscount;
	private BigDecimal nseconds;
	private Integer nmodified;
	private Date dstamp;
	private Date dstampCosting;
	private Date dstampAverageCalc;
	private Long nsysaccountKey;
	private int nprocessStatus;

	public SysQueueBatchSpc() {
	}

	public SysQueueBatchSpc(final SysQueueBatchSpcId id, final SysQueueBatch sysQueueBatch, final Date dvalidTo,
			final BigDecimal nsalesprice, final BigDecimal nremittanceprice, final BigDecimal nbillingPrice, final BigDecimal ncostPrice,
			final BigDecimal ndiscount, final int nprocessStatus) {
		this.id = id;
		this.sysQueueBatch = sysQueueBatch;
		this.dvalidTo = dvalidTo;
		this.nsalesprice = nsalesprice;
		this.nremittanceprice = nremittanceprice;
		this.nbillingPrice = nbillingPrice;
		this.ncostPrice = ncostPrice;
		this.ndiscount = ndiscount;
		this.nprocessStatus = nprocessStatus;
	}

	public SysQueueBatchSpc(final SysQueueBatchSpcId id, final SysQueueBatch sysQueueBatch, final Date dvalidTo,
			final BigDecimal ncalcSalesprice, final BigDecimal nsalesprice, final BigDecimal nremittanceprice,
			final BigDecimal nbillingPrice, final BigDecimal ndiscountedsalesprice, final BigDecimal naveragegroupprice,
			final BigDecimal ncostPrice, final BigDecimal nmatCosts, final BigDecimal nlabourCosts, final BigDecimal nmatMarkupV,
			final BigDecimal nmatMarkupP, final BigDecimal ntotalMatCost, final BigDecimal nlabMarkupV, final BigDecimal nlabMarkupP,
			final BigDecimal ntotalLabCost, final BigDecimal nsumMarkupV, final BigDecimal nsumMarkupP, final BigDecimal nsumCosts,
			final BigDecimal noverheadMarkupP, final BigDecimal nsumOverhead, final Integer nuseSellRate, final Long npriceCalcTypeKey,
			final BigDecimal ndiscount, final BigDecimal nseconds, final Integer nmodified, final Date dstamp, final Date dstampCosting,
			final Date dstampAverageCalc, final Long nsysaccountKey, final int nprocessStatus) {
		this.id = id;
		this.sysQueueBatch = sysQueueBatch;
		this.dvalidTo = dvalidTo;
		this.ncalcSalesprice = ncalcSalesprice;
		this.nsalesprice = nsalesprice;
		this.nremittanceprice = nremittanceprice;
		this.nbillingPrice = nbillingPrice;
		this.ndiscountedsalesprice = ndiscountedsalesprice;
		this.naveragegroupprice = naveragegroupprice;
		this.ncostPrice = ncostPrice;
		this.nmatCosts = nmatCosts;
		this.nlabourCosts = nlabourCosts;
		this.nmatMarkupV = nmatMarkupV;
		this.nmatMarkupP = nmatMarkupP;
		this.ntotalMatCost = ntotalMatCost;
		this.nlabMarkupV = nlabMarkupV;
		this.nlabMarkupP = nlabMarkupP;
		this.ntotalLabCost = ntotalLabCost;
		this.nsumMarkupV = nsumMarkupV;
		this.nsumMarkupP = nsumMarkupP;
		this.nsumCosts = nsumCosts;
		this.noverheadMarkupP = noverheadMarkupP;
		this.nsumOverhead = nsumOverhead;
		this.nuseSellRate = nuseSellRate;
		this.npriceCalcTypeKey = npriceCalcTypeKey;
		this.ndiscount = ndiscount;
		this.nseconds = nseconds;
		this.nmodified = nmodified;
		this.dstamp = dstamp;
		this.dstampCosting = dstampCosting;
		this.dstampAverageCalc = dstampAverageCalc;
		this.nsysaccountKey = nsysaccountKey;
		this.nprocessStatus = nprocessStatus;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "njobNr", column = @Column(name = "NJOB_NR", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "npackinglistIndexKey",
					column = @Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public SysQueueBatchSpcId getId() {
		return this.id;
	}

	public void setId(final SysQueueBatchSpcId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false, insertable = false, updatable = false)
	public SysQueueBatch getSysQueueBatch() {
		return this.sysQueueBatch;
	}

	public void setSysQueueBatch(final SysQueueBatch sysQueueBatch) {
		this.sysQueueBatch = sysQueueBatch;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NCALC_SALESPRICE", precision = 12, scale = 4)
	public BigDecimal getNcalcSalesprice() {
		return this.ncalcSalesprice;
	}

	public void setNcalcSalesprice(final BigDecimal ncalcSalesprice) {
		this.ncalcSalesprice = ncalcSalesprice;
	}

	@Column(name = "NSALESPRICE", nullable = false, precision = 12)
	public BigDecimal getNsalesprice() {
		return this.nsalesprice;
	}

	public void setNsalesprice(final BigDecimal nsalesprice) {
		this.nsalesprice = nsalesprice;
	}

	@Column(name = "NREMITTANCEPRICE", nullable = false, precision = 12)
	public BigDecimal getNremittanceprice() {
		return this.nremittanceprice;
	}

	public void setNremittanceprice(final BigDecimal nremittanceprice) {
		this.nremittanceprice = nremittanceprice;
	}

	@Column(name = "NBILLING_PRICE", nullable = false, precision = 12, scale = 4)
	public BigDecimal getNbillingPrice() {
		return this.nbillingPrice;
	}

	public void setNbillingPrice(final BigDecimal nbillingPrice) {
		this.nbillingPrice = nbillingPrice;
	}

	@Column(name = "NDISCOUNTEDSALESPRICE", precision = 12)
	public BigDecimal getNdiscountedsalesprice() {
		return this.ndiscountedsalesprice;
	}

	public void setNdiscountedsalesprice(final BigDecimal ndiscountedsalesprice) {
		this.ndiscountedsalesprice = ndiscountedsalesprice;
	}

	@Column(name = "NAVERAGEGROUPPRICE", precision = 12)
	public BigDecimal getNaveragegroupprice() {
		return this.naveragegroupprice;
	}

	public void setNaveragegroupprice(final BigDecimal naveragegroupprice) {
		this.naveragegroupprice = naveragegroupprice;
	}

	@Column(name = "NCOST_PRICE", nullable = false, precision = 12, scale = 4)
	public BigDecimal getNcostPrice() {
		return this.ncostPrice;
	}

	public void setNcostPrice(final BigDecimal ncostPrice) {
		this.ncostPrice = ncostPrice;
	}

	@Column(name = "NMAT_COSTS", precision = 12, scale = 4)
	public BigDecimal getNmatCosts() {
		return this.nmatCosts;
	}

	public void setNmatCosts(final BigDecimal nmatCosts) {
		this.nmatCosts = nmatCosts;
	}

	@Column(name = "NLABOUR_COSTS", precision = 12, scale = 4)
	public BigDecimal getNlabourCosts() {
		return this.nlabourCosts;
	}

	public void setNlabourCosts(final BigDecimal nlabourCosts) {
		this.nlabourCosts = nlabourCosts;
	}

	@Column(name = "NMAT_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNmatMarkupV() {
		return this.nmatMarkupV;
	}

	public void setNmatMarkupV(final BigDecimal nmatMarkupV) {
		this.nmatMarkupV = nmatMarkupV;
	}

	@Column(name = "NMAT_MARKUP_P", precision = 8)
	public BigDecimal getNmatMarkupP() {
		return this.nmatMarkupP;
	}

	public void setNmatMarkupP(final BigDecimal nmatMarkupP) {
		this.nmatMarkupP = nmatMarkupP;
	}

	@Column(name = "NTOTAL_MAT_COST", precision = 12, scale = 4)
	public BigDecimal getNtotalMatCost() {
		return this.ntotalMatCost;
	}

	public void setNtotalMatCost(final BigDecimal ntotalMatCost) {
		this.ntotalMatCost = ntotalMatCost;
	}

	@Column(name = "NLAB_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNlabMarkupV() {
		return this.nlabMarkupV;
	}

	public void setNlabMarkupV(final BigDecimal nlabMarkupV) {
		this.nlabMarkupV = nlabMarkupV;
	}

	@Column(name = "NLAB_MARKUP_P", precision = 8)
	public BigDecimal getNlabMarkupP() {
		return this.nlabMarkupP;
	}

	public void setNlabMarkupP(final BigDecimal nlabMarkupP) {
		this.nlabMarkupP = nlabMarkupP;
	}

	@Column(name = "NTOTAL_LAB_COST", precision = 12, scale = 4)
	public BigDecimal getNtotalLabCost() {
		return this.ntotalLabCost;
	}

	public void setNtotalLabCost(final BigDecimal ntotalLabCost) {
		this.ntotalLabCost = ntotalLabCost;
	}

	@Column(name = "NSUM_MARKUP_V", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupV() {
		return this.nsumMarkupV;
	}

	public void setNsumMarkupV(final BigDecimal nsumMarkupV) {
		this.nsumMarkupV = nsumMarkupV;
	}

	@Column(name = "NSUM_MARKUP_P", precision = 12, scale = 4)
	public BigDecimal getNsumMarkupP() {
		return this.nsumMarkupP;
	}

	public void setNsumMarkupP(final BigDecimal nsumMarkupP) {
		this.nsumMarkupP = nsumMarkupP;
	}

	@Column(name = "NSUM_COSTS", precision = 12, scale = 4)
	public BigDecimal getNsumCosts() {
		return this.nsumCosts;
	}

	public void setNsumCosts(final BigDecimal nsumCosts) {
		this.nsumCosts = nsumCosts;
	}

	@Column(name = "NOVERHEAD_MARKUP_P", precision = 12, scale = 4)
	public BigDecimal getNoverheadMarkupP() {
		return this.noverheadMarkupP;
	}

	public void setNoverheadMarkupP(final BigDecimal noverheadMarkupP) {
		this.noverheadMarkupP = noverheadMarkupP;
	}

	@Column(name = "NSUM_OVERHEAD", precision = 12, scale = 4)
	public BigDecimal getNsumOverhead() {
		return this.nsumOverhead;
	}

	public void setNsumOverhead(final BigDecimal nsumOverhead) {
		this.nsumOverhead = nsumOverhead;
	}

	@Column(name = "NUSE_SELL_RATE", precision = 1, scale = 0)
	public Integer getNuseSellRate() {
		return this.nuseSellRate;
	}

	public void setNuseSellRate(final Integer nuseSellRate) {
		this.nuseSellRate = nuseSellRate;
	}

	@Column(name = "NPRICE_CALC_TYPE_KEY", precision = 12, scale = 0)
	public Long getNpriceCalcTypeKey() {
		return this.npriceCalcTypeKey;
	}

	public void setNpriceCalcTypeKey(final Long npriceCalcTypeKey) {
		this.npriceCalcTypeKey = npriceCalcTypeKey;
	}

	@Column(name = "NDISCOUNT", nullable = false, precision = 5)
	public BigDecimal getNdiscount() {
		return this.ndiscount;
	}

	public void setNdiscount(final BigDecimal ndiscount) {
		this.ndiscount = ndiscount;
	}

	@Column(name = "NSECONDS", precision = 8)
	public BigDecimal getNseconds() {
		return this.nseconds;
	}

	public void setNseconds(final BigDecimal nseconds) {
		this.nseconds = nseconds;
	}

	@Column(name = "NMODIFIED", precision = 1, scale = 0)
	public Integer getNmodified() {
		return this.nmodified;
	}

	public void setNmodified(final Integer nmodified) {
		this.nmodified = nmodified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP", length = 7)
	public Date getDstamp() {
		return this.dstamp;
	}

	public void setDstamp(final Date dstamp) {
		this.dstamp = dstamp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP_COSTING", length = 7)
	public Date getDstampCosting() {
		return this.dstampCosting;
	}

	public void setDstampCosting(final Date dstampCosting) {
		this.dstampCosting = dstampCosting;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTAMP_AVERAGE_CALC", length = 7)
	public Date getDstampAverageCalc() {
		return this.dstampAverageCalc;
	}

	public void setDstampAverageCalc(final Date dstampAverageCalc) {
		this.dstampAverageCalc = dstampAverageCalc;
	}

	@Column(name = "NSYSACCOUNT_KEY", precision = 12, scale = 0)
	public Long getNsysaccountKey() {
		return this.nsysaccountKey;
	}

	public void setNsysaccountKey(final Long nsysaccountKey) {
		this.nsysaccountKey = nsysaccountKey;
	}

	@Column(name = "NPROCESS_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

}
