package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.09.2022 09:54:55 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_SPML
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SPML")
public class CenSpml implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingSpmlKey;
	private CenHandling cenHandling;
	private Date dvalidFrom;
	private Date dvalidTo;
	private long nrotationKey;
	private long nclassNumber;
	private long ndefaultAccountKey;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Long noldSpmlKey;
	private Integer nsalesBom;
	private Set<CenSpmlDetail> cenSpmlDetails = new HashSet<>(0);

	@Id
	@Column(name = "NHANDLING_SPML_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingSpmlKey() {
		return this.nhandlingSpmlKey;
	}

	public void setNhandlingSpmlKey(long nhandlingSpmlKey) {
		this.nhandlingSpmlKey = nhandlingSpmlKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(CenHandling cenHandling) {
		this.cenHandling = cenHandling;
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

	@Column(name = "NROTATION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNrotationKey() {
		return this.nrotationKey;
	}

	public void setNrotationKey(long nrotationKey) {
		this.nrotationKey = nrotationKey;
	}

	@Column(name = "NCLASS_NUMBER", nullable = false, precision = 12, scale = 0)
	public long getNclassNumber() {
		return this.nclassNumber;
	}

	public void setNclassNumber(long nclassNumber) {
		this.nclassNumber = nclassNumber;
	}

	@Column(name = "NDEFAULT_ACCOUNT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNdefaultAccountKey() {
		return this.ndefaultAccountKey;
	}

	public void setNdefaultAccountKey(long ndefaultAccountKey) {
		this.ndefaultAccountKey = ndefaultAccountKey;
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

	@Column(name = "NOLD_SPML_KEY", precision = 12, scale = 0)
	public Long getNoldSpmlKey() {
		return this.noldSpmlKey;
	}

	public void setNoldSpmlKey(Long noldSpmlKey) {
		this.noldSpmlKey = noldSpmlKey;
	}

	@Column(name = "NSALES_BOM", precision = 1, scale = 0)
	public Integer getNsalesBom() {
		return this.nsalesBom;
	}

	public void setNsalesBom(Integer nsalesBom) {
		this.nsalesBom = nsalesBom;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSpml")
	public Set<CenSpmlDetail> getCenSpmlDetails() {
		return this.cenSpmlDetails;
	}

	public void setCenSpmlDetails(Set<CenSpmlDetail> cenSpmlDetails) {
		this.cenSpmlDetails = cenSpmlDetails;
	}
}


