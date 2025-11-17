package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.10.2022 09:36:43 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_SPML_HISTORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_SPML_HISTORY"
)
public class CenOutSpmlHistory implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutSpmlHistoryId id;
	private CenOutHistory cenOutHistory;
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
	private Integer nlocalSub;
	private String cproductionText;
	private Integer nptManual;
	private Set<CenOutSpmlDetailHistory> cenOutSpmlDetailHistories = new HashSet<>(0);

	public CenOutSpmlHistory() {
	}

	public CenOutSpmlHistory(final CenOutSpmlHistoryId id, final CenOutHistory cenOutHistory, final long nclassNumber, final String cclass, final int nprio,
			final long nspmlKey, final String cspml, final BigDecimal nquantity, final BigDecimal nquantityOld, final int nmanualInput, final int ndeduction, final Date dtimestamp,
			final int nstatus) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nprio = nprio;
		this.nspmlKey = nspmlKey;
		this.cspml = cspml;
		this.nquantity = nquantity;
		this.nquantityOld = nquantityOld;
		this.nmanualInput = nmanualInput;
		this.ndeduction = ndeduction;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
	}

	public CenOutSpmlHistory(final CenOutSpmlHistoryId id, final CenOutHistory cenOutHistory, final long nclassNumber, final String cclass, final int nprio,
			final long nspmlKey, final String cspml, final String cname, final String caddText, final String cremark, final BigDecimal nquantity, final BigDecimal nquantityOld,
			final int nmanualInput, final int ndeduction, final Date dtimestamp, final int nstatus, final String cdescription, final Integer ntopoff, final Integer nstationentry,
			final String cseat, final Integer nlocalSub, final String cproductionText, final Integer nptManual,
			final Set<CenOutSpmlDetailHistory> cenOutSpmlDetailHistories) {
		this.id = id;
		this.cenOutHistory = cenOutHistory;
		this.nclassNumber = nclassNumber;
		this.cclass = cclass;
		this.nprio = nprio;
		this.nspmlKey = nspmlKey;
		this.cspml = cspml;
		this.cname = cname;
		this.caddText = caddText;
		this.cremark = cremark;
		this.nquantity = nquantity;
		this.nquantityOld = nquantityOld;
		this.nmanualInput = nmanualInput;
		this.ndeduction = ndeduction;
		this.dtimestamp = dtimestamp;
		this.nstatus = nstatus;
		this.cdescription = cdescription;
		this.ntopoff = ntopoff;
		this.nstationentry = nstationentry;
		this.cseat = cseat;
		this.nlocalSub = nlocalSub;
		this.cproductionText = cproductionText;
		this.nptManual = nptManual;
		this.cenOutSpmlDetailHistories = cenOutSpmlDetailHistories;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nmasterKey", column = @Column(name = "NMASTER_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)) })
	public CenOutSpmlHistoryId getId() {
		return this.id;
	}

	public void setId(final CenOutSpmlHistoryId id) {
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

	@Column(name = "NLOCAL_SUB", precision = 1, scale = 0)
	public Integer getNlocalSub() {
		return this.nlocalSub;
	}

	public void setNlocalSub(final Integer nlocalSub) {
		this.nlocalSub = nlocalSub;
	}

	@Column(name = "CPRODUCTION_TEXT", length = 40)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(final String cproductionText) {
		this.cproductionText = cproductionText;
	}

	@Column(name = "NPT_MANUAL", precision = 1, scale = 0)
	public Integer getNptManual() {
		return this.nptManual;
	}

	public void setNptManual(final Integer nptManual) {
		this.nptManual = nptManual;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenOutSpmlHistory")
	public Set<CenOutSpmlDetailHistory> getCenOutSpmlDetailHistories() {
		return this.cenOutSpmlDetailHistories;
	}

	public void setCenOutSpmlDetailHistories(final Set<CenOutSpmlDetailHistory> cenOutSpmlDetailHistories) {
		this.cenOutSpmlDetailHistories = cenOutSpmlDetailHistories;
	}

}


