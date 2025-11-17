package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 04.04.2016 14:42:42 by Hibernate Tools 4.3.2-SNAPSHOT

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
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE_MD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE_MD")
public class CenDocGenQueueMd implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndocGenQueueMdKey;
	private String csection;
	private String cuser;
	private String cclientname;
	private String cbrowser;
	private String cunit;
	private Long nairlineKey;
	private Long nflightNumber;
	private String csuffix;
	private Date ddeparture;
	private String cdepartureTime;
	private Long naircraftKey;
	private Long ntlcFrom;
	private Long ntlcTo;
	private String cclient;
	private Long nlayoutKey;
	private Integer nprocessStatus;
	private Date dcreated;
	private Date djobStart;
	private Date djobEnd;
	private String cinstance;
	/** flightKey = Departure Date (Format yyyymmdd) + Airline Kürzel + Flugnummer 4stellig + Suffix + TLC From + TLC To */
	private String cflightKey;
	private Long nhandlingTypeKey;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_QUEUE_MD")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_QUEUE_MD", sequenceName = "SEQ_CEN_DOC_GEN_QUEUE_MD", allocationSize = 1)
	@Column(name = "NDOC_GEN_QUEUE_MD_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocGenQueueMdKey() {
		return this.ndocGenQueueMdKey;
	}

	public void setNdocGenQueueMdKey(final long ndocGenQueueMdKey) {
		this.ndocGenQueueMdKey = ndocGenQueueMdKey;
	}

	@Column(name = "CSECTION", length = 40)
	public String getCsection() {
		return this.csection;
	}

	public void setCsection(final String csection) {
		this.csection = csection;
	}

	@Column(name = "CUSER", length = 40)
	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(final String cuser) {
		this.cuser = cuser;
	}

	@Column(name = "CCLIENTNAME", length = 40)
	public String getCclientname() {
		return this.cclientname;
	}

	public void setCclientname(final String cclientname) {
		this.cclientname = cclientname;
	}

	@Column(name = "CBROWSER", length = 40)
	public String getCbrowser() {
		return this.cbrowser;
	}

	public void setCbrowser(final String cbrowser) {
		this.cbrowser = cbrowser;
	}

	@Column(name = "CUNIT", length = 10)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "NAIRLINE_KEY", precision = 12, scale = 0)
	public Long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final Long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@Column(name = "NFLIGHT_NUMBER", precision = 12, scale = 0)
	public Long getNflightNumber() {
		return this.nflightNumber;
	}

	public void setNflightNumber(final Long nflightNumber) {
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
	@Column(name = "DDEPARTURE", length = 7)
	public Date getDdeparture() {
		return this.ddeparture;
	}

	public void setDdeparture(final Date ddeparture) {
		this.ddeparture = ddeparture;
	}

	@Column(name = "CDEPARTURE_TIME", length = 5)
	public String getCdepartureTime() {
		return this.cdepartureTime;
	}

	public void setCdepartureTime(final String cdepartureTime) {
		this.cdepartureTime = cdepartureTime;
	}

	@Column(name = "NAIRCRAFT_KEY", precision = 12, scale = 0)
	public Long getNaircraftKey() {
		return this.naircraftKey;
	}

	public void setNaircraftKey(final Long naircraftKey) {
		this.naircraftKey = naircraftKey;
	}

	@Column(name = "NTLC_FROM", precision = 12, scale = 0)
	public Long getNtlcFrom() {
		return this.ntlcFrom;
	}

	public void setNtlcFrom(final Long ntlcFrom) {
		this.ntlcFrom = ntlcFrom;
	}

	@Column(name = "NTLC_TO", precision = 12, scale = 0)
	public Long getNtlcTo() {
		return this.ntlcTo;
	}

	public void setNtlcTo(final Long ntlcTo) {
		this.ntlcTo = ntlcTo;
	}

	@Column(name = "CCLIENT", length = 40)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "NLAYOUT_KEY", precision = 12, scale = 0)
	public Long getNlayoutKey() {
		return this.nlayoutKey;
	}

	public void setNlayoutKey(final Long nlayoutKey) {
		this.nlayoutKey = nlayoutKey;
	}

	@Column(name = "NPROCESS_STATUS", precision = 4, scale = 0)
	public Integer getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final Integer nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(final Date dcreated) {
		this.dcreated = dcreated;
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

	@Column(name = "CINSTANCE", length = 80)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(final String cinstance) {
		this.cinstance = cinstance;
	}

	@Column(name = "CFLIGHT_KEY", length = 25)
	public String getCflightKey() {
		return this.cflightKey;
	}

	public void setCflightKey(final String cflightKey) {
		this.cflightKey = cflightKey;
	}

	@Column(name = "NHANDLING_TYPE_KEY", precision = 12, scale = 0)
	public Long getNhandlingTypeKey() {
		return this.nhandlingTypeKey;
	}

	public void setNhandlingTypeKey(final Long nhandlingTypeKey) {
		this.nhandlingTypeKey = nhandlingTypeKey;
	}

}
