package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 19.11.2024 11:28:24 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_DOC_GEN_QUEUE_DLV
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOC_GEN_QUEUE_DLV")
public class CenDocGenQueueDlv implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nocGenQueueDlvKey;
	private CenOutDeliveryNote cenOutDeliveryNote;
	private Date dcreated;
	private Integer nprocessStatus;
	private String cinstance;
	private Date djobStart;
	private Date djobEnd;
	private String cemail;
	private String cemailFullname;
	private String csvcDatabase;
	private String csvcTerminal;
	private String csvcModule;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOC_GEN_QUEUE_DLV")
	@SequenceGenerator(name = "SEQ_CEN_DOC_GEN_QUEUE_DLV", sequenceName = "SEQ_CEN_DOC_GEN_QUEUE_DLV", allocationSize = 1)
	@Column(name = "NOC_GEN_QUEUE_DLV_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNocGenQueueDlvKey() {
		return this.nocGenQueueDlvKey;
	}

	public void setNocGenQueueDlvKey(long nocGenQueueDlvKey) {
		this.nocGenQueueDlvKey = nocGenQueueDlvKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NRESULT_KEY", referencedColumnName = "NRESULT_KEY", nullable = false),
			@JoinColumn(name = "NTRANSACTION", referencedColumnName = "NTRANSACTION", nullable = false),
			@JoinColumn(name = "NNUMBER", referencedColumnName = "NNUMBER", nullable = false) })
	public CenOutDeliveryNote getCenOutDeliveryNote() {
		return this.cenOutDeliveryNote;
	}

	public void setCenOutDeliveryNote(CenOutDeliveryNote cenOutDeliveryNote) {
		this.cenOutDeliveryNote = cenOutDeliveryNote;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED", length = 7)
	public Date getDcreated() {
		return this.dcreated;
	}

	public void setDcreated(Date dcreated) {
		this.dcreated = dcreated;
	}

	@Column(name = "NPROCESS_STATUS", precision = 4, scale = 0)
	public Integer getNprocessStatus() {
		return this.nprocessStatus;
	}

	public void setNprocessStatus(Integer nprocessStatus) {
		this.nprocessStatus = nprocessStatus;
	}

	@Column(name = "CINSTANCE", length = 80)
	public String getCinstance() {
		return this.cinstance;
	}

	public void setCinstance(String cinstance) {
		this.cinstance = cinstance;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_START", length = 7)
	public Date getDjobStart() {
		return this.djobStart;
	}

	public void setDjobStart(Date djobStart) {
		this.djobStart = djobStart;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJOB_END", length = 7)
	public Date getDjobEnd() {
		return this.djobEnd;
	}

	public void setDjobEnd(Date djobEnd) {
		this.djobEnd = djobEnd;
	}

	@Column(name = "CEMAIL", length = 1000)
	public String getCemail() {
		return this.cemail;
	}

	public void setCemail(String cemail) {
		this.cemail = cemail;
	}

	@Column(name = "CEMAIL_FULLNAME", length = 1000)
	public String getCemailFullname() {
		return this.cemailFullname;
	}

	public void setCemailFullname(String cemailFullname) {
		this.cemailFullname = cemailFullname;
	}

	@Column(name = "CSVC_DATABASE", nullable = false, length = 20)
	public String getCsvcDatabase() {
		return this.csvcDatabase;
	}

	public void setCsvcDatabase(String csvcDatabase) {
		this.csvcDatabase = csvcDatabase;
	}

	@Column(name = "CSVC_TERMINAL", nullable = false, length = 20)
	public String getCsvcTerminal() {
		return this.csvcTerminal;
	}

	public void setCsvcTerminal(String csvcTerminal) {
		this.csvcTerminal = csvcTerminal;
	}

	@Column(name = "CSVC_MODULE", nullable = false, length = 50)
	public String getCsvcModule() {
		return this.csvcModule;
	}

	public void setCsvcModule(String csvcModule) {
		this.csvcModule = csvcModule;
	}

}


