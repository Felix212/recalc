package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 18, 2022 2:11:14 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table SYS_LS_QUEUE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LS_QUEUE")
public class SysLsQueue implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;
	private String cbatchNumber;
	private Date dstartComputing;
	private Date dstopComputing;
	private Integer nerror;
	private String cerror;
	private Integer nprocessStatus;
	private String cinstance;
	private Set<SysLsQueueLog> skyMarQueueLogs = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_LS_QUEUE")
	@SequenceGenerator(name = "SEQ_SYS_LS_QUEUE", sequenceName = "SEQ_SYS_LS_QUEUE", allocationSize = 1)
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@Column(name = "CBATCH_NUMBER", nullable = false, length = 40)
	public String getCbatchNumber() {
		return this.cbatchNumber;
	}

	public void setCbatchNumber(final String cbatchNumber) {
		this.cbatchNumber = cbatchNumber;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_COMPUTING", length = 7)
	public Date getDstartComputing() {
		return this.dstartComputing;
	}

	public void setDstartComputing(final Date dstartComputing) {
		this.dstartComputing = dstartComputing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOP_COMPUTING", length = 7)
	public Date getDstopComputing() {
		return this.dstopComputing;
	}

	public void setDstopComputing(final Date dstopComputing) {
		this.dstopComputing = dstopComputing;
	}

	@Column(name = "NERROR", precision = 6, scale = 0)
	public Integer getNerror() {
		return this.nerror;
	}

	public void setNerror(final Integer nerror) {
		this.nerror = nerror;
	}

	@Column(name = "CERROR", length = 2048)
	public String getCerror() {
		return this.cerror;
	}

	public void setCerror(final String cerror) {
		this.cerror = cerror;
	}

	@Column(name = "NPROCESS_STATUS", precision = 2, scale = 0)
	public Integer getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final Integer nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "CINSTANCE", length = 30)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "skyMarQueue")
	public Set<SysLsQueueLog> getSkyMarQueueLogs() {
		return this.skyMarQueueLogs;
	}

	public void setSkyMarQueueLogs(final Set<SysLsQueueLog> skyMarQueueLogs) {
		this.skyMarQueueLogs = skyMarQueueLogs;
	}

}
