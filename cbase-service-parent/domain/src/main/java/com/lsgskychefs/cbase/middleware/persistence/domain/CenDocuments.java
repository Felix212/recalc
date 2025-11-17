package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 17, 2023 3:15:05 PM by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

/**
 * Entity(DomainObject) for table CEN_DOCUMENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_DOCUMENTS")
public class CenDocuments implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ndocumentIndexKey;
	private String cclient;
	private String cdocumentName;
	private String cfileName;
	private int ndocumentType;
	private String cdescription;
	private Integer nownerId;
	private byte[] bdocument;

	@Id
	@Column(name = "NDOCUMENT_INDEX_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNdocumentIndexKey() {
		return this.ndocumentIndexKey;
	}

	public void setNdocumentIndexKey(long ndocumentIndexKey) {
		this.ndocumentIndexKey = ndocumentIndexKey;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CDOCUMENT_NAME", nullable = false, length = 60)
	public String getCdocumentName() {
		return this.cdocumentName;
	}

	public void setCdocumentName(String cdocumentName) {
		this.cdocumentName = cdocumentName;
	}

	@Column(name = "CFILE_NAME", nullable = false, length = 100)
	public String getCfileName() {
		return this.cfileName;
	}

	public void setCfileName(String cfileName) {
		this.cfileName = cfileName;
	}

	@Column(name = "NDOCUMENT_TYPE", nullable = false, precision = 6, scale = 0)
	public int getNdocumentType() {
		return this.ndocumentType;
	}

	public void setNdocumentType(int ndocumentType) {
		this.ndocumentType = ndocumentType;
	}

	@Column(name = "CDESCRIPTION", length = 250)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NOWNER_ID", precision = 5, scale = 0)
	public Integer getNownerId() {
		return this.nownerId;
	}

	public void setNownerId(Integer nownerId) {
		this.nownerId = nownerId;
	}

	@Type(type = "org.hibernate.type.BinaryType")
	@Column(name = "BDOCUMENT")
	public byte[] getBdocument() {
		return this.bdocument;
	}

	public void setBdocument(byte[] bdocument) {
		this.bdocument = bdocument;
	}

}


