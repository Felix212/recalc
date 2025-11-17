package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_OUT_MD_BLOB
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_OUT_MD_BLOB")
public class CenOutMdBlob implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenOutMdBlobId id;
	private CenOut cenOut;
	private byte[] bdatastore;
	private String ccreatedBy;
	private Date dcreatedDate;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nresultKey", column = @Column(name = "NRESULT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntransaction", column = @Column(name = "NTRANSACTION", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "ntype", column = @Column(name = "NTYPE", nullable = false, precision = 1, scale = 0)) })
	public CenOutMdBlobId getId() {
		return this.id;
	}

	public void setId(final CenOutMdBlobId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NRESULT_KEY", nullable = false, insertable = false, updatable = false)
	public CenOut getCenOut() {
		return this.cenOut;
	}

	public void setCenOut(final CenOut cenOut) {
		this.cenOut = cenOut;
	}

	@Lob
	@Column(name = "BDATASTORE", length = 4000)
	public byte[] getBdatastore() {
		return this.bdatastore;
	}

	public void setBdatastore(final byte[] bdatastore) {
		this.bdatastore = bdatastore;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(final String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_DATE", length = 7)
	public Date getDcreatedDate() {
		return this.dcreatedDate;
	}

	public void setDcreatedDate(final Date dcreatedDate) {
		this.dcreatedDate = dcreatedDate;
	}

}
