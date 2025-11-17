package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.08.2025 17:24:11 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table LOC_UNIT_CATERER_DOCUMENT_UPLOAD
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "LOC_UNIT_CATERER_DOCUMENT_UPLOAD"
)
public class LocUnitCatererdocumentUpload
		implements DomainObject, java.io.Serializable {

	private long ncoduKey;
	private SysUnitsCaterer sysUnitsCaterer;
	private CenDocumentUpload cenDocumentUpload;
	private Long nsort;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_LOC_UNIT_CATERER_DOCUMENT_UPLOAD")
	@SequenceGenerator(name = "SEQ_LOC_UNIT_CATERER_DOCUMENT_UPLOAD", sequenceName = "SEQ_LOC_UNIT_CATERER_DOCUMENT_UPLOAD", allocationSize = 1)
	@Column(name = "NCODU_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcoduKey() {
		return this.ncoduKey;
	}

	public void setNcoduKey(long ncoduKey) {
		this.ncoduKey = ncoduKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnitsCaterer getSysUnitsCaterer() {
		return this.sysUnitsCaterer;
	}

	public void setSysUnitsCaterer(SysUnitsCaterer sysUnitsCaterer) {
		this.sysUnitsCaterer = sysUnitsCaterer;
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


