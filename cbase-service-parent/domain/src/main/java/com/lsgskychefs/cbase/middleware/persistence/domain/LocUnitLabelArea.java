package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table LOC_UNIT_LABEL_AREA
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_LABEL_AREA")
public class LocUnitLabelArea implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private LocUnitLabelAreaId id;
	private LocUnitWorkstation locUnitWorkstation;
	private LocUnitLabelGroups locUnitLabelGroups;
	private Date dvalidTo;

	public LocUnitLabelArea() {
	}

	public LocUnitLabelArea(final LocUnitLabelAreaId id, final LocUnitWorkstation locUnitWorkstation,
			final LocUnitLabelGroups locUnitLabelGroups, final Date dvalidTo) {
		this.id = id;
		this.locUnitWorkstation = locUnitWorkstation;
		this.locUnitLabelGroups = locUnitLabelGroups;
		this.dvalidTo = dvalidTo;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nworkstationKey",
					column = @Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nlabelGroupKey",
					column = @Column(name = "NLABEL_GROUP_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidFrom", column = @Column(name = "DVALID_FROM", nullable = false, length = 7)) })
	public LocUnitLabelAreaId getId() {
		return this.id;
	}

	public void setId(final LocUnitLabelAreaId id) {
		this.id = id;
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
	@JoinColumn(name = "NLABEL_GROUP_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitLabelGroups getLocUnitLabelGroups() {
		return this.locUnitLabelGroups;
	}

	public void setLocUnitLabelGroups(final LocUnitLabelGroups locUnitLabelGroups) {
		this.locUnitLabelGroups = locUnitLabelGroups;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(final Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

}
