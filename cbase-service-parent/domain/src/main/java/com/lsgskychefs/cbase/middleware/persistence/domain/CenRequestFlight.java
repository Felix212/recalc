package com.lsgskychefs.cbase.middleware.persistence.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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

/**
 * Entity(DomainObject) for table CEN_REQUEST_FLIGHT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_FLIGHT")
public class CenRequestFlight
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nreqFlightKey;
	private CenRequest cenRequest;
	private String cairline;
	private int nflightNumber;
	private String csuffix;
	private Date ddepartureLocal;
	private String cdepartureTimeLocal;
	private String cairlineOwner;
	private String cactype;
	private String cregistration;
	private String cconfiguration;
	private String ctlcFrom;
	private String ctlcTo;
	private Date darrivalDateLocal;
	private String carrivalTimeLocal;
	private String cdescription;
	private String cacsubtype;
	private Long naircraftKey;
	private String cconfigCode;
	private Set<CenRequestPreorder> cenRequestPreorders = new HashSet<CenRequestPreorder>(0);
	private Set<CenRequestPax> cenRequestPaxes = new HashSet<CenRequestPax>(0);
	private Set<CenRequestSpml> cenRequestSpmls = new HashSet<CenRequestSpml>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REQUEST_FLIGHT")
	@SequenceGenerator(name = "SEQ_CEN_REQUEST_FLIGHT", sequenceName = "SEQ_CEN_REQUEST_FLIGHT", allocationSize = 1)
	@Column(name = "NREQ_FLIGHT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNreqFlightKey() {
		return this.nreqFlightKey;
	}

	public void setNreqFlightKey(final long nreqFlightKey) {
		this.nreqFlightKey = nreqFlightKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NJOB_NR", nullable = false)
	public CenRequest getCenRequest() {
		return this.cenRequest;
	}

	public void setCenRequest(final CenRequest cenRequest) {
		this.cenRequest = cenRequest;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6, scale = 0)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE_LOCAL", nullable = false, length = 7)
	public Date getDdepartureLocal() {
		return this.ddepartureLocal;
	}

	public void setDdepartureLocal(final Date ddepartureLocal) {
		this.ddepartureLocal = ddepartureLocal;
	}

	@Column(name = "CDEPARTURE_TIME_LOCAL", nullable = false, length = 5)
	public String getCdepartureTimeLocal() {
		return this.cdepartureTimeLocal;
	}

	public void setCdepartureTimeLocal(final String cdepartureTimeLocal) {
		this.cdepartureTimeLocal = cdepartureTimeLocal;
	}

	@Column(name = "CAIRLINE_OWNER", nullable = false, length = 6)
	public String getCairlineOwner() {
		return this.cairlineOwner;
	}

	public void setCairlineOwner(final String cairlineOwner) {
		this.cairlineOwner = cairlineOwner;
	}

	@Column(name = "CACTYPE", nullable = false, length = 10)
	public String getCactype() {
		return this.cactype;
	}

	public void setCactype(final String cactype) {
		this.cactype = cactype;
	}

	@Column(name = "CREGISTRATION", length = 10)
	public String getCregistration() {
		return this.cregistration;
	}

	public void setCregistration(final String cregistration) {
		this.cregistration = cregistration;
	}

	@Column(name = "CCONFIGURATION", nullable = false, length = 40)
	public String getCconfiguration() {
		return this.cconfiguration;
	}

	public void setCconfiguration(final String cconfiguration) {
		this.cconfiguration = cconfiguration;
	}

	@Column(name = "CTLC_FROM", nullable = false, length = 3)
	public String getCtlcFrom() {
		return this.ctlcFrom;
	}

	public void setCtlcFrom(final String ctlcFrom) {
		this.ctlcFrom = ctlcFrom;
	}

	@Column(name = "CTLC_TO", nullable = false, length = 3)
	public String getCtlcTo() {
		return this.ctlcTo;
	}

	public void setCtlcTo(final String ctlcTo) {
		this.ctlcTo = ctlcTo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DARRIVAL_DATE_LOCAL", nullable = false, length = 7)
	public Date getDarrivalDateLocal() {
		return this.darrivalDateLocal;
	}

	public void setDarrivalDateLocal(final Date darrivalDateLocal) {
		this.darrivalDateLocal = darrivalDateLocal;
	}

	@Column(name = "CARRIVAL_TIME_LOCAL", nullable = false, length = 5)
	public String getCarrivalTimeLocal() {
		return this.carrivalTimeLocal;
	}

	public void setCarrivalTimeLocal(final String carrivalTimeLocal) {
		this.carrivalTimeLocal = carrivalTimeLocal;
	}

	@Column(name = "CDESCRIPTION", length = 40)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CACSUBTYPE", length = 20)
	public String getCacsubtype() {
		return this.cacsubtype;
	}

	public void setCacsubtype(final String cacsubtype) {
		this.cacsubtype = cacsubtype;
	}

	@Column(name = "NAIRCRAFT_KEY", precision = 12, scale = 0)
	public Long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final Long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "CCONFIG_CODE", length = 20)
	public String getCconfigCode() {
		return this.cconfigCode;
	}

	public void setCconfigCode(final String cconfigCode) {
		this.cconfigCode = cconfigCode;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRequestFlight")
	public Set<CenRequestPreorder> getCenRequestPreorders() {
		return this.cenRequestPreorders;
	}

	public void setCenRequestPreorders(final Set<CenRequestPreorder> cenRequestPreorders) {
		this.cenRequestPreorders = cenRequestPreorders;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRequestFlight")
	public Set<CenRequestPax> getCenRequestPaxes() {
		return this.cenRequestPaxes;
	}

	public void setCenRequestPaxes(final Set<CenRequestPax> cenRequestPaxes) {
		this.cenRequestPaxes = cenRequestPaxes;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenRequestFlight")
	public Set<CenRequestSpml> getCenRequestSpmls() {
		return this.cenRequestSpmls;
	}

	public void setCenRequestSpmls(final Set<CenRequestSpml> cenRequestSpmls) {
		this.cenRequestSpmls = cenRequestSpmls;
	}

}
