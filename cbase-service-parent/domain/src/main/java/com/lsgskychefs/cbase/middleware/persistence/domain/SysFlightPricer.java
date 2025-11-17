package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 17.05.2016 10:25:04 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table SYS_FLIGHT_PRICER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_FLIGHT_PRICER")
public class SysFlightPricer implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long njobNr;

	private long nresultKey;

	private Date ddeparture;

	private Date dcreated;

	private Date dstartComputing;

	private Date dstopComputing;

	private Integer nstatus;

	private Integer nfunction;

	private Integer nerror;

	private String cerror;

	private String cinstance;

	private String cmodified;

	private int nprocessStatus;

	private String csvcDatabase = " ";

	private String csvcTerminal = " ";

	private String csvcModule = " ";

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_FLIGHT_PRICER")
	@SequenceGenerator(name = "SEQ_SYS_FLIGHT_PRICER", sequenceName = "SEQ_SYS_FLIGHT_PRICER", allocationSize = 1)
	@Column(name = "NJOB_NR", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNjobNr() {
		return this.njobNr;
	}

	public void setNjobNr(final long njobNr) {
		this.njobNr = njobNr;
	}

	@Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)
	public long getNresultKey() {
		return this.nresultKey;
	}

	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DDEPARTURE", nullable = false, length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
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
	@Column(name = "DSTART_COMPUTING", length = 7)
	public Date getDstartComputing() {
		return this.dstartComputing;
	}

	public void setDstartComputing(final Date dstartComputing) {
		this.dstartComputing = dstartComputing;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DSTOP_COMPUTING", length = 7)
	public Date getDstopComputing() {
		return this.dstopComputing;
	}

	public void setDstopComputing(final Date dstopComputing) {
		this.dstopComputing = dstopComputing;
	}

	@Column(name = "NSTATUS", precision = 6, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "NFUNCTION", precision = 6, scale = 0)
	public Integer getNfunction() {
		return this.nfunction;
	}

	public void setNfunction(final Integer nfunction) {
		this.nfunction = nfunction;
	}

	@Column(name = "NERROR", precision = 6, scale = 0)
	public Integer getNerror() {
		return this.nerror;
	}

	public void setNerror(final Integer nerror) {
		this.nerror = nerror;
	}

	@Column(name = "CERROR", length = 2048)
	public String getCerror() {
		return this.cerror;
	}

	public void setCerror(final String cerror) {
		this.cerror = cerror;
	}

	@Column(name = "CINSTANCE", length = 30)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "CMODIFIED", length = 40)
	public String getCmodified() {
		return this.cmodified;
	}

	public void setCmodified(final String cmodified) {
		this.cmodified = cmodified;
	}

	@Column(name = "NPROCESS_STATUS", nullable = false, precision = 2, scale = 0)
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "CSVC_DATABASE", nullable = false, length = 20)
	public String getCsvcDatabase() {
		return this.csvcDatabase;
	}

	public void setCsvcDatabase(final String csvcDatabase) {
		this.csvcDatabase = CbaseMiddlewareStringUtils.defaultString(csvcDatabase);
	}

	@Column(name = "CSVC_TERMINAL", nullable = false, length = 20)
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(final String csvcTerminal) {
		this.csvcTerminal = CbaseMiddlewareStringUtils.defaultString(csvcTerminal);
	}

	@Column(name = "CSVC_MODULE", nullable = false, length = 50)
	public String getCsvcModule() {
		return this.csvcModule;
	}

	public void setCsvcModule(final String csvcModule) {
		this.csvcModule = CbaseMiddlewareStringUtils.defaultString(csvcModule);
	}

}
