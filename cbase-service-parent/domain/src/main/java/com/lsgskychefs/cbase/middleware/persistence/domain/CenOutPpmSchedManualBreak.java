package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 12, 2024 3:52:22 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_SCHED_MANUAL_BREAK
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_SCHED_MANUAL_BREAK")
public class CenOutPpmSchedManualBreak implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmSchedManualBreakKey;
	private long nworkscheduleIndex;
	private int nduration;
	private Date dstartDate;
	private String cstartTime;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_SCHED_MANUAL_BREAK")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_SCHED_MANUAL_BREAK", sequenceName = "SEQ_CEN_OUT_PPM_SCHED_MANUAL_BREAK", allocationSize = 1)
	@Column(name = "NPPM_SCHED_MANUAL_BREAK_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmSchedManualBreakKey() {
		return this.nppmSchedManualBreakKey;
	}

	public void setNppmSchedManualBreakKey(long nppmSchedManualBreakKey) {
		this.nppmSchedManualBreakKey = nppmSchedManualBreakKey;
	}

	@Column(name = "NWORKSCHEDULE_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@Column(name = "NDURATION", nullable = false, precision = 5, scale = 0)
	public int getNduration() {
		return this.nduration;
	}

	public void setNduration(int nduration) {
		this.nduration = nduration;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_DATE", nullable = false, length = 7)
	public Date getDstartDate() {
		return this.dstartDate;
	}

	public void setDstartDate(Date dstartDate) {
		this.dstartDate = dstartDate;
	}

	@Column(name = "CSTART_TIME", nullable = false, length = 5)
	public String getCstartTime() {
		return this.cstartTime;
	}

	public void setCstartTime(String cstartTime) {
		this.cstartTime = cstartTime;
	}

}


