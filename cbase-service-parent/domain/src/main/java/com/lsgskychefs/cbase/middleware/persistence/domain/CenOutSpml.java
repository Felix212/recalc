package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.02.2016 17:57:05 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_SPML (special meal)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML")
public class CenOutSpml implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmasterKey;
	private CenOut cenOut;
	private long nresultKey;
	private long ntransaction;
	private long nclassNumber;
	private String cclass;
	private int nprio;
	private long nspmlKey;
	private String cspml;
	private String cname;
	private String caddText;
	private String cremark;
	private BigDecimal nquantity;
	private BigDecimal nquantityOld;
	private int nmanualInput;
	private int ndeduction;
	private Date dtimestamp;
	private int nstatus;
	private String cdescription;
	private Integer ntopoff;
	private Integer nstationentry;
	private String cseat;
	private int nlocalSub;
	private String cproductionText;
	private int nptManual;
	private Set<CenOutSpmlDetail> cenOutSpmlDetails = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_SPML")
	@SequenceGenerator(name = "SEQ_CEN_OUT_SPML", sequenceName = "SEQ_CEN_OUT_SPML", allocationSize = 1)
	@Column(name = "NMASTER_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmasterKey() {
		return this.nmasterKey;
	}

	public void setNmasterKey(final long nmasterKey) {
		this.nmasterKey = nmasterKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
		this.nresultKey = cenOut.getNresultKey();
	}

	/**
	 * Get nresultKey
	 *
	 * @return the nresultKey
	 */
	@Column(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public long getNresultKey() {
		return nresultKey;
	}

	/**
	 * set nresultKey
	 *
	 * @param nresultKey the nresultKey to set
	 */
	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)
	public long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final long ntransaction) {
		this.ntransaction = ntransaction;
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

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(final int nprio) {
		this.nprio = nprio;
	}

	@Column(name = "NSPML_KEY", nullable = false, precision = 12, scale = 0)
	public long getNspmlKey() {
		return this.nspmlKey;
	}

	public void setNspmlKey(final long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	@Column(name = "CSPML", nullable = false, length = 10)
	public String getCspml() {
		return this.cspml;
	}

	public void setCspml(final String cspml) {
		this.cspml = cspml;
	}

	@Column(name = "CNAME", length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CADD_TEXT", length = 40)
	public String getCaddText() {
		return this.caddText;
	}

	public void setCaddText(final String caddText) {
		this.caddText = caddText;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(final String cremark) {
		this.cremark = cremark;
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

	@Column(name = "NDEDUCTION", nullable = false, precision = 1, scale = 0)
	public int getNdeduction() {
		return this.ndeduction;
	}

	public void setNdeduction(final int ndeduction) {
		this.ndeduction = ndeduction;
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

	@Column(name = "NTOPOFF", precision = 1, scale = 0)
	public Integer getNtopoff() {
		return this.ntopoff;
	}

	public void setNtopoff(final Integer ntopoff) {
		this.ntopoff = ntopoff;
	}

	@Column(name = "NSTATIONENTRY", precision = 1, scale = 0)
	public Integer getNstationentry() {
		return this.nstationentry;
	}

	public void setNstationentry(final Integer nstationentry) {
		this.nstationentry = nstationentry;
	}

	@Column(name = "CSEAT", length = 40)
	public String getCseat() {
		return this.cseat;
	}

	public void setCseat(final String cseat) {
		this.cseat = cseat;
	}

	@Column(name = "NLOCAL_SUB", nullable = false, precision = 1, scale = 0)
	public int getNlocalSub() {
		return this.nlocalSub;
	}

	public void setNlocalSub(final int nlocalSub) {
		this.nlocalSub = nlocalSub;
	}

	public String getCproductionText() {
		return cproductionText;
	}

	public void setCproductionText(String cproductionText) {
		this.cproductionText = cproductionText;
	}

	public int getNptManual() {
		return nptManual;
	}

	public void setNptManual(int nptManual) {
		this.nptManual = nptManual;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutSpml")
	public Set<CenOutSpmlDetail> getCenOutSpmlDetails() {
		return this.cenOutSpmlDetails;
	}

	public void setCenOutSpmlDetails(final Set<CenOutSpmlDetail> cenOutSpmlDetails) {
		this.cenOutSpmlDetails = cenOutSpmlDetails;
	}

}
