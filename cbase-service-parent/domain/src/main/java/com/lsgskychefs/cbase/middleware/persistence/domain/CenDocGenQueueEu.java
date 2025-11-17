package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 26.04.2016 12:39:10 by Hibernate Tools 4.3.2-SNAPSHOT

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

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE_EU
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE_EU")
public class CenDocGenQueueEu implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndocGenQueueKeyEu;

	private long neuFlightsKey;

	private long neuRegionKey;

	private long nversion;

	private Date dtimestamp;

	private Date djobStart;

	private Date djobEnd;

	private String cairline;

	private String cunit;

	private String cinstance;

	private Integer njobType;

	private long nuserId;

	private String cusername;

	private Integer nprocessStatus;

	private String csvcDatabase = " ";

	private String csvcTerminal = " ";

	private String csvcModule = " ";

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_QUEUE_EU")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_QUEUE_EU", sequenceName = "SEQ_CEN_DOC_GEN_QUEUE_EU", allocationSize = 1)
	@Column(name = "NDOC_GEN_QUEUE_KEY_EU", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocGenQueueKeyEu() {
		return this.ndocGenQueueKeyEu;
	}

	public void setNdocGenQueueKeyEu(final long ndocGenQueueKeyEu) {
		this.ndocGenQueueKeyEu = ndocGenQueueKeyEu;
	}

	@Column(name = "NEU_FLIGHTS_KEY", nullable = false, precision = 12, scale = 0)
	public long getNeuFlightsKey() {
		return this.neuFlightsKey;
	}

	public void setNeuFlightsKey(final long neuFlightsKey) {
		this.neuFlightsKey = neuFlightsKey;
	}

	@Column(name = "NEU_REGION_KEY", nullable = false, precision = 12, scale = 0)
	public long getNeuRegionKey() {
		return this.neuRegionKey;
	}

	public void setNeuRegionKey(final long neuRegionKey) {
		this.neuRegionKey = neuRegionKey;
	}

	@Column(name = "NVERSION", nullable = false, precision = 12, scale = 0)
	public long getNversion() {
		return this.nversion;
	}

	public void setNversion(final long nversion) {
		this.nversion = nversion;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_START", length = 7)
	public Date getDjobStart() {
		return this.djobStart;
	}

	public void setDjobStart(final Date djobStart) {
		this.djobStart = djobStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_END", length = 7)
	public Date getDjobEnd() {
		return this.djobEnd;
	}

	public void setDjobEnd(final Date djobEnd) {
		this.djobEnd = djobEnd;
	}

	@Column(name = "CAIRLINE", length = 10)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@Column(name = "CUNIT", length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CINSTANCE", length = 80)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "NJOB_TYPE", precision = 1, scale = 0)
	public Integer getNjobType() {
		return this.njobType;
	}

	public void setNjobType(final Integer njobType) {
		this.njobType = njobType;
	}

	@Column(name = "NUSER_ID", precision = 12, scale = 0)
	public long getNuserId() {
		return this.nuserId;
	}

	public void setNuserId(final long nuserId) {
		this.nuserId = nuserId;
	}

	@Column(name = "CUSERNAME", length = 40)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(final String cusername) {
		this.cusername = cusername;
	}

	@Column(name = "NPROCESS_STATUS", precision = 4, scale = 0)
	public Integer getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final Integer nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "CSVC_DATABASE", nullable = false, length = 20)
	public String getCsvcDatabase() {
		return this.csvcDatabase;
	}

	public void setCsvcDatabase(final String csvcDatabase) {
		this.csvcDatabase = csvcDatabase;
	}

	@Column(name = "CSVC_TERMINAL", nullable = false, length = 20)
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(final String csvcTerminal) {
		this.csvcTerminal = csvcTerminal;
	}

	@Column(name = "CSVC_MODULE", nullable = false, length = 50)
	public String getCsvcModule() {
		return this.csvcModule;
	}

	public void setCsvcModule(final String csvcModule) {
		this.csvcModule = csvcModule;
	}

}
