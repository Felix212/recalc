package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 11, 2019 12:20:45 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_FOR_MASTER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_FOR_MASTER")
public class CenForMaster implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long formNkey;
	private SysUnits sysUnits;
	private CenEmailServer cenEmailServer;
	private CenAirlines cenAirlines;
	private int formNtype;
	private int formNperiod;
	private int formNoffset;
	private int formNfrequence;
	private String formCstartTime;
	private Date formDvalidFrom;
	private Date formDvalidTo;
	private Date formDlastrun;
	private Date formDlastPeriodFrom;
	private Date formDlastPeriodTo;
	private Set<CenForDetail> cenForDetails = new HashSet<>(0);

	@Id
	@Column(name = "FORM_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getFormNkey() {
		return this.formNkey;
	}

	public void setFormNkey(final long formNkey) {
		this.formNkey = formNkey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORM_CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORM_NEMS_NKEY", nullable = false)
	public CenEmailServer getCenEmailServer() {
		return this.cenEmailServer;
	}

	public void setCenEmailServer(final CenEmailServer cenEmailServer) {
		this.cenEmailServer = cenEmailServer;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FORM_NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "FORM_NTYPE", nullable = false, precision = 1, scale = 0)
	public int getFormNtype() {
		return this.formNtype;
	}

	public void setFormNtype(final int formNtype) {
		this.formNtype = formNtype;
	}

	@Column(name = "FORM_NPERIOD", nullable = false, precision = 2, scale = 0)
	public int getFormNperiod() {
		return this.formNperiod;
	}

	public void setFormNperiod(final int formNperiod) {
		this.formNperiod = formNperiod;
	}

	@Column(name = "FORM_NOFFSET", nullable = false, precision = 3, scale = 0)
	public int getFormNoffset() {
		return this.formNoffset;
	}

	public void setFormNoffset(final int formNoffset) {
		this.formNoffset = formNoffset;
	}

	@Column(name = "FORM_NFREQUENCE", nullable = false, precision = 1, scale = 0)
	public int getFormNfrequence() {
		return this.formNfrequence;
	}

	public void setFormNfrequence(final int formNfrequence) {
		this.formNfrequence = formNfrequence;
	}

	@Column(name = "FORM_CSTART_TIME", nullable = false, length = 4)
	public String getFormCstartTime() {
		return this.formCstartTime;
	}

	public void setFormCstartTime(final String formCstartTime) {
		this.formCstartTime = formCstartTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORM_DVALID_FROM", nullable = false, length = 7)
	public Date getFormDvalidFrom() {
		return this.formDvalidFrom;
	}

	public void setFormDvalidFrom(final Date formDvalidFrom) {
		this.formDvalidFrom = formDvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORM_DVALID_TO", nullable = false, length = 7)
	public Date getFormDvalidTo() {
		return this.formDvalidTo;
	}

	public void setFormDvalidTo(final Date formDvalidTo) {
		this.formDvalidTo = formDvalidTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORM_DLASTRUN", length = 7)
	public Date getFormDlastrun() {
		return this.formDlastrun;
	}

	public void setFormDlastrun(final Date formDlastrun) {
		this.formDlastrun = formDlastrun;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORM_DLAST_PERIOD_FROM", length = 7)
	public Date getFormDlastPeriodFrom() {
		return this.formDlastPeriodFrom;
	}

	public void setFormDlastPeriodFrom(final Date formDlastPeriodFrom) {
		this.formDlastPeriodFrom = formDlastPeriodFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "FORM_DLAST_PERIOD_TO", length = 7)
	public Date getFormDlastPeriodTo() {
		return this.formDlastPeriodTo;
	}

	public void setFormDlastPeriodTo(final Date formDlastPeriodTo) {
		this.formDlastPeriodTo = formDlastPeriodTo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenForMaster")
	public Set<CenForDetail> getCenForDetails() {
		return this.cenForDetails;
	}

	public void setCenForDetails(final Set<CenForDetail> cenForDetails) {
		this.cenForDetails = cenForDetails;
	}

}
