package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.08.2016 09:42:20 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_ROUTINGPLAN_HANDLING
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_ROUTINGPLAN_HANDLING")
public class CenRoutingplanHandling implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nroutingplanHandlingKey;
	private SysUnits sysUnits;
	private CenHandling cenHandling;
	private long nroutingdetailKey;
	private CenRoutingplan cenRoutingplan;
	private int nfreq1;
	private int nfreq2;
	private int nfreq3;
	private int nfreq4;
	private int nfreq5;
	private int nfreq6;
	private int nfreq7;
	private Date dvalidFrom;
	private Date dvalidTo;
	private Long nsort;
	private Integer nuploadFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NROUTINGPLAN_HANDLING_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_ROUTINGPLAN_HANDLING")
	@SequenceGenerator(name = "SEQ_CEN_ROUTINGPLAN_HANDLING", sequenceName = "SEQ_CEN_ROUTINGPLAN_HANDLING", allocationSize = 1)
	public long getNroutingplanHandlingKey() {
		return this.nroutingplanHandlingKey;
	}

	public void setNroutingplanHandlingKey(final long nroutingplanHandlingKey) {
		this.nroutingplanHandlingKey = nroutingplanHandlingKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT")
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(final CenHandling cenHandling) {
		this.cenHandling = cenHandling;
	}

	@Column(name = "NROUTINGDETAIL_KEY", nullable = false, precision = 12, scale = 0)
	public long getNroutingdetailKey() {
		return this.nroutingdetailKey;
	}

	public void setNroutingdetailKey(final long nroutingdetailKey) {
		this.nroutingdetailKey = nroutingdetailKey;
	}

	@JsonIgnore
	@OneToOne(fetch = FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	@JoinColumn(name = "NROUTINGDETAIL_KEY", nullable = true, insertable = false, updatable = false)
	public CenRoutingplan getCenRoutingplan() {
		return this.cenRoutingplan;
	}

	public void setCenRoutingplan(final CenRoutingplan cenRoutingplan) {
		this.cenRoutingplan = cenRoutingplan;
	}

	@Column(name = "NFREQ1", nullable = false, precision = 1, scale = 0)
	public int getNfreq1() {
		return this.nfreq1;
	}

	public void setNfreq1(final int nfreq1) {
		this.nfreq1 = nfreq1;
	}

	@Column(name = "NFREQ2", nullable = false, precision = 1, scale = 0)
	public int getNfreq2() {
		return this.nfreq2;
	}

	public void setNfreq2(final int nfreq2) {
		this.nfreq2 = nfreq2;
	}

	@Column(name = "NFREQ3", nullable = false, precision = 1, scale = 0)
	public int getNfreq3() {
		return this.nfreq3;
	}

	public void setNfreq3(final int nfreq3) {
		this.nfreq3 = nfreq3;
	}

	@Column(name = "NFREQ4", nullable = false, precision = 1, scale = 0)
	public int getNfreq4() {
		return this.nfreq4;
	}

	public void setNfreq4(final int nfreq4) {
		this.nfreq4 = nfreq4;
	}

	@Column(name = "NFREQ5", nullable = false, precision = 1, scale = 0)
	public int getNfreq5() {
		return this.nfreq5;
	}

	public void setNfreq5(final int nfreq5) {
		this.nfreq5 = nfreq5;
	}

	@Column(name = "NFREQ6", nullable = false, precision = 1, scale = 0)
	public int getNfreq6() {
		return this.nfreq6;
	}

	public void setNfreq6(final int nfreq6) {
		this.nfreq6 = nfreq6;
	}

	@Column(name = "NFREQ7", nullable = false, precision = 1, scale = 0)
	public int getNfreq7() {
		return this.nfreq7;
	}

	public void setNfreq7(final int nfreq7) {
		this.nfreq7 = nfreq7;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NUPLOAD_FLAG", precision = 1, scale = 0)
	public Integer getNuploadFlag() {
		return this.nuploadFlag;
	}

	public void setNuploadFlag(final Integer nuploadFlag) {
		this.nuploadFlag = nuploadFlag;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}
