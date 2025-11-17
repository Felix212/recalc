package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table CEN_EU_FLIGHTS_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_FLIGHTS_DETAIL")
public class CenEuFlightsDetail implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neuFlightsDetailKey;
	private CenEuFlights cenEuFlights;
	private String cclass;
	private String cpackinglist;
	private String ctext;
	private String ctextLoc;
	private BigDecimal nquantity;
	private Date dtimestamp;
	private Set<CenEuFlightsItems> cenEuFlightsItemses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_EU_FLIGHTS_DETAIL")
	@SequenceGenerator(name = "SEQ_CEN_EU_FLIGHTS_DETAIL", sequenceName = "SEQ_CEN_EU_FLIGHTS_DETAIL", allocationSize = 1)
	@Column(name = "NEU_FLIGHTS_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuFlightsDetailKey() {
		return this.neuFlightsDetailKey;
	}

	public void setNeuFlightsDetailKey(final long neuFlightsDetailKey) {
		this.neuFlightsDetailKey = neuFlightsDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_FLIGHTS_KEY", nullable = false)
	public CenEuFlights getCenEuFlights() {
		return this.cenEuFlights;
	}

	public void setCenEuFlights(final CenEuFlights cenEuFlights) {
		this.cenEuFlights = cenEuFlights;
	}

	@Column(name = "CCLASS", nullable = false, length = 3)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(final String cclass) {
		this.cclass = CbaseMiddlewareStringUtils.defaultString(cclass);
	}

	@Column(name = "CPACKINGLIST", nullable = false, length = 18)
	public String getCpackinglist() {
		return this.cpackinglist;
	}

	public void setCpackinglist(final String cpackinglist) {
		this.cpackinglist = cpackinglist;
	}

	@Size(max = 70)
	@Column(name = "CTEXT", nullable = false, length = 70)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Size(max = 70)
	@Column(name = "CTEXT_LOC", nullable = false, length = 70)
	public String getCtextLoc() {
		return this.ctextLoc;
	}

	public void setCtextLoc(final String ctextLoc) {
		this.ctextLoc = CbaseMiddlewareStringUtils.defaultString(ctextLoc);
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 12, scale = 3)
	public BigDecimal getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(final BigDecimal nquantity) {
		this.nquantity = nquantity;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEuFlightsDetail", cascade = CascadeType.PERSIST)
	public Set<CenEuFlightsItems> getCenEuFlightsItemses() {
		return this.cenEuFlightsItemses;
	}

	public void setCenEuFlightsItemses(final Set<CenEuFlightsItems> cenEuFlightsItemses) {
		this.cenEuFlightsItemses = cenEuFlightsItemses;
	}

}
