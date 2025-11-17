package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_QUEUE_BATCH
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_BATCH")
public class SysQueueBatch implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;
	private int nfunction;
	private Date dcreated;
	private String cuser;
	private String ctext;
	private Date dstartProcessing;
	private Date dendProcessing;
	private String cinstance;
	private Integer nstatus;
	private String cstatus;
	private String cfileName;
	private String cfileType;
	private byte[] bfile;
	private Long nreportKey;
	private Integer nsubfunction;
	private String cparameters;
	private Set<SysQueueBatchDetail> sysQueueBatchDetails = new HashSet<>(0);
	private Set<SysQueueBatchSubdetail> sysQueueBatchSubdetails = new HashSet<>(0);
	private Set<SysQueueBatchRpt> sysQueueBatchRpts = new HashSet<>(0);
	private Set<SysQueueBatchSpc> sysQueueBatchSpcs = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_QUEUE_BATCH")
	@SequenceGenerator(name = "SEQ_SYS_QUEUE_BATCH", sequenceName = "SEQ_SYS_QUEUE_BATCH", allocationSize = 1)
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@Column(name = "NFUNCTION", nullable = false, precision = 6, scale = 0)
	public int getNfunction() {
		return this.nfunction;
	}

	public void setNfunction(final int nfunction) {
		this.nfunction = nfunction;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", nullable = false, length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "CUSER", nullable = false, length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CTEXT", length = 80)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_PROCESSING", length = 7)
	public Date getDstartProcessing() {
		return this.dstartProcessing;
	}

	public void setDstartProcessing(final Date dstartProcessing) {
		this.dstartProcessing = dstartProcessing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DEND_PROCESSING", length = 7)
	public Date getDendProcessing() {
		return this.dendProcessing;
	}

	public void setDendProcessing(final Date dendProcessing) {
		this.dendProcessing = dendProcessing;
	}

	@Column(name = "CINSTANCE", length = 30)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "NSTATUS", precision = 6, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CSTATUS", length = 40)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(final String cstatus) {
		this.cstatus = cstatus;
	}

	@Column(name = "CFILE_NAME", length = 80)
	public String getCfileName() {
		return this.cfileName;
	}

	public void setCfileName(final String cfileName) {
		this.cfileName = cfileName;
	}

	@Column(name = "CFILE_TYPE", length = 6)
	public String getCfileType() {
		return this.cfileType;
	}

	public void setCfileType(final String cfileType) {
		this.cfileType = cfileType;
	}

	@Lob
	@Column(name = "BFILE", length = 4000)
	public byte[] getBfile() {
		return this.bfile;
	}

	public void setBfile(final byte[] bfile) {
		this.bfile = bfile;
	}

	@Column(name = "NREPORT_KEY", precision = 12, scale = 0)
	public Long getNreportKey() {
		return this.nreportKey;
	}

	public void setNreportKey(final Long nreportKey) {
		this.nreportKey = nreportKey;
	}

	@Column(name = "NSUBFUNCTION", precision = 6, scale = 0)
	public Integer getNsubfunction() {
		return this.nsubfunction;
	}

	public void setNsubfunction(final Integer nsubfunction) {
		this.nsubfunction = nsubfunction;
	}

	@Column(name = "CPARAMETERS", length = 256)
	public String getCparameters() {
		return this.cparameters;
	}

	public void setCparameters(final String cparameters) {
		this.cparameters = cparameters;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueBatch")
	public Set<SysQueueBatchDetail> getSysQueueBatchDetails() {
		return this.sysQueueBatchDetails;
	}

	public void setSysQueueBatchDetails(final Set<SysQueueBatchDetail> sysQueueBatchDetails) {
		this.sysQueueBatchDetails = sysQueueBatchDetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueBatch")
	public Set<SysQueueBatchSubdetail> getSysQueueBatchSubdetails() {
		return this.sysQueueBatchSubdetails;
	}

	public void setSysQueueBatchSubdetails(final Set<SysQueueBatchSubdetail> sysQueueBatchSubdetails) {
		this.sysQueueBatchSubdetails = sysQueueBatchSubdetails;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueBatch")
	public Set<SysQueueBatchRpt> getSysQueueBatchRpts() {
		return this.sysQueueBatchRpts;
	}

	public void setSysQueueBatchRpts(final Set<SysQueueBatchRpt> sysQueueBatchRpts) {
		this.sysQueueBatchRpts = sysQueueBatchRpts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysQueueBatch")
	public Set<SysQueueBatchSpc> getSysQueueBatchSpcs() {
		return this.sysQueueBatchSpcs;
	}

	public void setSysQueueBatchSpcs(final Set<SysQueueBatchSpc> sysQueueBatchSpcs) {
		this.sysQueueBatchSpcs = sysQueueBatchSpcs;
	}

}
