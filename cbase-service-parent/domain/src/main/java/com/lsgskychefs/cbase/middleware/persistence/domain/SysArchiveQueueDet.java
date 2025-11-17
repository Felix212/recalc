package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.02.2025 09:46:17 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_ARCHIVE_QUEUE_DET
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ARCHIVE_QUEUE_DET"
)
public class SysArchiveQueueDet implements DomainObject, java.io.Serializable {

	private long nqueueDetailKey;
	private SysArchiveQueue sysArchiveQueue;
	private Integer nentryType;
	private Long nresultKey;
	private Long ndetailKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_ARCHIVE_QUEUE_DET")
	@SequenceGenerator(name = "SEQ_SYS_ARCHIVE_QUEUE_DET", sequenceName = "SEQ_SYS_ARCHIVE_QUEUE_DET", allocationSize = 1)
	@Column(name = "NQUEUE_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNqueueDetailKey() {
		return this.nqueueDetailKey;
	}

	public void setNqueueDetailKey(long nqueueDetailKey) {
		this.nqueueDetailKey = nqueueDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NQUEUE_KEY", nullable = false)
	public SysArchiveQueue getSysArchiveQueue() {
		return this.sysArchiveQueue;
	}

	public void setSysArchiveQueue(SysArchiveQueue sysArchiveQueue) {
		this.sysArchiveQueue = sysArchiveQueue;
	}

	@Column(name = "NENTRY_TYPE", precision = 2, scale = 0)
	public Integer getNentryType() {
		return this.nentryType;
	}

	public void setNentryType(Integer nentryType) {
		this.nentryType = nentryType;
	}

	@Column(name = "NRESULT_KEY", precision = 12, scale = 0)
	public Long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(Long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NDETAIL_KEY", precision = 12, scale = 0)
	public Long getNdetailKey() {
		return this.ndetailKey;
	}

	public void setNdetailKey(Long ndetailKey) {
		this.ndetailKey = ndetailKey;
	}

}


