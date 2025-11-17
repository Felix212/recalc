package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.07.2025 17:17:56 by Hibernate Tools 4.3.5.Final

import java.math.BigDecimal;
import java.sql.Blob;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_CHAT_ATTACHMENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_CHAT_ATTACHMENTS"
)
public class CenChatAttachments implements DomainObject, java.io.Serializable {

	private Long nattachmentKey;
	private CenChatMessages cenChatMessages;
	private String cfileName;
	private String cfileType;
	private BigDecimal nfileSize;
	private String cfilePath;
	private Blob bfileData;
	private Date duploadedDate;

	public CenChatAttachments() {
	}

	@Id
	@SequenceGenerator(name = "cenChatAttachmentsSeq", sequenceName = "SEQ_CEN_CHAT_ATTACHMENTS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cenChatAttachmentsSeq")
	@Column(name = "NATTACHMENT_KEY", unique = true, nullable = false, precision = 22, scale = 0)
	public Long getNattachmentKey() {
		return this.nattachmentKey;
	}

	public void setNattachmentKey(Long nattachmentKey) {
		this.nattachmentKey = nattachmentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMESSAGE_KEY", nullable = false)
	public CenChatMessages getCenChatMessages() {
		return this.cenChatMessages;
	}

	public void setCenChatMessages(CenChatMessages cenChatMessages) {
		this.cenChatMessages = cenChatMessages;
	}

	@Column(name = "CFILE_NAME", nullable = false)
	public String getCfileName() {
		return this.cfileName;
	}

	public void setCfileName(String cfileName) {
		this.cfileName = cfileName;
	}

	@Column(name = "CFILE_TYPE", length = 100)
	public String getCfileType() {
		return this.cfileType;
	}

	public void setCfileType(String cfileType) {
		this.cfileType = cfileType;
	}

	@Column(name = "NFILE_SIZE", precision = 22, scale = 0)
	public BigDecimal getNfileSize() {
		return this.nfileSize;
	}

	public void setNfileSize(BigDecimal nfileSize) {
		this.nfileSize = nfileSize;
	}

	@Column(name = "CFILE_PATH", length = 500)
	public String getCfilePath() {
		return this.cfilePath;
	}

	public void setCfilePath(String cfilePath) {
		this.cfilePath = cfilePath;
	}

	@Column(name = "BFILE_DATA")
	public Blob getBfileData() {
		return this.bfileData;
	}

	public void setBfileData(Blob bfileData) {
		this.bfileData = bfileData;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPLOADED_DATE", length = 7)
	public Date getDuploadedDate() {
		return this.duploadedDate;
	}

	public void setDuploadedDate(Date duploadedDate) {
		this.duploadedDate = duploadedDate;
	}

}


