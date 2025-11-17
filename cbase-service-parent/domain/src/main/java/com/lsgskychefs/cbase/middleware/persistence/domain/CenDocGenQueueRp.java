package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.01.2017 13:42:37 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE_RP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE_RP")
public class CenDocGenQueueRp implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private Long njobKey;
	private SysRemotePrinter sysRemotePrinter;
	private SysRemotePrinterFunc sysRemotePrinterFunc;
	private byte[] breport;
	private String cfilename;
	private Date djobCreated;
	private String cjobCreatedBy;
	private Date djobStart;
	private Date djobEnd;
	private int ngenStatus;
	private String cjobDescription;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_QUEUE_RP")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_QUEUE_RP", sequenceName = "SEQ_CEN_DOC_GEN_QUEUE_RP", allocationSize = 1)
	@Column(name = "NJOB_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public Long getNjobKey() {
		return this.njobKey;
	}

	public void setNjobKey(final Long njobKey) {
		this.njobKey = njobKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns( {
			@JoinColumn(name="NJOB_TYPE", referencedColumnName="NJOB_TYPE", nullable=false),
			@JoinColumn(name="NJOB_SUBTYPE", referencedColumnName="NJOB_SUBTYPE", nullable=false) } )
	public SysRemotePrinterFunc getSysRemotePrinterFunc() {
		return this.sysRemotePrinterFunc;
	}

	public void setSysRemotePrinterFunc(final SysRemotePrinterFunc sysRemotePrinterFunc) {
		this.sysRemotePrinterFunc = sysRemotePrinterFunc;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPRINTER_KEY", nullable = false)
	public SysRemotePrinter getSysRemotePrinter() {
		return this.sysRemotePrinter;
	}

	public void setSysRemotePrinter(final SysRemotePrinter sysRemotePrinter) {
		this.sysRemotePrinter = sysRemotePrinter;
	}

	@Lob
	@Column(name = "BREPORT", length = 4000)
	public byte[] getBreport() {
		return this.breport;
	}

	public void setBreport(final byte[] breport) {
		this.breport = breport;
	}

	@Column(name = "CFILENAME", nullable = false, length = 40)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_CREATED", nullable = false, length = 7)
	public Date getDjobCreated() {
		return this.djobCreated;
	}

	public void setDjobCreated(final Date djobCreated) {
		this.djobCreated = djobCreated;
	}

	@Column(name = "CJOB_CREATED_BY", nullable = false, length = 40)
	public String getCjobCreatedBy() {
		return this.cjobCreatedBy;
	}

	public void setCjobCreatedBy(final String cjobCreatedBy) {
		this.cjobCreatedBy = cjobCreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_START", length = 7)
	public Date getDjobStart() {
		return this.djobStart;
	}

	public void setDjobStart(final Date djobStart) {
		this.djobStart = djobStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_END", length = 7)
	public Date getDjobEnd() {
		return this.djobEnd;
	}

	public void setDjobEnd(final Date djobEnd) {
		this.djobEnd = djobEnd;
	}

	@Column(name = "NGEN_STATUS", nullable = false, precision = 1, scale = 0)
	public int getNgenStatus() {
		return this.ngenStatus;
	}

	public void setNgenStatus(final int ngenStatus) {
		this.ngenStatus = ngenStatus;
	}

	@Column(name = "CJOB_DESCRIPTION", nullable = false, length = 256, columnDefinition = "varchar2(256) default 'NONE'")
	public String getCjobDescription() {
		return cjobDescription;
	}

	public void setCjobDescription(final String cjobDescription) {
		this.cjobDescription = cjobDescription;
	}
}
