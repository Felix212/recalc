package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 10, 2019 6:53:05 PM by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_EMAIL_GROUPS_DETAIL
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_GROUPS_DETAIL")
public class CenEmailGroupsDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long egdNkey;
	private SysLogin sysLogin;
	private CenEmailGroupsMaster cenEmailGroupsMaster;
	private int egdNtype;
	private String egdCname;
	private String egdCemailAddress;
	private Date egdDvalidFrom;
	private Date egdDvalidTo;

	@Id
	@Column(name = "EGD_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getEgdNkey() {
		return this.egdNkey;
	}

	public void setEgdNkey(final long egdNkey) {
		this.egdNkey = egdNkey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "EGD_NUSER_ID")
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "EGD_EGM_NKEY", nullable = false)
	public CenEmailGroupsMaster getCenEmailGroupsMaster() {
		return this.cenEmailGroupsMaster;
	}

	public void setCenEmailGroupsMaster(final CenEmailGroupsMaster cenEmailGroupsMaster) {
		this.cenEmailGroupsMaster = cenEmailGroupsMaster;
	}

	@Column(name = "EGD_NTYPE", nullable = false, precision = 1, scale = 0)
	public int getEgdNtype() {
		return this.egdNtype;
	}

	public void setEgdNtype(final int egdNtype) {
		this.egdNtype = egdNtype;
	}

	@Column(name = "EGD_CNAME", length = 20)
	public String getEgdCname() {
		return this.egdCname;
	}

	public void setEgdCname(final String egdCname) {
		this.egdCname = egdCname;
	}

	@Column(name = "EGD_CEMAIL_ADDRESS", length = 100)
	public String getEgdCemailAddress() {
		return this.egdCemailAddress;
	}

	public void setEgdCemailAddress(final String egdCemailAddress) {
		this.egdCemailAddress = egdCemailAddress;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "EGD_DVALID_FROM", length = 7)
	public Date getEgdDvalidFrom() {
		return this.egdDvalidFrom;
	}

	public void setEgdDvalidFrom(final Date egdDvalidFrom) {
		this.egdDvalidFrom = egdDvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "EGD_DVALID_TO", length = 7)
	public Date getEgdDvalidTo() {
		return this.egdDvalidTo;
	}

	public void setEgdDvalidTo(final Date egdDvalidTo) {
		this.egdDvalidTo = egdDvalidTo;
	}

}
