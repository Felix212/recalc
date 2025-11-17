package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.02.2025 09:46:17 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_ARCHIVE_QUEUE_DOC
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ARCHIVE_QUEUE_DOC"
)
public class SysArchiveQueueDoc implements DomainObject, java.io.Serializable {

	private long nqueueDocumentKey;
	private SysArchiveQueue sysArchiveQueue;
	private String cfilename;
	private byte[] bfile;
	private String cdescription;
	private Long narchiveId;
	private String carchiveId;
	private Long ndoctypeKey;
	private Integer nbsd;
	private Integer nrelevant;
	private String cbarcode;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_ARCHIVE_QUEUE_DOC")
	@SequenceGenerator(name = "SEQ_SYS_ARCHIVE_QUEUE_DOC", sequenceName = "SEQ_SYS_ARCHIVE_QUEUE_DOC", allocationSize = 1)
	@Column(name = "NQUEUE_DOCUMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNqueueDocumentKey() {
		return this.nqueueDocumentKey;
	}

	public void setNqueueDocumentKey(long nqueueDocumentKey) {
		this.nqueueDocumentKey = nqueueDocumentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NQUEUE_KEY", nullable = false)
	public SysArchiveQueue getSysArchiveQueue() {
		return this.sysArchiveQueue;
	}

	public void setSysArchiveQueue(SysArchiveQueue sysArchiveQueue) {
		this.sysArchiveQueue = sysArchiveQueue;
	}

	@Column(name = "CFILENAME", length = 250)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(String cfilename) {
		this.cfilename = cfilename;
	}

	@Lob
	@Column(name = "BFILE")
	public byte[] getBfile() {
		return this.bfile;
	}

	public void setBfile(byte[] bfile) {
		this.bfile = bfile;
	}

	@Column(name = "CDESCRIPTION", length = 250)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NARCHIVE_ID", precision = 12, scale = 0)
	public Long getNarchiveId() {
		return this.narchiveId;
	}

	public void setNarchiveId(Long narchiveId) {
		this.narchiveId = narchiveId;
	}

	@Column(name = "CARCHIVE_ID", length = 100)
	public String getCarchiveId() {
		return this.carchiveId;
	}

	public void setCarchiveId(String carchiveId) {
		this.carchiveId = carchiveId;
	}

	@Column(name = "NDOCTYPE_KEY", precision = 12, scale = 0)
	public Long getNdoctypeKey() {
		return this.ndoctypeKey;
	}

	public void setNdoctypeKey(Long ndoctypeKey) {
		this.ndoctypeKey = ndoctypeKey;
	}

	@Column(name = "NBSD", precision = 1, scale = 0)
	public Integer getNbsd() {
		return this.nbsd;
	}

	public void setNbsd(Integer nbsd) {
		this.nbsd = nbsd;
	}

	@Column(name = "NRELEVANT", precision = 1, scale = 0)
	public Integer getNrelevant() {
		return this.nrelevant;
	}

	public void setNrelevant(Integer nrelevant) {
		this.nrelevant = nrelevant;
	}

	@Column(name = "CBARCODE")
	public String getCbarcode() {
		return this.cbarcode;
	}

	public void setCbarcode(String cbarcode) {
		this.cbarcode = cbarcode;
	}

}


