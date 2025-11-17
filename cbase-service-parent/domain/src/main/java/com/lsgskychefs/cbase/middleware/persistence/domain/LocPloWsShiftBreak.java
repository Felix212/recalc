package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 3, 2018 4:59:37 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table LOC_PLO_WS_SHIFT_BREAK
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PLO_WS_SHIFT_BREAK")
public class LocPloWsShiftBreak implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	@JsonIgnore
	private LocPloWsShiftBreakId id;
	@JsonIgnore
	private LocUnitWorkstation locUnitWorkstation;
	private LocPloShift locPloShift;
	private LocPloBreak locPloBreak;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nworkstationKey", column = @Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nshiftKey", column = @Column(name = "NSHIFT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nbreakKey", column = @Column(name = "NBREAK_KEY", nullable = false, precision = 12, scale = 0)) })
	public LocPloWsShiftBreakId getId() {
		return this.id;
	}

	public void setId(final LocPloWsShiftBreakId id) {
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
	@JoinColumn(name = "NSHIFT_KEY", nullable = false, insertable = false, updatable = false)
	public LocPloShift getLocPloShift() {
		return this.locPloShift;
	}

	public void setLocPloShift(final LocPloShift locPloShift) {
		this.locPloShift = locPloShift;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NBREAK_KEY", nullable = false, insertable = false, updatable = false)
	public LocPloBreak getLocPloBreak() {
		return this.locPloBreak;
	}

	public void setLocPloBreak(final LocPloBreak locPloBreak) {
		this.locPloBreak = locPloBreak;
	}

}
