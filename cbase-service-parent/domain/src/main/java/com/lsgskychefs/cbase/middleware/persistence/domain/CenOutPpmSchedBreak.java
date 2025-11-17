package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 22.09.2017 15:32:43 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_SCHED_BREAK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_SCHED_BREAK")
public class CenOutPpmSchedBreak implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutPpmSchedBreakId id;
	@JsonIgnore
	private CenOutPpmSched cenOutPpmSched;
	private long nbreakKey;
	private String cbreak;
	private String cdescription;
	private int nduration;
	private String cstartTime;
	private String cendTime;
	private Date dstartTime;
	private Date dendTime;
	private Date dactualStartTime;
	private Date dactualEndTime;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nppmSchedKey", column = @Column(name = "NPPM_SCHED_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nscheduleBreakKey", column = @Column(name = "NSCHEDULE_BREAK_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenOutPpmSchedBreakId getId() {
		return this.id;
	}

	public void setId(final CenOutPpmSchedBreakId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPPM_SCHED_KEY", nullable = false, insertable = false, updatable = false)
	public CenOutPpmSched getCenOutPpmSched() {
		return this.cenOutPpmSched;
	}

	public void setCenOutPpmSched(final CenOutPpmSched cenOutPpmSched) {
		this.cenOutPpmSched = cenOutPpmSched;
	}

	@Column(name = "NBREAK_KEY", nullable = false, precision = 12, scale = 0)
	public long getNbreakKey() {
		return this.nbreakKey;
	}

	public void setNbreakKey(final long nbreakKey) {
		this.nbreakKey = nbreakKey;
	}

	@Column(name = "CBREAK", nullable = false, length = 40)
	public String getCbreak() {
		return this.cbreak;
	}

	public void setCbreak(final String cbreak) {
		this.cbreak = cbreak;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NDURATION", nullable = false, precision = 3, scale = 0)
	public int getNduration() {
		return this.nduration;
	}

	public void setNduration(final int nduration) {
		this.nduration = nduration;
	}

	@Column(name = "CSTART_TIME", nullable = false, length = 5)
	public String getCstartTime() {
		return this.cstartTime;
	}

	public void setCstartTime(final String cstartTime) {
		this.cstartTime = cstartTime;
	}

	@Column(name = "CEND_TIME", nullable = false, length = 5)
	public String getCendTime() {
		return this.cendTime;
	}

	public void setCendTime(final String cendTime) {
		this.cendTime = cendTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTART_TIME", nullable = false, length = 7)
	public Date getDstartTime() {
		return this.dstartTime;
	}

	public void setDstartTime(final Date dstartTime) {
		this.dstartTime = dstartTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DEND_TIME", nullable = false, length = 7)
	public Date getDendTime() {
		return this.dendTime;
	}

	public void setDendTime(final Date dendTime) {
		this.dendTime = dendTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DACTUAL_START_TIME", length = 7)
	public Date getDactualStartTime() {
		return this.dactualStartTime;
	}

	public void setDactualStartTime(final Date dactualStartTime) {
		this.dactualStartTime = dactualStartTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DACTUAL_END_TIME", length = 7)
	public Date getDactualEndTime() {
		return this.dactualEndTime;
	}

	public void setDactualEndTime(final Date dactualEndTime) {
		this.dactualEndTime = dactualEndTime;
	}

}
