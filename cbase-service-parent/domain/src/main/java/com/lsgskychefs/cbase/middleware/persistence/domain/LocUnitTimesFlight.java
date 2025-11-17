package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table LOC_UNIT_TIMES_FLIGHT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TIMES_FLIGHT")
public class LocUnitTimesFlight implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private LocUnitTimesFlightId id;
	private CenAirlines cenAirlines;
	private int nrampTime;
	private int nkitchenTime;
	private Integer ndeliveryTime;

	public LocUnitTimesFlight() {
	}

	public LocUnitTimesFlight(final LocUnitTimesFlightId id, final CenAirlines cenAirlines, final int nrampTime, final int nkitchenTime) {
		this.id = id;
		this.cenAirlines = cenAirlines;
		this.nrampTime = nrampTime;
		this.nkitchenTime = nkitchenTime;
	}

	public LocUnitTimesFlight(final LocUnitTimesFlightId id, final CenAirlines cenAirlines, final int nrampTime, final int nkitchenTime,
			final Integer ndeliveryTime) {
		this.id = id;
		this.cenAirlines = cenAirlines;
		this.nrampTime = nrampTime;
		this.nkitchenTime = nkitchenTime;
		this.ndeliveryTime = ndeliveryTime;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nflightNumber",
					column = @Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "csuffix", column = @Column(name = "CSUFFIX", nullable = false, length = 1)) })
	public LocUnitTimesFlightId getId() {
		return this.id;
	}

	public void setId(final LocUnitTimesFlightId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(final CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "NRAMP_TIME", nullable = false, precision = 3, scale = 0)
	public int getNrampTime() {
		return this.nrampTime;
	}

	public void setNrampTime(final int nrampTime) {
		this.nrampTime = nrampTime;
	}

	@Column(name = "NKITCHEN_TIME", nullable = false, precision = 3, scale = 0)
	public int getNkitchenTime() {
		return this.nkitchenTime;
	}

	public void setNkitchenTime(final int nkitchenTime) {
		this.nkitchenTime = nkitchenTime;
	}

	@Column(name = "NDELIVERY_TIME", precision = 4, scale = 0)
	public Integer getNdeliveryTime() {
		return this.ndeliveryTime;
	}

	public void setNdeliveryTime(final Integer ndeliveryTime) {
		this.ndeliveryTime = ndeliveryTime;
	}

}
