package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13.08.2025 09:50:21 by Hibernate Tools 4.3.5.Final

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_OUT_DOCUMENT_UPLOAD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_DOCUMENT_UPLOAD")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenOutDocumentUpload implements DomainObject, java.io.Serializable {

	private long ncoduKey;
	@JsonIgnore
	private CenOut cenOut;
	private CenDocumentUpload cenDocumentUpload;
	private Long nsort;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_OUT_DOCUMENT_UPLOAD")
	@SequenceGenerator(name = "SEQ_CEN_OUT_DOCUMENT_UPLOAD", sequenceName = "SEQ_CEN_OUT_DOCUMENT_UPLOAD", allocationSize = 1)
	@Column(name = "NCODU_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcoduKey() {
		return this.ncoduKey;
	}

	public void setNcoduKey(long ncoduKey) {
		this.ncoduKey = ncoduKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NDOCUMENT_UPLOAD_KEY", nullable = false)
	public CenDocumentUpload getCenDocumentUpload() {
		return this.cenDocumentUpload;
	}

	public void setCenDocumentUpload(CenDocumentUpload cenDocumentUpload) {
		this.cenDocumentUpload = cenDocumentUpload;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(Long nsort) {
		this.nsort = nsort;
	}

}


