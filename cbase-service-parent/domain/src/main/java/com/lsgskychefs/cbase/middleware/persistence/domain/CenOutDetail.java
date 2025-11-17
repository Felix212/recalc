package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DETAIL")
public class CenOutDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private long ndetailKey;
	private long ntransaction;
	private int nplType;
	private long nplIndexKey;
	private long nplDetailKey;
	private long nitemIndexKey;
	private long nitemDetailKey;
	private String citemPl;
	private String citemText;
	private String citemAddOnText;
	private String cunit;
	private BigDecimal nquantity;
	private int nsort;
	private Date dtimestamp;
	private int nstatus;
	private int nfreqKey;
	private Long nreckoning;
	private Long nmaterialIndexKey;
	private String ccustomerPl;
	private String ccustomerPlText;
	private String citemTextShort;
	private String csalesRel;
	private String cgoodsRecipient;

	public CenOutDetail() {
	}

	public CenOutDetail(final long ndetailKey, final long ntransaction, final int nplType, final long nplIndexKey, final long nplDetailKey,
			final long nitemIndexKey, final long nitemDetailKey, final String citemPl, final String citemText, final BigDecimal nquantity,
			final int nsort, final Date dtimestamp, final int nstatus, final int nfreqKey) {
		this.ndetailKey = ndetailKey;
		this.ntransaction = ntransaction;
		this.nplType = nplType;
		this.nplIndexKey = nplIndexKey;
		this.nplDetailKey = nplDetailKey;
		this.nitemIndexKey = nitemIndexKey;
		this.nitemDetailKey = nitemDetailKey;
		this.citemPl = citemPl;
		this.citemText = citemText;
		this.nquantity = nquantity;
		this.nsort = nsort;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.nfreqKey = nfreqKey;
	}

	public CenOutDetail(final long ndetailKey, final long ntransaction, final int nplType, final long nplIndexKey, final long nplDetailKey,
			final long nitemIndexKey, final long nitemDetailKey, final String citemPl, final String citemText, final String citemAddOnText,
			final String cunit, final BigDecimal nquantity, final int nsort, final Date dtimestamp, final int nstatus, final int nfreqKey,
			final Long nreckoning, final Long nmaterialIndexKey, final String ccustomerPl, final String ccustomerPlText,
			final String citemTextShort, final String csalesRel, final String cgoodsRecipient) {
		this.ndetailKey = ndetailKey;
		this.ntransaction = ntransaction;
		this.nplType = nplType;
		this.nplIndexKey = nplIndexKey;
		this.nplDetailKey = nplDetailKey;
		this.nitemIndexKey = nitemIndexKey;
		this.nitemDetailKey = nitemDetailKey;
		this.citemPl = citemPl;
		this.citemText = citemText;
		this.citemAddOnText = citemAddOnText;
		this.cunit = cunit;
		this.nquantity = nquantity;
		this.nsort = nsort;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.nfreqKey = nfreqKey;
		this.nreckoning = nreckoning;
		this.nmaterialIndexKey = nmaterialIndexKey;
		this.ccustomerPl = ccustomerPl;
		this.ccustomerPlText = ccustomerPlText;
		this.citemTextShort = citemTextShort;
		this.csalesRel = csalesRel;
		this.cgoodsRecipient = cgoodsRecipient;
	}

	@Id

	@Column(name = "NDETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(final long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NPL_TYPE", nullable = false, precision = 6, scale = 0)
	public int getNplType() {
		return this.nplType;
	}

	public void setNplType(final int nplType) {
		this.nplType = nplType;
	}

	@Column(name = "NPL_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "NPL_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNplDetailKey() {
		return this.nplDetailKey;
	}

	public void setNplDetailKey(final long nplDetailKey) {
		this.nplDetailKey = nplDetailKey;
	}

	@Column(name = "NITEM_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNitemIndexKey() {
		return this.nitemIndexKey;
	}

	public void setNitemIndexKey(final long nitemIndexKey) {
		this.nitemIndexKey = nitemIndexKey;
	}

	@Column(name = "NITEM_DETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNitemDetailKey() {
		return this.nitemDetailKey;
	}

	public void setNitemDetailKey(final long nitemDetailKey) {
		this.nitemDetailKey = nitemDetailKey;
	}

	@Column(name = "CITEM_PL", nullable = false, length = 18)
	public String getCitemPl() {
		return this.citemPl;
	}

	public void setCitemPl(final String citemPl) {
		this.citemPl = citemPl;
	}

	@Column(name = "CITEM_TEXT", nullable = false, length = 40)
	public String getCitemText() {
		return this.citemText;
	}

	public void setCitemText(final String citemText) {
		this.citemText = citemText;
	}

	@Column(name = "CITEM_ADD_ON_TEXT", length = 40)
	public String getCitemAddOnText() {
		return this.citemAddOnText;
	}

	public void setCitemAddOnText(final String citemAddOnText) {
		this.citemAddOnText = citemAddOnText;
	}

	@Column(name = "CUNIT", length = 5)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 15, scale = 6)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NSORT", nullable = false, precision = 6, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
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

	@Column(name = "NFREQ_KEY", nullable = false, precision = 1, scale = 0)
	public int getNfreqKey() {
		return this.nfreqKey;
	}

	public void setNfreqKey(final int nfreqKey) {
		this.nfreqKey = nfreqKey;
	}

	@Column(name = "NRECKONING", precision = 12, scale = 0)
	public Long getNreckoning() {
		return this.nreckoning;
	}

	public void setNreckoning(final Long nreckoning) {
		this.nreckoning = nreckoning;
	}

	@Column(name = "NMATERIAL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNmaterialIndexKey() {
		return this.nmaterialIndexKey;
	}

	public void setNmaterialIndexKey(final Long nmaterialIndexKey) {
		this.nmaterialIndexKey = nmaterialIndexKey;
	}

	@Column(name = "CCUSTOMER_PL", length = 18)
	public String getCcustomerPl() {
		return this.ccustomerPl;
	}

	public void setCcustomerPl(final String ccustomerPl) {
		this.ccustomerPl = ccustomerPl;
	}

	@Column(name = "CCUSTOMER_PL_TEXT", length = 40)
	public String getCcustomerPlText() {
		return this.ccustomerPlText;
	}

	public void setCcustomerPlText(final String ccustomerPlText) {
		this.ccustomerPlText = ccustomerPlText;
	}

	@Column(name = "CITEM_TEXT_SHORT", length = 170)
	public String getCitemTextShort() {
		return this.citemTextShort;
	}

	public void setCitemTextShort(final String citemTextShort) {
		this.citemTextShort = citemTextShort;
	}

	@Column(name = "CSALES_REL", length = 1)
	public String getCsalesRel() {
		return this.csalesRel;
	}

	public void setCsalesRel(final String csalesRel) {
		this.csalesRel = csalesRel;
	}

	@Column(name = "CGOODS_RECIPIENT", length = 10)
	public String getCgoodsRecipient() {
		return this.cgoodsRecipient;
	}

	public void setCgoodsRecipient(final String cgoodsRecipient) {
		this.cgoodsRecipient = cgoodsRecipient;
	}

}
