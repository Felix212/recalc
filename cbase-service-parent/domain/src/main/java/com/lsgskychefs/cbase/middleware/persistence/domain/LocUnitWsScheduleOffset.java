package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jun 8, 2022 6:35:04 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table LOC_UNIT_WS_SCHEDULE_OFFSET
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_WS_SCHEDULE_OFFSET")
public class LocUnitWsScheduleOffset implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitWsScheduleOffsetId id;
	private LocUnitWsSchedule locUnitWsSchedule;
	private Long ncolor;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nworkscheduleIndex", column = @Column(name = "NWORKSCHEDULE_INDEX", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "noffset", column = @Column(name = "NOFFSET", nullable = false, precision = 3, scale = 0)) })
	public LocUnitWsScheduleOffsetId getId() {
		return this.id;
	}

	public void setId(final LocUnitWsScheduleOffsetId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSCHEDULE_INDEX", nullable = false, insertable = false, updatable = false)
	public LocUnitWsSchedule getLocUnitWsSchedule() {
		return this.locUnitWsSchedule;
	}

	public void setLocUnitWsSchedule(final LocUnitWsSchedule locUnitWsSchedule) {
		this.locUnitWsSchedule = locUnitWsSchedule;
	}

	@Column(name = "NCOLOR", precision = 12, scale = 0)
	public Long getNcolor() {
		return this.ncolor;
	}

	public void setNcolor(final Long ncolor) {
		this.ncolor = ncolor;
	}

}
