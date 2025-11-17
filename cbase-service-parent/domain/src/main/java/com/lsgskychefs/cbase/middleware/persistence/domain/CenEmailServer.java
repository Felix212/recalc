package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jul 1, 2019 4:59:26 PM by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_EMAIL_SERVER
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_EMAIL_SERVER")
public class CenEmailServer implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nemsNkey;
	private String nemsCtext;
	private String nemsCsmtpServer;
	private int nemsNsmtpPort;
	private String nemsCsmtpUserid;
	private String nemsCsmtpPassword;
	private int nemsCsmtpAuth;
	private int nemsCsmtpLog;
	private String nemCfromemail;
	private Integer nemsNcontype;
	private String nemsCharset;
	private Set<CenEmail> cenEmails = new HashSet<CenEmail>(0);

	@Id
	@Column(name = "NEMS_NKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNemsNkey() {
		return this.nemsNkey;
	}

	public void setNemsNkey(final long nemsNkey) {
		this.nemsNkey = nemsNkey;
	}

	@Column(name = "NEMS_CTEXT", nullable = false, length = 30)
	public String getNemsCtext() {
		return this.nemsCtext;
	}

	public void setNemsCtext(final String nemsCtext) {
		this.nemsCtext = nemsCtext;
	}

	@Column(name = "NEMS_CSMTP_SERVER", nullable = false, length = 30)
	public String getNemsCsmtpServer() {
		return this.nemsCsmtpServer;
	}

	public void setNemsCsmtpServer(final String nemsCsmtpServer) {
		this.nemsCsmtpServer = nemsCsmtpServer;
	}

	@Column(name = "NEMS_NSMTP_PORT", nullable = false, precision = 2, scale = 0)
	public int getNemsNsmtpPort() {
		return this.nemsNsmtpPort;
	}

	public void setNemsNsmtpPort(final int nemsNsmtpPort) {
		this.nemsNsmtpPort = nemsNsmtpPort;
	}

	@Column(name = "NEMS_CSMTP_USERID", length = 20)
	public String getNemsCsmtpUserid() {
		return this.nemsCsmtpUserid;
	}

	public void setNemsCsmtpUserid(final String nemsCsmtpUserid) {
		this.nemsCsmtpUserid = nemsCsmtpUserid;
	}

	@Column(name = "NEMS_CSMTP_PASSWORD", length = 20)
	public String getNemsCsmtpPassword() {
		return this.nemsCsmtpPassword;
	}

	public void setNemsCsmtpPassword(final String nemsCsmtpPassword) {
		this.nemsCsmtpPassword = nemsCsmtpPassword;
	}

	@Column(name = "NEMS_CSMTP_AUTH", nullable = false, precision = 1, scale = 0)
	public int getNemsCsmtpAuth() {
		return this.nemsCsmtpAuth;
	}

	public void setNemsCsmtpAuth(final int nemsCsmtpAuth) {
		this.nemsCsmtpAuth = nemsCsmtpAuth;
	}

	@Column(name = "NEMS_CSMTP_LOG", nullable = false, precision = 1, scale = 0)
	public int getNemsCsmtpLog() {
		return this.nemsCsmtpLog;
	}

	public void setNemsCsmtpLog(final int nemsCsmtpLog) {
		this.nemsCsmtpLog = nemsCsmtpLog;
	}

	@Column(name = "NEM_CFROMEMAIL", nullable = false, length = 100)
	public String getNemCfromemail() {
		return this.nemCfromemail;
	}

	public void setNemCfromemail(String nemCfromemail) {
		this.nemCfromemail = nemCfromemail;
	}

	@Column(name = "NEMS_NCONTYPE", precision = 2, scale = 0)
	public Integer getNemsNcontype() {
		return this.nemsNcontype;
	}

	public void setNemsNcontype(Integer nemsNcontype) {
		this.nemsNcontype = nemsNcontype;
	}

	@Column(name = "NEMS_CHARSET", length = 50)
	public String getNemsCharset() {
		return this.nemsCharset;
	}

	public void setNemsCharset(String nemsCharset) {
		this.nemsCharset = nemsCharset;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenEmailServer")
	public Set<CenEmail> getCenEmails() {
		return this.cenEmails;
	}

	public void setCenEmails(Set<CenEmail> cenEmails) {
		this.cenEmails = cenEmails;
	}

}


