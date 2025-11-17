package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 24.06.2016 16:13:25 by Hibernate Tools 4.3.2-SNAPSHOT

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
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table LOC_PPS_OUTBOUND_REGION_VAL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_PPS_OUTBOUND_REGION_VAL", uniqueConstraints = @UniqueConstraint(columnNames = { "NOUTBOUND_REGION_KEY", "DVALID_FROM" }))
public class LocPpsOutboundRegionVal implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long noutboundRegionValKey;
	private LocPpsOutboundRegion locPpsOutboundRegion;
	private LocPpsEhbStation locPpsEhbStation;
	private Date dvalidFrom;
	private Date davlidTo;
	private Date dvalidTo;

	@Id
	@Column(name = "NOUTBOUND_REGION_VAL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNoutboundRegionValKey() {
		return this.noutboundRegionValKey;
	}

	public void setNoutboundRegionValKey(final long noutboundRegionValKey) {
		this.noutboundRegionValKey = noutboundRegionValKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NOUTBOUND_REGION_KEY")
	public LocPpsOutboundRegion getLocPpsOutboundRegion() {
		return this.locPpsOutboundRegion;
	}

	public void setLocPpsOutboundRegion(final LocPpsOutboundRegion locPpsOutboundRegion) {
		this.locPpsOutboundRegion = locPpsOutboundRegion;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEHB_STATION_KEY")
	public LocPpsEhbStation getLocPpsEhbStation() {
		return this.locPpsEhbStation;
	}

	public void setLocPpsEhbStation(final LocPpsEhbStation locPpsEhbStation) {
		this.locPpsEhbStation = locPpsEhbStation;
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
	@Column(name = "DAVLID_TO", length = 7)
	public Date getDavlidTo() {
		return this.davlidTo;
	}

	public void setDavlidTo(final Date davlidTo) {
		this.davlidTo = davlidTo;
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
