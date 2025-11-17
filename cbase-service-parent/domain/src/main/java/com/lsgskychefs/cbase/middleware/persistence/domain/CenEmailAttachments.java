package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Nov 14, 2019 11:01:41 AM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_EMAIL_ATTACHMENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_ATTACHMENTS")
public class CenEmailAttachments implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nattachmentKey;
	private CenEmail cenEmail;
	private String cfilename;
	private byte[] battachmentData;
	private Integer ninline;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_EMAIL_ATTACHMENTS")
	@SequenceGenerator(name = "SEQ_CEN_EMAIL_ATTACHMENTS", sequenceName = "SEQ_CEN_EMAIL_ATTACHMENTS", allocationSize = 1)
	@Column(name = "NATTACHMENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNattachmentKey() {
		return this.nattachmentKey;
	}

	public void setNattachmentKey(final long nattachmentKey) {
		this.nattachmentKey = nattachmentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NEMAIL_KEY", nullable = false)
	public CenEmail getCenEmail() {
		return this.cenEmail;
	}

	public void setCenEmail(final CenEmail cenEmail) {
		this.cenEmail = cenEmail;
	}

	@Column(name = "CFILENAME", nullable = false)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(final String cfilename) {
		this.cfilename = cfilename;
	}

	@Lob
	@Column(name = "BATTACHMENT_DATA")
	public byte[] getBattachmentData() {
		return this.battachmentData;
	}

	public void setBattachmentData(final byte[] battachmentData) {
		this.battachmentData = battachmentData;
	}

	@Column(name = "NINLINE", precision = 1, scale = 0)
	public Integer getNinline() {
		return this.ninline;
	}

	public void setNinline(final Integer ninline) {
		this.ninline = ninline;
	}

}
