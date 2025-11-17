package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 26.08.2019 13:34:33 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_OUT_PPM_FLIGHTS_CSOST
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_PPM_FLIGHTS_CSOST")
public class CenOutPpmFlightsCsost implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nppmFlightsCsostateKey;

	@JsonIgnore
	private CenOutPpmFlights cenOutPpmFlights;

	private boolean ncsoFlightClosed;

	private String ccsoUser;

	private Date dcsoDate;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_PPM_FLIGHTS_CSOST")
	@SequenceGenerator(name = "SEQ_CEN_OUT_PPM_FLIGHTS_CSOST", sequenceName = "SEQ_CEN_OUT_PPM_FLIGHTS_CSOST", allocationSize = 1)

	@Column(name = "NPPM_FLIGHTS_CSOSTATE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNppmFlightsCsostateKey() {
		return this.nppmFlightsCsostateKey;
	}

	public void setNppmFlightsCsostateKey(final long nppmFlightsCsostateKey) {
		this.nppmFlightsCsostateKey = nppmFlightsCsostateKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false) })
	public CenOutPpmFlights getCenOutPpmFlights() {
		return this.cenOutPpmFlights;
	}

	public void setCenOutPpmFlights(final CenOutPpmFlights cenOutPpmFlights) {
		this.cenOutPpmFlights = cenOutPpmFlights;
	}

	@Column(name = "NCSO_FLIGHT_CLOSED", nullable = false, precision = 1, scale = 0)
	public boolean isNcsoFlightClosed() {
		return this.ncsoFlightClosed;
	}

	public void setNcsoFlightClosed(final boolean ncsoFlightClosed) {
		this.ncsoFlightClosed = ncsoFlightClosed;
	}

	@Column(name = "CCSO_USER", length = 40)
	public String getCcsoUser() {
		return this.ccsoUser;
	}

	public void setCcsoUser(final String ccsoUser) {
		this.ccsoUser = ccsoUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCSO_DATE", length = 7)
	public Date getDcsoDate() {
		return this.dcsoDate;
	}

	public void setDcsoDate(final Date dcsoDate) {
		this.dcsoDate = dcsoDate;
	}

}
