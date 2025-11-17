package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
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
 * Entity(DomainObject) for table CEN_OUT_HANDLING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_HANDLING")
public class CenOutHandling implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutHandlingId id;
	private CenOut cenOut;
	private long ntransaction;
	private String cloadinglist;
	private int nprio;
	private String ctext;
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private Long naccountKey;
	private String caccount;
	private Long nhandlingKey;
	private Integer npostingType;
	private BigDecimal nsalesPrice;
	private Integer nquantity;
	private Long nsysaccountKey;
	private String ccode;
	private BigDecimal nremittanceprice;
	private BigDecimal ndiscount;
	private BigDecimal nportfee;
	private BigDecimal nvatValue;
	private Long ninvoiceCycleKey;
	private Integer nmanualInput;
	private BigDecimal ncostPrice;
	private Integer ninvoiceStatus;
	private Integer nsalesPriceModified;
	private Long npriceCalcType;
	private Long ncosttype;
	private String ctaxcode;
	private BigDecimal nbillingPrice;
	private Integer nreleaseExclusion;
	private BigDecimal nvatValuePortfee;
	private Long nvatKey;
	private Long nvatKeyPortfee;
	private String cadditionalAccount;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nhandlingId", column = @Column(name = "NHANDLING_ID", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nloadinglistIndexKey",
					column = @Column(name = "NLOADINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutHandlingId getId() {
		return this.id;
	}

	public void setId(final CenOutHandlingId id) {
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

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CLOADINGLIST", nullable = false, length = 18)
	public String getCloadinglist() {
		return this.cloadinglist;
	}

	public void setCloadinglist(final String cloadinglist) {
		this.cloadinglist = cloadinglist;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "CTEXT", length = 40)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
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

	@Column(name = "NHANDLING_KEY", precision = 12, scale = 0)
	public Long getNhandlingKey() {
		return this.nhandlingKey;
	}

	public void setNhandlingKey(final Long nhandlingKey) {
		this.nhandlingKey = nhandlingKey;
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

	@Column(name = "NQUANTITY", precision = 1, scale = 0)
	public Integer getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final Integer nquantity) {
		this.nquantity = nquantity;
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

	@Column(name = "NMANUAL_INPUT", precision = 1, scale = 0)
	public Integer getNmanualInput() {
		return this.nmanualInput;
	}

	public void setNmanualInput(final Integer nmanualInput) {
		this.nmanualInput = nmanualInput;
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

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(final String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
	}

}
