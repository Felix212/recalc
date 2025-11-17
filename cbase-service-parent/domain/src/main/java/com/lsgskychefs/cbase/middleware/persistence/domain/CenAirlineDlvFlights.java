package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.11.2024 11:28:24 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_AIRLINE_DLV_FLIGHTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRLINE_DLV_FLIGHTS")
public class CenAirlineDlvFlights implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nairlineDlvFlightsKey;
	private CenAirlines cenAirlines;
	private int nflgnrFrom;
	private int nflgnrTo;
	private Date dvalidFrom;
	private Date dvalidTo;

	@Id
	@Column(name = "NAIRLINE_DLV_FLIGHTS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlineDlvFlightsKey() {
		return this.nairlineDlvFlightsKey;
	}

	public void setNairlineDlvFlightsKey(long nairlineDlvFlightsKey) {
		this.nairlineDlvFlightsKey = nairlineDlvFlightsKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	public CenAirlines getCenAirlines() {
		return this.cenAirlines;
	}

	public void setCenAirlines(CenAirlines cenAirlines) {
		this.cenAirlines = cenAirlines;
	}

	@Column(name = "NFLGNR_FROM", nullable = false, precision = 4, scale = 0)
	public int getNflgnrFrom() {
		return this.nflgnrFrom;
	}

	public void setNflgnrFrom(int nflgnrFrom) {
		this.nflgnrFrom = nflgnrFrom;
	}

	@Column(name = "NFLGNR_TO", nullable = false, precision = 4, scale = 0)
	public int getNflgnrTo() {
		return this.nflgnrTo;
	}

	public void setNflgnrTo(int nflgnrTo) {
		this.nflgnrTo = nflgnrTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

}


