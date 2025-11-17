package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.02.2016 14:58:49 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table SYS_CUSTOMER_REPORTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_CUSTOMER_REPORTS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysCustomerReports implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncusReportKey;
	private String csection;
	private String creportFile;
	private String cdescription;
	private String cwho;
	private Date dtimestamp;
	private byte[] breport;
	private int narchivetype;
	private CenDynReportRequest cenDynReportRequest;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_CUSTOMER_REPORTS")
	@SequenceGenerator(name = "SEQ_SYS_CUSTOMER_REPORTS", sequenceName = "SEQ_SYS_CUSTOMER_REPORTS", allocationSize = 1)
	@Column(name = "NCUS_REPORT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcusReportKey() {
		return this.ncusReportKey;
	}

	public void setNcusReportKey(final long ncusReportKey) {
		this.ncusReportKey = ncusReportKey;
	}

	@Column(name = "CSECTION", nullable = false, length = 40)
	public String getCsection() {
		return this.csection;
	}

	public void setCsection(final String csection) {
		this.csection = csection;
	}

	@Column(name = "CREPORT_FILE", nullable = false, length = 80)
	public String getCreportFile() {
		return this.creportFile;
	}

	public void setCreportFile(final String creportFile) {
		this.creportFile = creportFile;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 80)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CWHO", nullable = false, length = 80)
	public String getCwho() {
		return this.cwho;
	}

	public void setCwho(final String cwho) {
		this.cwho = cwho;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@JsonIgnore
	@Lob
	@Column(name = "BREPORT", length = 4000)
	public byte[] getBreport() {
		return this.breport;
	}

	public void setBreport(final byte[] breport) {
		this.breport = breport;
	}

	@Column(name = "NARCHIVETYPE", nullable = false, precision = 1, scale = 0)
	public int getNarchivetype() {
		return this.narchivetype;
	}

	public void setNarchivetype(final int narchivetype) {
		this.narchivetype = narchivetype;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCUS_REPORT_KEY", nullable = false, insertable = false, updatable = false)
	@Transient
	public CenDynReportRequest getCenDynReportRequest() {
		return this.cenDynReportRequest;
	}

	public void setCenDynReportRequest(CenDynReportRequest cenDynReportRequest) {
		this.cenDynReportRequest = cenDynReportRequest;
	}
}
