package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.03.2024 16:20:08 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table LOC_UNIT_CHECKPT_WORKSTATIONS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CHECKPT_WORKSTATIONS")
public class LocUnitCheckptWorkstations implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private LocUnitCheckptWorkstationsId id;
	private LocUnitCheckpt locUnitCheckpt;
	private LocUnitWorkstation locUnitWorkstation;
	private Date dvalidto;
	private int nsort;

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "ncheckpointKey", column = @Column(name = "NCHECKPOINT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nworkstationKey", column = @Column(name = "NWORKSTATION_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "dvalidfrom", column = @Column(name = "DVALIDFROM", nullable = false, length = 7)) })
	public LocUnitCheckptWorkstationsId getId() {
		return this.id;
	}

	public void setId(LocUnitCheckptWorkstationsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCHECKPOINT_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitCheckpt getLocUnitCheckpt() {
		return this.locUnitCheckpt;
	}

	public void setLocUnitCheckpt(LocUnitCheckpt locUnitCheckpt) {
		this.locUnitCheckpt = locUnitCheckpt;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NWORKSTATION_KEY", nullable = false, insertable = false, updatable = false)
	public LocUnitWorkstation getLocUnitWorkstation() {
		return this.locUnitWorkstation;
	}

	public void setLocUnitWorkstation(LocUnitWorkstation locUnitWorkstation) {
		this.locUnitWorkstation = locUnitWorkstation;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALIDTO", nullable = false, length = 7)
	public Date getDvalidto() {
		return this.dvalidto;
	}

	public void setDvalidto(Date dvalidto) {
		this.dvalidto = dvalidto;
	}

	@Column(name = "NSORT", nullable = false, precision = 5, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(int nsort) {
		this.nsort = nsort;
	}

}



