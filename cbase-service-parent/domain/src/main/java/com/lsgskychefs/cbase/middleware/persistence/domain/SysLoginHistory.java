package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 08.03.2016 11:49:18 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Type;

/**
 * Entity(DomainObject) for table SYS_LOGIN_HISTORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGIN_HISTORY")
public class SysLoginHistory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nloginHistoryKey;
	private SysLoginHistKind sysLoginHistkind;
	private SysLogin sysLogin;
	private String cusername;
	private Date dchange;
	private String cchangedByUser;
	private String cipadress;
	private String chostname;
	private String cversion;
	@Deprecated
	private byte[] ruserPwd;
	private String cuserPwd;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_LOGIN_HISTORY")
	@SequenceGenerator(name = "SEQ_SYS_LOGIN_HISTORY", sequenceName = "SEQ_SYS_LOGIN_HISTORY", allocationSize = 1)
	@Column(name = "NLOGIN_HISTORY_KEY", unique = true, nullable = false, precision = 13, scale = 0)
	public long getNloginHistoryKey() {
		return this.nloginHistoryKey;
	}

	public void setNloginHistoryKey(final long nloginHistoryKey) {
		this.nloginHistoryKey = nloginHistoryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLOGIN_HISTKIND_KEY", nullable = false)
	public SysLoginHistKind getSysLoginHistkind() {
		return this.sysLoginHistkind;
	}

	public void setSysLoginHistkind(final SysLoginHistKind sysLoginHistkind) {
		this.sysLoginHistkind = sysLoginHistkind;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@Column(name = "CUSERNAME", nullable = false, length = 40)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(final String cusername) {
		this.cusername = cusername;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCHANGE", nullable = false, length = 7)
	public Date getDchange() {
		return this.dchange;
	}

	public void setDchange(final Date dchange) {
		this.dchange = dchange;
	}

	@Column(name = "CCHANGED_BY_USER", nullable = false, length = 40)
	public String getCchangedByUser() {
		return this.cchangedByUser;
	}

	public void setCchangedByUser(final String cchangedByUser) {
		this.cchangedByUser = cchangedByUser;
	}

	@Column(name = "CIPADRESS", length = 15)
	public String getCipadress() {
		return this.cipadress;
	}

	public void setCipadress(final String cipadress) {
		this.cipadress = cipadress;
	}

	@Column(name = "CHOSTNAME", length = 30)
	public String getChostname() {
		return this.chostname;
	}

	public void setChostname(final String chostname) {
		this.chostname = chostname;
	}

	@Column(name = "CVERSION", length = 20)
	public String getCversion() {
		return this.cversion;
	}

	public void setCversion(final String cversion) {
		this.cversion = cversion;
	}

	/** @deprecated use {@link #getCuserPwd()} */
	@Deprecated
	@Column(name = "RUSER_PWD")
	@Type(type = "org.hibernate.type.BinaryType") // needed due to migration to spring boot > 2.0
	public byte[] getRuserPwd() {
		return this.ruserPwd;
	}

	/** @deprecated use {@link #setCuserPwd()} */
	@Deprecated
	public void setRuserPwd(final byte[] ruserPwd) {
		this.ruserPwd = ruserPwd;
	}

	@Column(name = "CUSER_PWD", length = 200)
	public String getCuserPwd() {
		return this.cuserPwd;
	}

	public void setCuserPwd(final String cuserPwd) {
		this.cuserPwd = cuserPwd;
	}

}
