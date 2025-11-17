package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.05.2016 11:54:46 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table SYS_QUEUE_FLIGHT_PAX
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_QUEUE_FLIGHT_PAX")
public class SysQueueFlightPax implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysQueueFlightPaxId id;
	private SysQueueFlightCalc sysQueueFlightCalc;
	private int npax;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "njobNr", column = @Column(name = "NJOB_NR", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cclass", column = @Column(name = "CCLASS", nullable = false, length = 10)) })
	public SysQueueFlightPaxId getId() {
		return this.id;
	}

	public void setId(final SysQueueFlightPaxId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false, insertable = false, updatable = false)
	public SysQueueFlightCalc getSysQueueFlightCalc() {
		return this.sysQueueFlightCalc;
	}

	public void setSysQueueFlightCalc(final SysQueueFlightCalc sysQueueFlightCalc) {
		this.sysQueueFlightCalc = sysQueueFlightCalc;
		sysQueueFlightCalc.getSysQueueFlightPaxes().add(this);
	}

	@Column(name = "NPAX", nullable = false, precision = 4, scale = 0)
	public int getNpax() {
		return this.npax;
	}

	public void setNpax(final int npax) {
		this.npax = npax;
	}

}
