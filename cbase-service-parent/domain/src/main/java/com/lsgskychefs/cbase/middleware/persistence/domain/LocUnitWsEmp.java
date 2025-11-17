package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.08.2016 13:34:44 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
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

/**
 * Entity(DomainObject) for table LOC_UNIT_WS_EMP (work station employ)
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_WS_EMP")
public class LocUnitWsEmp implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nwsempIndex;
	private LocUnitWsSchedule locUnitWsSchedule;
	private long nworkscheduleIndex;
	private int nday;
	private Date dvalidFrom;
	private Date dvalidTo;
	private long nempCount;

	@Id
	@Column(name = "NWSEMP_INDEX", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNwsempIndex() {
		return this.nwsempIndex;
	}

	public void setNwsempIndex(final long nwsempIndex) {
		this.nwsempIndex = nwsempIndex;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSCHEDULE_INDEX", nullable = false)
	public LocUnitWsSchedule getLocUnitWsSchedule() {
		return this.locUnitWsSchedule;
	}

	public void setLocUnitWsSchedule(final LocUnitWsSchedule locUnitWsSchedule) {
		this.locUnitWsSchedule = locUnitWsSchedule;
	}

	@Column(name = "NDAY", nullable = false, precision = 1, scale = 0)
	public int getNday() {
		return this.nday;
	}

	public void setNday(final int nday) {
		this.nday = nday;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(final Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "NEMP_COUNT", nullable = false, precision = 12, scale = 0)
	public long getNempCount() {
		return this.nempCount;
	}

	public void setNempCount(final long nempCount) {
		this.nempCount = nempCount;
	}

	/**
	 * Get nworkscheduleIndex
	 *
	 * @return the nworkscheduleIndex
	 */
	@Column(name = "NWORKSCHEDULE_INDEX", unique = true, nullable = false, precision = 12, scale = 0, updatable = false, insertable = false)
	public long getNworkscheduleIndex() {
		return nworkscheduleIndex;
	}

	/**
	 * set nworkscheduleIndex
	 *
	 * @param nworkscheduleIndex the nworkscheduleIndex to set
	 */
	public void setNworkscheduleIndex(final long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

}
