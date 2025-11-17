package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.09.2022 09:54:55 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_SPML_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SPML_DETAIL"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "NHANDLING_SPML_KEY", "NROTATION_NAME_KEY", "NSPML_KEY",
		"NPACKINGLIST_INDEX_KEY" })
)
public class CenSpmlDetail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingSpmlDetailKey;
	private CenSpml cenSpml;
	private long nspmlKey;
	private long nairlineKey;
	private long nrotationNameKey;
	private int nprio;
	private Date dvalidFrom;
	private Date dvalidTo;
	private BigDecimal nquantity;
	private int ndeduction;
	private long npackinglistIndexKey;
	private String cproductionText;
	private String cremark;
	private long naccountKey;
	private int nbillingStatus;
	private int nacTransfer;
	private String cadditionalAccount;
	private Integer ndistribute;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private int nreplacetext;
	private int nactivate;
	private String cdescription;
	private SysSpml sysSpml;

	@Id
	@Column(name = "NHANDLING_SPML_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingSpmlDetailKey() {
		return this.nhandlingSpmlDetailKey;
	}

	public void setNhandlingSpmlDetailKey(long nhandlingSpmlDetailKey) {
		this.nhandlingSpmlDetailKey = nhandlingSpmlDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_SPML_KEY", nullable = false)
	public CenSpml getCenSpml() {
		return this.cenSpml;
	}

	public void setCenSpml(CenSpml cenSpml) {
		this.cenSpml = cenSpml;
	}

	@Column(name = "NSPML_KEY", nullable = false, precision = 12, scale = 0)
	public long getNspmlKey() {
		return this.nspmlKey;
	}

	public void setNspmlKey(long nspmlKey) {
		this.nspmlKey = nspmlKey;
	}

	@Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "NROTATION_NAME_KEY", nullable = false, precision = 12, scale = 0)
	public long getNrotationNameKey() {
		return this.nrotationNameKey;
	}

	public void setNrotationNameKey(long nrotationNameKey) {
		this.nrotationNameKey = nrotationNameKey;
	}

	@Column(name = "NPRIO", nullable = false, precision = 6, scale = 0)
	public int getNprio() {
		return this.nprio;
	}

	public void setNprio(int nprio) {
		this.nprio = nprio;
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

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NDEDUCTION", nullable = false, precision = 1, scale = 0)
	public int getNdeduction() {
		return this.ndeduction;
	}

	public void setNdeduction(int ndeduction) {
		this.ndeduction = ndeduction;
	}

	@Column(name = "NPACKINGLIST_INDEX_KEY", nullable = false, precision = 12, scale = 0)
	public long getNpackinglistIndexKey() {
		return this.npackinglistIndexKey;
	}

	public void setNpackinglistIndexKey(long npackinglistIndexKey) {
		this.npackinglistIndexKey = npackinglistIndexKey;
	}

	@Column(name = "CPRODUCTION_TEXT", nullable = false, length = 40)
	public String getCproductionText() {
		return this.cproductionText;
	}

	public void setCproductionText(String cproductionText) {
		this.cproductionText = cproductionText;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "NACCOUNT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNaccountKey() {
		return this.naccountKey;
	}

	public void setNaccountKey(long naccountKey) {
		this.naccountKey = naccountKey;
	}

	@Column(name = "NBILLING_STATUS", nullable = false, precision = 1, scale = 0)
	public int getNbillingStatus() {
		return this.nbillingStatus;
	}

	public void setNbillingStatus(int nbillingStatus) {
		this.nbillingStatus = nbillingStatus;
	}

	@Column(name = "NAC_TRANSFER", nullable = false, precision = 1, scale = 0)
	public int getNacTransfer() {
		return this.nacTransfer;
	}

	public void setNacTransfer(int nacTransfer) {
		this.nacTransfer = nacTransfer;
	}

	@Column(name = "CADDITIONAL_ACCOUNT", length = 18)
	public String getCadditionalAccount() {
		return this.cadditionalAccount;
	}

	public void setCadditionalAccount(String cadditionalAccount) {
		this.cadditionalAccount = cadditionalAccount;
	}

	@Column(name = "NDISTRIBUTE", precision = 1, scale = 0)
	public Integer getNdistribute() {
		return this.ndistribute;
	}

	public void setNdistribute(Integer ndistribute) {
		this.ndistribute = ndistribute;
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

	@Column(name = "NREPLACETEXT", nullable = false, precision = 1, scale = 0)
	public int getNreplacetext() {
		return this.nreplacetext;
	}

	public void setNreplacetext(int nreplacetext) {
		this.nreplacetext = nreplacetext;
	}

	@Column(name = "NACTIVATE", nullable = false, precision = 1, scale = 0)
	public int getNactivate() {
		return this.nactivate;
	}

	public void setNactivate(int nactivate) {
		this.nactivate = nactivate;
	}

	@Column(name = "CDESCRIPTION", length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NSPML_KEY", nullable = false, insertable = false, updatable = false)
	public SysSpml getSysSpml() {
		return sysSpml;
	}

	public void setSysSpml(SysSpml sysSpml) {
		this.sysSpml = sysSpml;
	}
}


