package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Nov 18, 2019 2:11:26 PM by Hibernate Tools 4.3.5.Final

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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_UNIT_REPORT_SCHEDULE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_REPORT_SCHEDULE", uniqueConstraints = @UniqueConstraint(columnNames = { "NSCHEDULE_KEY", "NCUS_REPORT_KEY",
		"CUNIT" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitReportSchedule implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nscheduleKey;
	private SysCustomerReports sysCustomerReports;
	@JsonIgnore
	private SysUnits sysUnits;
	private String cdescription;
	private Integer nreportDateOffset;
	private Date dlastSend;
	private Date dcreated;
	private Date dupdated;
	private String ccreatedBy;
	private String cupdatedBy;
	private Set<LocUnitReportRecipient> locUnitReportRecipients = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_REPORT_SCHEDULE")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_REPORT_SCHEDULE", sequenceName = "SEQ_LOC_UNIT_REPORT_SCHEDULE", allocationSize = 1)
	@Column(name = "NSCHEDULE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNscheduleKey() {
		return this.nscheduleKey;
	}

	public void setNscheduleKey(final long nscheduleKey) {
		this.nscheduleKey = nscheduleKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCUS_REPORT_KEY", nullable = false)
	public SysCustomerReports getSysCustomerReports() {
		return this.sysCustomerReports;
	}

	public void setSysCustomerReports(final SysCustomerReports sysCustomerReports) {
		this.sysCustomerReports = sysCustomerReports;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CDESCRIPTION", length = 200)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NREPORT_DATE_OFFSET", precision = 2, scale = 0)
	public Integer getNreportDateOffset() {
		return this.nreportDateOffset;
	}

	public void setNreportDateOffset(final Integer nreportDateOffset) {
		this.nreportDateOffset = nreportDateOffset;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLAST_SEND", length = 7)
	public Date getDlastSend() {
		return this.dlastSend;
	}

	public void setDlastSend(final Date dlastSend) {
		this.dlastSend = dlastSend;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED", length = 7)
	public Date getDupdated() {
		return this.dupdated;
	}

	public void setDupdated(final Date dupdated) {
		this.dupdated = dupdated;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "locUnitReportSchedules")
	public Set<LocUnitReportRecipient> getLocUnitReportRecipients() {
		return this.locUnitReportRecipients;
	}

	public void setLocUnitReportRecipients(final Set<LocUnitReportRecipient> locUnitReportRecipients) {
		this.locUnitReportRecipients = locUnitReportRecipients;
	}

}
