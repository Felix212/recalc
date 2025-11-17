package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 1, 2019 4:59:26 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_EMAIL_SIGN_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_SIGN_DETAIL")
public class CenEmailSignDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long esdNkey;
	private CenEmailSignMaster cenEmailSignMaster;
	private int esdNsort;
	private String esdCtext;
	private Date esdDvalidFrom;
	private Date esdDvalidTo;

	@Id
	@Column(name = "ESD_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getEsdNkey() {
		return this.esdNkey;
	}

	public void setEsdNkey(final long esdNkey) {
		this.esdNkey = esdNkey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ESD_ESM_NKEY", nullable = false)
	public CenEmailSignMaster getCenEmailSignMaster() {
		return this.cenEmailSignMaster;
	}

	public void setCenEmailSignMaster(final CenEmailSignMaster cenEmailSignMaster) {
		this.cenEmailSignMaster = cenEmailSignMaster;
	}

	@Column(name = "ESD_NSORT", nullable = false, precision = 2, scale = 0)
	public int getEsdNsort() {
		return this.esdNsort;
	}

	public void setEsdNsort(final int esdNsort) {
		this.esdNsort = esdNsort;
	}

	@Column(name = "ESD_CTEXT", length = 50)
	public String getEsdCtext() {
		return this.esdCtext;
	}

	public void setEsdCtext(final String esdCtext) {
		this.esdCtext = esdCtext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ESD_DVALID_FROM", nullable = false, length = 7)
	public Date getEsdDvalidFrom() {
		return this.esdDvalidFrom;
	}

	public void setEsdDvalidFrom(final Date esdDvalidFrom) {
		this.esdDvalidFrom = esdDvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ESD_DVALID_TO", nullable = false, length = 7)
	public Date getEsdDvalidTo() {
		return this.esdDvalidTo;
	}

	public void setEsdDvalidTo(final Date esdDvalidTo) {
		this.esdDvalidTo = esdDvalidTo;
	}

}
