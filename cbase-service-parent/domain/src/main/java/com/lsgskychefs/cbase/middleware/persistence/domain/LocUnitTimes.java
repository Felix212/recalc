package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 05.07.2016 12:57:48 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;

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
 * Entity(DomainObject) for table LOC_UNIT_TIMES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_TIMES")
public class LocUnitTimes implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitTimesId id;
	private CenAirlines cenAirlines;
	private CenRouting cenRouting;
	private int nrampTime;
	private int nkitchenTime;
	private Integer ndeliveryTime;
	private String cto;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "cclient", column = @Column(name = "CCLIENT", nullable = false, length = 3)),
			@AttributeOverride(name = "cunit", column = @Column(name = "CUNIT", nullable = false, length = 4)),
			@AttributeOverride(name = "nairlineKey", column = @Column(name = "NAIRLINE_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nroutingId", column = @Column(name = "NROUTING_ID", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cfrom", column = @Column(name = "CFROM", nullable = false, length = 5)) })
	public LocUnitTimesId getId() {
		return this.id;
	}

	public void setId(final LocUnitTimesId id) {
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROUTING_ID", nullable = false, insertable = false, updatable = false)
	public CenRouting getCenRouting() {
		return this.cenRouting;
	}

	public void setCenRouting(final CenRouting cenRouting) {
		this.cenRouting = cenRouting;
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

	@Column(name = "CTO", nullable = false, length = 5)
	public String getCto() {
		return this.cto;
	}

	public void setCto(final String cto) {
		this.cto = cto;
	}

}
