package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
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

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table CEN_EU_FLIGHTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EU_FLIGHTS")
public class CenEuFlights implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long neuFlightsKey;
	private SysEuRegions sysEuRegions;
	private String cunit;
	private String cairline;
	private int nflightNumber;
	private String csuffix;
	private Date ddeparture;
	private String cdepartureTime;
	/** DepartureStation as Three-Letter-Code */
	private String ctlcFrom;
	/** ArrivalStation as Three-Letter-Code */
	private String ctlcTo;
	/**
	 * Other format than in the rest of the application <br>
	 * yymmddHHmm[ALC-Code] [Flugnummer 4Stellen][Suffix 1Stelle][Service Flugnummer 4Stellen][Service-Suffix 1Stelle][TLCFrom][TLCTo]
	 */
	private String cflightKey;
	private String caircraftType;
	private Date dtimestamp;
	private int nservFlightNumber;
	private String cservSuffix;
	private String ccreatedBy;
	private Date dcreatedDate;
	private Set<CenEuFlightsDetail> cenEuFlightsDetails = new HashSet<>(0);
	private long neuRegionKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_EU_FLIGHTS")
	@SequenceGenerator(name = "SEQ_CEN_EU_FLIGHTS", sequenceName = "SEQ_CEN_EU_FLIGHTS", allocationSize = 1)
	@Column(name = "NEU_FLIGHTS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNeuFlightsKey() {
		return this.neuFlightsKey;
	}

	public void setNeuFlightsKey(final long neuFlightsKey) {
		this.neuFlightsKey = neuFlightsKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEU_REGION_KEY", nullable = false)
	public SysEuRegions getSysEuRegions() {
		return this.sysEuRegions;
	}

	public void setSysEuRegions(final SysEuRegions sysEuRegions) {
		this.sysEuRegions = sysEuRegions;
		this.neuRegionKey = sysEuRegions.getNeuRegionKey();
	}

	@Column(name = "CUNIT", nullable = false, length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = CbaseMiddlewareStringUtils.defaultString(cunit);
	}

	@Column(name = "CAIRLINE", nullable = false, length = 3)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 4, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 1)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = CbaseMiddlewareStringUtils.defaultString(csuffix);

	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CDEPARTURE_TIME", nullable = false, length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	/**
	 * Gets the departureStation as Three-Letter-Code.
	 *
	 * @return the departureStation as Three-Letter-Code
	 */
	@Column(name = "CTLC_FROM", nullable = false, length = 6)
	public String getCtlcFrom() {
		return this.ctlcFrom;
	}

	/**
	 * Sets the departureStation as Three-Letter-Code (Test).
	 *
	 * @param ctlcFrom the new departureStation as Three-Letter-Code (Test)
	 */
	public void setCtlcFrom(final String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	@Column(name = "CTLC_TO", nullable = false, length = 6)
	public String getCtlcTo() {
		return this.ctlcTo;
	}

	public void setCtlcTo(final String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	@Column(name = "CFLIGHT_KEY", nullable = false, length = 35)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "CAIRCRAFT_TYPE", nullable = false, length = 10)
	public String getCaircraftType() {
		return this.caircraftType;
	}

	public void setCaircraftType(final String caircraftType) {
		this.caircraftType = caircraftType;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "NSERV_FLIGHT_NUMBER", nullable = false, precision = 4, scale = 0)
	public int getNservFlightNumber() {
		return this.nservFlightNumber;
	}

	public void setNservFlightNumber(final int nservFlightNumber) {
		this.nservFlightNumber = nservFlightNumber;
	}

	@Column(name = "CSERV_SUFFIX", nullable = false, length = 1)
	public String getCservSuffix() {
		return this.cservSuffix;
	}

	public void setCservSuffix(final String cservSuffix) {
		this.cservSuffix = CbaseMiddlewareStringUtils.defaultString(cservSuffix);

	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEuFlights", cascade = CascadeType.ALL, orphanRemoval = true)
	public Set<CenEuFlightsDetail> getCenEuFlightsDetails() {
		return this.cenEuFlightsDetails;
	}

	public void setCenEuFlightsDetails(final Set<CenEuFlightsDetail> cenEuFlightsDetails) {
		this.cenEuFlightsDetails = cenEuFlightsDetails;
	}

	/**
	 * Get neuRegionKey
	 *
	 * @return the neuRegionKey
	 */
	@Column(name = "NEU_REGION_KEY", nullable = false, insertable = false, updatable = false)
	public long getNeuRegionKey() {
		return neuRegionKey;
	}

	/**
	 * set neuRegionKey
	 *
	 * @param neuRegionKey the neuRegionKey to set
	 */
	public void setNeuRegionKey(final long neuRegionKey) {
		this.neuRegionKey = neuRegionKey;
	}

}
