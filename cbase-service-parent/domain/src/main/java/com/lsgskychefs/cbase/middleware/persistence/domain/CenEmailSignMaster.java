package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 1, 2019 4:59:26 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_EMAIL_SIGN_MASTER
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_SIGN_MASTER")
public class CenEmailSignMaster implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long esmNkey;
	private int esmNtype;
	private String esmCtext;
	private String esmCdescription;
	private Date esmDvalidFrom;
	private Date esmDvalidTo;
	private Set<CenEmailSignDetail> cenEmailSignDetails = new HashSet<>(0);

	@Id
	@Column(name = "ESM_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getEsmNkey() {
		return this.esmNkey;
	}

	public void setEsmNkey(final long esmNkey) {
		this.esmNkey = esmNkey;
	}

	@Column(name = "ESM_NTYPE", nullable = false, precision = 2, scale = 0)
	public int getEsmNtype() {
		return this.esmNtype;
	}

	public void setEsmNtype(final int esmNtype) {
		this.esmNtype = esmNtype;
	}

	@Column(name = "ESM_CTEXT", length = 30)
	public String getEsmCtext() {
		return this.esmCtext;
	}

	public void setEsmCtext(final String esmCtext) {
		this.esmCtext = esmCtext;
	}

	@Column(name = "ESM_CDESCRIPTION", length = 50)
	public String getEsmCdescription() {
		return this.esmCdescription;
	}

	public void setEsmCdescription(final String esmCdescription) {
		this.esmCdescription = esmCdescription;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ESM_DVALID_FROM", length = 7)
	public Date getEsmDvalidFrom() {
		return this.esmDvalidFrom;
	}

	public void setEsmDvalidFrom(final Date esmDvalidFrom) {
		this.esmDvalidFrom = esmDvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ESM_DVALID_TO", length = 7)
	public Date getEsmDvalidTo() {
		return this.esmDvalidTo;
	}

	public void setEsmDvalidTo(final Date esmDvalidTo) {
		this.esmDvalidTo = esmDvalidTo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEmailSignMaster")
	public Set<CenEmailSignDetail> getCenEmailSignDetails() {
		return this.cenEmailSignDetails;
	}

	public void setCenEmailSignDetails(final Set<CenEmailSignDetail> cenEmailSignDetails) {
		this.cenEmailSignDetails = cenEmailSignDetails;
	}

}
