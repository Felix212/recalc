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
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_REQUEST_OUT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_REQUEST_OUT")
public class CenRequestOut
		implements com.lsgskychefs.cbase.middleware.persistence.domain.DomainObject, java.io.Serializable {

	private long njobNr;
	private String chostname;
	private String cclient;
	private String cunit;
	private long nrequestType;
	private long nresultKey;
	private Long ntransaction;
	private String cairline;
	private int nflightNumber;
	private String csuffix;
	private Date ddeparture;
	private String cdepartureTime;
	private Date ddepartureLocal;
	private String cdepartureTimeLocal;
	private String ctlcFrom;
	private String ctlcTo;
	private Date dcreated;
	private Date dsent;
	private Date dconfirmed;
	private Integer nstatus;
	private String cerrorText;
	private long nretry;
	private String cflightKey;
	private Long naircraftKey;
	private String cpantrycode;
	private int nweightExceeded;
	private Set<CenRequestOutPax> cenRequestOutPaxes = new HashSet<CenRequestOutPax>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_REQUEST_OUT")
	@SequenceGenerator(name = "SEQ_CEN_REQUEST_OUT", sequenceName = "SEQ_CEN_REQUEST_OUT", allocationSize = 1)
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@Column(name = "CHOSTNAME", nullable = false, length = 80)
	public String getChostname() {
		return this.chostname;
	}

	public void setChostname(final String chostname) {
		this.chostname = chostname;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NREQUEST_TYPE", nullable = false, precision = 1)
	public long getNrequestType() {
		return this.nrequestType;
	}

	public void setNrequestType(final long nrequestType) {
		this.nrequestType = nrequestType;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Column(name = "NTRANSACTION", precision = 12)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Column(name = "CAIRLINE", nullable = false, length = 6)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "NFLIGHT_NUMBER", nullable = false, precision = 6)
	public int getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final int nflightNumber) {
		this.nflightNumber = nflightNumber;
	}

	@Column(name = "CSUFFIX", nullable = false, length = 3)
	public String getCsuffix() {
		return this.csuffix;
	}

	public void setCsuffix(final String csuffix) {
		this.csuffix = csuffix;
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
	@Column(name = "DCREATED", nullable = false, length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSENT", length = 7)
	public Date getDsent() {
		return this.dsent;
	}

	public void setDsent(final Date dsent) {
		this.dsent = dsent;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCONFIRMED", length = 7)
	public Date getDconfirmed() {
		return this.dconfirmed;
	}

	public void setDconfirmed(final Date dconfirmed) {
		this.dconfirmed = dconfirmed;
	}

	@Column(name = "NSTATUS", precision = 6)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "CERROR_TEXT", length = 128)
	public String getCerrorText() {
		return this.cerrorText;
	}

	public void setCerrorText(final String cerrorText) {
		this.cerrorText = cerrorText;
	}

	@Column(name = "NRETRY", nullable = false, precision = 12)
	public long getNretry() {
		return this.nretry;
	}

	public void setNretry(final long nretry) {
		this.nretry = nretry;
	}

	@Column(name = "CFLIGHT_KEY", length = 30)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NAIRCRAFT_KEY", precision = 12)
	public Long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final Long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "CPANTRYCODE", length = 10)
	public String getCpantrycode() {
		return this.cpantrycode;
	}

	public void setCpantrycode(final String cpantrycode) {
		this.cpantrycode = cpantrycode;
	}

	@Column(name = "NWEIGHT_EXCEEDED", nullable = false, precision = 1)
	public int getNweightExceeded() {
		return this.nweightExceeded;
	}

	public void setNweightExceeded(final int nweightExceeded) {
		this.nweightExceeded = nweightExceeded;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "cenRequestOut")
	public Set<CenRequestOutPax> getCenRequestOutPaxes() {
		return this.cenRequestOutPaxes;
	}

	public void setCenRequestOutPaxes(final Set<CenRequestOutPax> cenRequestOutPaxes) {
		this.cenRequestOutPaxes = cenRequestOutPaxes;
	}

}
