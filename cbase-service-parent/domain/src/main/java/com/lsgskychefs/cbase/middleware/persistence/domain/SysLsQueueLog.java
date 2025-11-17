package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 18, 2022 2:11:14 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

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
 * Entity(DomainObject) for table SYS_LS_QUEUE_LOG
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LS_QUEUE_LOG")
public class SysLsQueueLog implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nqueueMarLogKey;
	private SysLsQueue skyMarQueue;
	private String cbatchNumber;
	private Date dtimestamp;
	private int ntype;
	private String cmessage;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_LS_QUEUE_LOG")
	@SequenceGenerator(name = "SEQ_SYS_LS_QUEUE_LOG", sequenceName = "SEQ_SYS_LS_QUEUE_LOG", allocationSize = 1)
	@Column(name = "NQUEUE_MAR_LOG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNqueueMarLogKey() {
		return this.nqueueMarLogKey;
	}

	public void setNqueueMarLogKey(final long nqueueMarLogKey) {
		this.nqueueMarLogKey = nqueueMarLogKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	public SysLsQueue getSkyMarQueue() {
		return this.skyMarQueue;
	}

	public void setSkyMarQueue(final SysLsQueue skyMarQueue) {
		this.skyMarQueue = skyMarQueue;
	}

	@Column(name = "CBATCH_NUMBER", nullable = false, length = 40)
	public String getCbatchNumber() {
		return this.cbatchNumber;
	}

	public void setCbatchNumber(final String cbatchNumber) {
		this.cbatchNumber = cbatchNumber;
	}

	@Column(name = "DTIMESTAMP", nullable = false)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(final int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "CMESSAGE", nullable = false)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(final String cmessage) {
		this.cmessage = cmessage;
	}

}
