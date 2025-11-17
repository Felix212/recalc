package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Feb 16, 2023 6:57:52 PM by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_UNIT_PL_AREA_PRESET_SCHEDULE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_PL_AREA_PRESET_SCHEDULE"
)
public class LocUnitPlAreaPresetSchedule implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplAreaPresetScheduleKey;
	@JsonIgnore
	private LocUnitPlAreaPreset locUnitPlAreaPreset;
	private long nworkscheduleIndex;
	private long nprodtimeframeIndex;
	private int noffset;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_PL_AREA_PRESET_SCHEDULE")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_PL_AREA_PRESET_SCHEDULE", sequenceName = "SEQ_LOC_UNIT_PL_AREA_PRESET_SCHEDULE", allocationSize = 1)
	@Column(name = "NPL_AREA_PRESET_SCHEDULE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplAreaPresetScheduleKey() {
		return this.nplAreaPresetScheduleKey;
	}

	public void setNplAreaPresetScheduleKey(long nplAreaPresetScheduleKey) {
		this.nplAreaPresetScheduleKey = nplAreaPresetScheduleKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_AREA_PRESET_KEY", nullable = false)
	public LocUnitPlAreaPreset getLocUnitPlAreaPreset() {
		return this.locUnitPlAreaPreset;
	}

	public void setLocUnitPlAreaPreset(LocUnitPlAreaPreset locUnitPlAreaPreset) {
		this.locUnitPlAreaPreset = locUnitPlAreaPreset;
	}

	@Column(name = "NWORKSCHEDULE_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNworkscheduleIndex() {
		return this.nworkscheduleIndex;
	}

	public void setNworkscheduleIndex(long nworkscheduleIndex) {
		this.nworkscheduleIndex = nworkscheduleIndex;
	}

	@Column(name = "NPRODTIMEFRAME_INDEX", nullable = false, precision = 12, scale = 0)
	public long getNprodtimeframeIndex() {
		return this.nprodtimeframeIndex;
	}

	public void setNprodtimeframeIndex(long nprodtimeframeIndex) {
		this.nprodtimeframeIndex = nprodtimeframeIndex;
	}

	@Column(name = "NOFFSET", nullable = false, precision = 3, scale = 0)
	public int getNoffset() {
		return this.noffset;
	}

	public void setNoffset(int noffset) {
		this.noffset = noffset;
	}

}


