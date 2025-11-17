package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 11.05.2016 13:19:36 by Hibernate Tools 4.3.2-SNAPSHOT

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

import com.lsgskychefs.cbase.middleware.persistence.utils.CbaseMiddlewareStringUtils;

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE")
public class CenDocGenQueue implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndocGenQueueKey;

	private CenOut cenOut;

	private long nresultKey;

	private Integer ngenStatus;

	private Date dtimestamp;

	private Date djobStart;

	private Date djobEnd;

	private String cairline;

	private String cunit;

	private String cinstance;

	private Integer njobType;

	private Long nuserId;

	private String cusername;

	private int nprocessStatus;

	private Long ntransaction;

	private Date dcreatedUtc;

	private long neuVersion;

	private String csvcDatabase = " ";

	private String csvcTerminal = " ";

	private String csvcModule = " ";

	private Set<CenDocGenUd> cenDocGenUds = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_QUEUE")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_QUEUE", sequenceName = "SEQ_CEN_DOC_GEN_QUEUE", allocationSize = 1)
	@Column(name = "NDOC_GEN_QUEUE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocGenQueueKey() {
		return this.ndocGenQueueKey;
	}

	public void setNdocGenQueueKey(final long ndocGenQueueKey) {
		this.ndocGenQueueKey = ndocGenQueueKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
		nresultKey = cenOut.getNresultKey();
	}

	@Column(name = "NGEN_STATUS", precision = 1, scale = 0)
	public Integer getNgenStatus() {
		return this.ngenStatus;
	}

	public void setNgenStatus(final Integer ngenStatus) {
		this.ngenStatus = ngenStatus;
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
	public Long getNuserId() {
		return this.nuserId;
	}

	public void setNuserId(final Long nuserId) {
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
	public int getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(final int nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "NTRANSACTION", precision = 12, scale = 0)
	public Long getNtransaction() {
		return this.ntransaction;
	}

	public void setNtransaction(final Long ntransaction) {
		this.ntransaction = ntransaction;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_UTC", length = 7)
	public Date getDcreatedUtc() {
		return this.dcreatedUtc;
	}

	public void setDcreatedUtc(final Date dcreatedUtc) {
		this.dcreatedUtc = dcreatedUtc;
	}

	@Column(name = "NEU_VERSION", nullable = false, precision = 12, scale = 0)
	public long getNeuVersion() {
		return this.neuVersion;
	}

	public void setNeuVersion(final long neuVersion) {
		this.neuVersion = neuVersion;
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

	/**
	 * Get nresultKey
	 *
	 * @return the nresultKey
	 */
	@Column(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public long getNresultKey() {
		return nresultKey;
	}

	/**
	 * set nresultKey
	 *
	 * @param nresultKey the nresultKey to set
	 */
	public void setNresultKey(final long nresultKey) {
		this.nresultKey = nresultKey;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenDocGenQueue")
	public Set<CenDocGenUd> getCenDocGenUds() {
		return this.cenDocGenUds;
	}

	public void setCenDocGenUds(final Set<CenDocGenUd> cenDocGenUds) {
		this.cenDocGenUds = cenDocGenUds;
	}

}
