package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.02.2025 09:46:17 by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table SYS_ARCHIVE_QUEUE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ARCHIVE_QUEUE"
)
public class SysArchiveQueue implements DomainObject, java.io.Serializable {

	private long nqueueKey;
	private Integer njobType;
	private Date dcreated;
	private Integer nprocessStatus;
	private Date dstartComputing;
	private Date dstopComputing;
	private String cdescription;
	private Set<SysArchiveQueueDoc> sysArchiveQueueDocs = new HashSet<SysArchiveQueueDoc>(0);
	private Set<SysArchiveQueueDet> sysArchiveQueueDets = new HashSet<SysArchiveQueueDet>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_ARCHIVE_QUEUE")
	@SequenceGenerator(name = "SEQ_SYS_ARCHIVE_QUEUE", sequenceName = "SEQ_SYS_ARCHIVE_QUEUE", allocationSize = 1)
	@Column(name = "NQUEUE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNqueueKey() {
		return this.nqueueKey;
	}

	public void setNqueueKey(long nqueueKey) {
		this.nqueueKey = nqueueKey;
	}

	@Column(name = "NJOB_TYPE", precision = 2, scale = 0)
	public Integer getNjobType() {
		return this.njobType;
	}

	public void setNjobType(Integer njobType) {
		this.njobType = njobType;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "NPROCESS_STATUS", precision = 2, scale = 0)
	public Integer getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(Integer nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_COMPUTING", length = 7)
	public Date getDstartComputing() {
		return this.dstartComputing;
	}

	public void setDstartComputing(Date dstartComputing) {
		this.dstartComputing = dstartComputing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOP_COMPUTING", length = 7)
	public Date getDstopComputing() {
		return this.dstopComputing;
	}

	public void setDstopComputing(Date dstopComputing) {
		this.dstopComputing = dstopComputing;
	}

	@Column(name = "CDESCRIPTION", length = 100)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysArchiveQueue")
	public Set<SysArchiveQueueDoc> getSysArchiveQueueDocs() {
		return this.sysArchiveQueueDocs;
	}

	public void setSysArchiveQueueDocs(Set<SysArchiveQueueDoc> sysArchiveQueueDocs) {
		this.sysArchiveQueueDocs = sysArchiveQueueDocs;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysArchiveQueue")
	public Set<SysArchiveQueueDet> getSysArchiveQueueDets() {
		return this.sysArchiveQueueDets;
	}

	public void setSysArchiveQueueDets(Set<SysArchiveQueueDet> sysArchiveQueueDets) {
		this.sysArchiveQueueDets = sysArchiveQueueDets;
	}

}


