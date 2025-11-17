package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 21.11.2019 09:57:44 by Hibernate Tools 4.3.5.Final

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_HISTORY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_HISTORY")
public class CenOutPpmHistory implements DomainObject, Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmhistKey;

	private long nresultKey;

	private Date dtimestamp;

	private String cuser;

	private long ntransaction;

	private Long nppmDetailKey;

	private Long nplIndexKey;

	private String cpackinglist;

	private Long nbatchSeq;

	private BigDecimal nquantityProd;

	private String cdescription;

	private String cdescription2;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_HISTORY")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_HISTORY", sequenceName = "SEQ_CEN_OUT_PPM_HISTORY", allocationSize = 1)
	@Column(name = "NPPMHIST_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmhistKey() {
		return this.nppmhistKey;
	}

	public void setNppmhistKey(final long nppmhistKey) {
		this.nppmhistKey = nppmhistKey;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "DTIMESTAMP", nullable = false)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "CUSER", nullable = false, length = 100)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "NPPM_DETAIL_KEY", precision = 12, scale = 0)
	public Long getNppmDetailKey() {
		return this.nppmDetailKey;
	}

	public void setNppmDetailKey(final Long nppmDetailKey) {
		this.nppmDetailKey = nppmDetailKey;
	}

	@Column(name = "NPL_INDEX_KEY", precision = 12, scale = 0)
	public Long getNplIndexKey() {
		return this.nplIndexKey;
	}

	public void setNplIndexKey(final Long nplIndexKey) {
		this.nplIndexKey = nplIndexKey;
	}

	@Column(name = "CPACKINGLIST", length = 30)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Column(name = "NBATCH_SEQ", precision = 12, scale = 0)
	public Long getNbatchSeq() {
		return this.nbatchSeq;
	}

	public void setNbatchSeq(final Long nbatchSeq) {
		this.nbatchSeq = nbatchSeq;
	}

	@Column(name = "NQUANTITY_PROD", precision = 15, scale = 3)
	public BigDecimal getNquantityProd() {
		return this.nquantityProd;
	}

	public void setNquantityProd(final BigDecimal nquantityProd) {
		this.nquantityProd = nquantityProd;
	}

	@Column(name = "CDESCRIPTION", length = 1000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CDESCRIPTION2", length = 1000)
	public String getCdescription2() {
		return this.cdescription2;
	}

	public void setCdescription2(final String cdescription2) {
		this.cdescription2 = cdescription2;
	}

}
