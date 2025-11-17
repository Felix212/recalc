package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 13.08.2025 09:50:21 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_DOCUMENT_UPLOAD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOCUMENT_UPLOAD")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
@EntityListeners(AuditingEntityListener.class)
public class CenDocumentUpload extends AuditableDomainObject implements DomainObject, java.io.Serializable {

	private long ndocumentUploadKey;
	@JsonIgnore
	private byte[] bbinary;
	private String cdescription;
	private String cfilename;
	private String ctype;
	private Long nsize;
	@JsonIgnore
	private Set<CenOutDocumentUpload> cenOutDocumentUploads = new HashSet<CenOutDocumentUpload>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_DOCUMENT_UPLOAD")
	@SequenceGenerator(name = "SEQ_CEN_DOCUMENT_UPLOAD", sequenceName = "SEQ_CEN_DOCUMENT_UPLOAD", allocationSize = 1)
	@Column(name = "NDOCUMENT_UPLOAD_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocumentUploadKey() {
		return this.ndocumentUploadKey;
	}

	public void setNdocumentUploadKey(long ndocumentUploadKey) {
		this.ndocumentUploadKey = ndocumentUploadKey;
	}

	@Lob
	@Column(name = "BBINARY")
	public byte[] getBbinary() {
		return this.bbinary;
	}

	public void setBbinary(byte[] bbinary) {
		this.bbinary = bbinary;
	}

	@Column(name = "CDESCRIPTION", length = 2000)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CFILENAME", length = 1000)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "CTYPE", length = 100)
	public String getCtype() {
		return this.ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}

	@Column(name = "NSIZE", precision = 12, scale = 0)
	public Long getNsize() {
		return this.nsize;
	}

	public void setNsize(Long nsize) {
		this.nsize = nsize;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenDocumentUpload")
	public Set<CenOutDocumentUpload> getCenOutDocumentUploads() {
		return this.cenOutDocumentUploads;
	}

	public void setCenOutDocumentUploads(Set<CenOutDocumentUpload> cenOutDocumentUploads) {
		this.cenOutDocumentUploads = cenOutDocumentUploads;
	}

}


