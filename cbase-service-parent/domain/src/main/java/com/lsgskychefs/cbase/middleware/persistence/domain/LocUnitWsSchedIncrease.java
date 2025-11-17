package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jun 22, 2018 4:13:29 PM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table LOC_UNIT_WS_SCHED_INCREASE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_WS_SCHED_INCREASE")
public class LocUnitWsSchedIncrease implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitWsSchedIncreaseId id;
	private LocUnitWsSchedule locUnitWsSchedule;
	private LocUnitWorkstation locUnitWorkstation;
	private LocUnitPpmValidities locUnitPpmValidities;
	private Date dupdated;
	private String cupdatedBy;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nworkstationKey", column = @Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nvalidIndex", column = @Column(name = "NVALID_INDEX", nullable = false, precision = 12, scale = 0)) })
	public LocUnitWsSchedIncreaseId getId() {
		return this.id;
	}

	public void setId(final LocUnitWsSchedIncreaseId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSCHEDULE_INDEX", nullable = false)
	public LocUnitWsSchedule getLocUnitWsSchedule() {
		return this.locUnitWsSchedule;
	}

	public void setLocUnitWsSchedule(final LocUnitWsSchedule locUnitWsSchedule) {
		this.locUnitWsSchedule = locUnitWsSchedule;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return this.locUnitWorkstation;
	}

	public void setLocUnitWorkstation(final LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NVALID_INDEX", nullable = false, insertable = false, updatable = false)
	public LocUnitPpmValidities getLocUnitPpmValidities() {
		return this.locUnitPpmValidities;
	}

	public void setLocUnitPpmValidities(final LocUnitPpmValidities locUnitPpmValidities) {
		this.locUnitPpmValidities = locUnitPpmValidities;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED", nullable = false, length = 7)
	public Date getDupdated() {
		return this.dupdated;
	}

	public void setDupdated(final Date dupdated) {
		this.dupdated = dupdated;
	}

	@Column(name = "CUPDATED_BY", nullable = false, length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}
