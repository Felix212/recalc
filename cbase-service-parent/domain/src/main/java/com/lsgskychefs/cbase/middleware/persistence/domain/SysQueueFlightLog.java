package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 23.10.2025 13:28:09 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_LOG
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_FLIGHT_LOG"
)
public class SysQueueFlightLog implements DomainObject, java.io.Serializable {

	private long nqueueFlightLogKey;
	private SysQueueFlightCalc sysQueueFlightCalc;
	private long nresultKey;
	private Date dtimestamp;
	private int ntype;
	private String cmessage;

	public SysQueueFlightLog() {
	}

	@Id
	@Column(name = "NQUEUE_FLIGHT_LOG_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNqueueFlightLogKey() {
		return this.nqueueFlightLogKey;
	}

	public void setNqueueFlightLogKey(long nqueueFlightLogKey) {
		this.nqueueFlightLogKey = nqueueFlightLogKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	@JsonIgnore
	public SysQueueFlightCalc getSysQueueFlightCalc() {
		return this.sysQueueFlightCalc;
	}

	public void setSysQueueFlightCalc(SysQueueFlightCalc sysQueueFlightCalc) {
		this.sysQueueFlightCalc = sysQueueFlightCalc;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	@JsonView(View.Simple.class)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)
	@JsonView(View.Simple.class)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "CMESSAGE", nullable = false)
	@JsonView(View.Simple.class)
	public String getCmessage() {
		return this.cmessage;
	}

	public void setCmessage(String cmessage) {
		this.cmessage = cmessage;
	}

}


