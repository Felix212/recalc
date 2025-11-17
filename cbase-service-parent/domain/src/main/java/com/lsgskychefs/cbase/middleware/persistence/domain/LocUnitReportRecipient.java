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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table LOC_UNIT_REPORT_RECIPIENT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_REPORT_RECIPIENT")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class LocUnitReportRecipient implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nrecipientKey;
	private String cemailAddress;
	private Date dcreated;
	private Date dupdated;
	private String ccreatedBy;
	private String cupdatedBy;
	@JsonIgnore
	private Set<LocUnitReportSchedule> locUnitReportSchedules = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_REPORT_RECIPIENT")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_REPORT_RECIPIENT", sequenceName = "SEQ_LOC_UNIT_REPORT_RECIPIENT", allocationSize = 1)
	@Column(name = "NRECIPIENT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNrecipientKey() {
		return this.nrecipientKey;
	}

	public void setNrecipientKey(final long nrecipientKey) {
		this.nrecipientKey = nrecipientKey;
	}

	@Column(name = "CEMAIL_ADDRESS", length = 200)
	public String getCemailAddress() {
		return this.cemailAddress;
	}

	public void setCemailAddress(final String cemailAddress) {
		this.cemailAddress = cemailAddress;
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

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "LOC_UNIT_REPORT_AUDIENCE", joinColumns = {
			@JoinColumn(name = "NRECIPIENT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NSCHEDULE_KEY", nullable = false, updatable = false) })
	public Set<LocUnitReportSchedule> getLocUnitReportSchedules() {
		return this.locUnitReportSchedules;
	}

	public void setLocUnitReportSchedules(final Set<LocUnitReportSchedule> locUnitReportSchedules) {
		this.locUnitReportSchedules = locUnitReportSchedules;
	}

}
