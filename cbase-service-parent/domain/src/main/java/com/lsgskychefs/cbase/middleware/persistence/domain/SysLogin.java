package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedStoredProcedureQueries;
import javax.persistence.NamedStoredProcedureQuery;
import javax.persistence.OneToMany;
import javax.persistence.ParameterMode;
import javax.persistence.SequenceGenerator;
import javax.persistence.StoredProcedureParameter;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_LOGIN
 *
 * @author Hibernate Tools
 */
@NamedStoredProcedureQueries({
		@NamedStoredProcedureQuery(name = CbaseMiddlewareDbConstants.PpResetPassword.PP_RESET_PASSWORD, procedureName = "CBASE_PASSWORD."
				+ CbaseMiddlewareDbConstants.PpResetPassword.PP_RESET_PASSWORD, parameters = {
				@StoredProcedureParameter(mode = ParameterMode.IN, name = CbaseMiddlewareDbConstants.PpResetPassword.P_CUSER, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = CbaseMiddlewareDbConstants.PpResetPassword.P_MESSAGE, type = String.class),
				@StoredProcedureParameter(mode = ParameterMode.OUT, name = CbaseMiddlewareDbConstants.PpResetPassword.P_ERROR_KEY, type = Integer.class)
		})
})
@Entity
@Table(name = "SYS_LOGIN", uniqueConstraints = @UniqueConstraint(columnNames = "CUSERNAME"))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysLogin implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nuserId;

	private String cclient;

	@JsonView(View.Simple.class)
	private String cunit;

	@JsonIgnore
	private SysUnits sysUnits;

	@JsonView(View.Simple.class)
	private String cdepartment;

	@JsonView(View.Simple.class)
	private String cusername;

	@JsonIgnore
	private String cuserpassword;

	@JsonView(View.Simple.class)
	private String cfirstname;

	@JsonView(View.Simple.class)
	private String clastname;

	@JsonView(View.Simple.class)
	private String cpersonalid;

	@JsonIgnore
	private String cversion;

	@JsonIgnore
	private String cipaddress;

	@JsonIgnore
	private Integer nconnected;

	@JsonIgnore
	private String clastlogin;

	@JsonIgnore
	private String cbuild;

	@JsonIgnore
	private byte[] ruserPwd;

	@JsonIgnore
	private String cpwdInit;

	@JsonIgnore
	private String cpwdDate;

	@JsonIgnore
	private Integer npwdIsInit;

	@JsonIgnore
	private Integer ntechuser;

	@JsonIgnore
	private Integer naccountLocked;

	@JsonIgnore
	private int ngraceLogins;

	@JsonIgnore
	private Integer nfailedLogins;

	@JsonIgnore
	private Date dpwdDate;

	@JsonView(View.Simple.class)
	private String cemailAddress;

	@JsonIgnore
	private String cuserPwd;

	@JsonIgnore
	private Date dlastlogin;

	@JsonIgnore
	private String ctempPwd;

	@JsonIgnore
	private Date dvalidtoTemppwd;

	@JsonIgnore
	private Set<SysLoginHistory> sysLoginHistories = new HashSet<>(0);

	@JsonIgnore
	private Set<SysRoleGroups> sysRoleGroupses = new HashSet<>(0);

	@JsonIgnore
	private Set<SysLoginRoles> sysLoginRoleses = new HashSet<>(0);

	@JsonIgnore
	private Set<SysAppUserSetting> sysAppUserSettings = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOut> cenOuts = new HashSet<>(0);

	@JsonIgnore
	private Set<CenOutCsoShown> cenOutCsoShowns = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_LOGIN")
	@SequenceGenerator(name = "SEQ_SYS_LOGIN", sequenceName = "SEQ_SYS_LOGIN", allocationSize = 1)
	@Column(name = "NUSER_ID", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNuserId() {
		return this.nuserId;
	}

	public void setNuserId(final long nuserId) {
		this.nuserId = nuserId;
	}

	@Column(name = "CCLIENT", nullable = false, length = 3)
	public String getCclient() {
		return this.cclient;
	}

	public void setCclient(final String cclient) {
		this.cclient = cclient;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", insertable = false, updatable = false)
	public SysUnits getSysUnits() {
		return sysUnits;
	}

	public void setSysUnits(final SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@Column(name = "CDEPARTMENT", nullable = false, length = 10)
	public String getCdepartment() {
		return this.cdepartment;
	}

	public void setCdepartment(final String cdepartment) {
		this.cdepartment = cdepartment;
	}

	@Column(name = "CUSERNAME", unique = true, nullable = false, length = 40)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(final String cusername) {
		this.cusername = cusername;
	}

	/**
	 * @return the user password as clear text
	 * @deprecated use {@link #getCuserPwd()}
	 */
	@Deprecated
	@Column(name = "CUSERPASSWORD", nullable = false, length = 100)
	public String getCuserpassword() {
		return this.cuserpassword;
	}

	/**
	 * @param cuserpassword the user password as clear text
	 * @deprecated use {@link #setCuserPwd(String)}
	 */
	@Deprecated
	public void setCuserpassword(final String cuserpassword) {
		this.cuserpassword = cuserpassword;
	}

	@Column(name = "CFIRSTNAME", nullable = false, length = 20)
	public String getCfirstname() {
		return this.cfirstname;
	}

	public void setCfirstname(final String cfirstname) {
		this.cfirstname = cfirstname;
	}

	@Column(name = "CLASTNAME", nullable = false, length = 20)
	public String getClastname() {
		return this.clastname;
	}

	public void setClastname(final String clastname) {
		this.clastname = clastname;
	}

	@Column(name = "CPERSONALID", nullable = false, length = 10)
	public String getCpersonalid() {
		return this.cpersonalid;
	}

	public void setCpersonalid(final String cpersonalid) {
		this.cpersonalid = cpersonalid;
	}

	@Column(name = "CVERSION", length = 20)
	public String getCversion() {
		return this.cversion;
	}

	public void setCversion(final String cversion) {
		this.cversion = cversion;
	}

	@Column(name = "CIPADDRESS", length = 15)
	public String getCipaddress() {
		return this.cipaddress;
	}

	public void setCipaddress(final String cipaddress) {
		this.cipaddress = cipaddress;
	}

	@Column(name = "NCONNECTED", precision = 1, scale = 0)
	public Integer getNconnected() {
		return this.nconnected;
	}

	public void setNconnected(final Integer nconnected) {
		this.nconnected = nconnected;
	}

	/**
	 * @return last login date as string
	 * @deprecated use {@link #getDlastlogin()}
	 */
	@Deprecated
	@Column(name = "CLASTLOGIN", length = 20)
	public String getClastlogin() {
		return this.clastlogin;
	}

	/**
	 * @param clastlogin last login date as string
	 * @deprecated use {@link #setDlastlogin(Date)}
	 */
	@Deprecated
	public void setClastlogin(final String clastlogin) {
		this.clastlogin = clastlogin;
	}

	@Column(name = "CBUILD", length = 10)
	public String getCbuild() {
		return this.cbuild;
	}

	public void setCbuild(final String cbuild) {
		this.cbuild = cbuild;
	}

	/**
	 * @return encrypted password
	 * @deprecated use {@link #getCuserPwd()}
	 */
	@Deprecated
	@Column(name = "RUSER_PWD")
	@Type(type = "org.hibernate.type.BinaryType") // needed due to migration to spring boot > 2.0
	public byte[] getRuserPwd() {
		return this.ruserPwd;
	}

	/**
	 * @param ruserPwd encrypted password
	 * @deprecated use {@link #setCuserPwd(String)}
	 */
	@Deprecated
	public void setRuserPwd(final byte[] ruserPwd) {
		this.ruserPwd = ruserPwd;
	}

	@Column(name = "CPWD_INIT", length = 100)
	public String getCpwdInit() {
		return this.cpwdInit;
	}

	public void setCpwdInit(final String cpwdInit) {
		this.cpwdInit = cpwdInit;
	}

	/** @deprecated use {@link #getDpwdDate()} */
	@Deprecated
	@Column(name = "CPWD_DATE", length = 20)
	public String getCpwdDate() {
		return this.cpwdDate;
	}

	/** @deprecated use {@link #setDpwdDate(Date)} */
	@Deprecated
	public void setCpwdDate(final String cpwdDate) {
		this.cpwdDate = cpwdDate;
	}

	/** @return 1 for inital password and 0 for normal password */
	@Column(name = "NPWD_IS_INIT", precision = 1, scale = 0)
	public Integer getNpwdIsInit() {
		return this.npwdIsInit;
	}

	public void setNpwdIsInit(final Integer npwdIsInit) {
		this.npwdIsInit = npwdIsInit;
	}

	/** @return {@code true} if the password is the inital password. */
	@Transient
	@JsonIgnore
	public boolean isInitPassword() {
		return npwdIsInit == 1;
	}

	/** 1 - is tech user, 0 or other - normal user */
	@Column(name = "NTECHUSER", precision = 1, scale = 0)
	public Integer getNtechuser() {
		return this.ntechuser;
	}

	public void setNtechuser(final Integer ntechuser) {
		this.ntechuser = ntechuser;
	}

	/** @return {@code true} if user is a technical(system) user */
	@Transient
	@JsonIgnore
	public boolean isTechUser() {
		return ntechuser == 1;
	}

	/**
	 * Get the lock state of account
	 *
	 * @return 0 for unlocked and 1 for locked account.
	 */
	@Column(name = "NACCOUNT_LOCKED", precision = 1, scale = 0)
	public Integer getNaccountLocked() {
		return this.naccountLocked;
	}

	/**
	 * Set the lock state of account.
	 *
	 * @param naccountLocked 0 - unlock account, 1 - lock account
	 */
	public void setNaccountLocked(final Integer naccountLocked) {
		this.naccountLocked = naccountLocked;
	}

	/** @return {@code true} if the acount is locked */
	@Transient
	@JsonIgnore
	public boolean isAccountLocked() {
		return naccountLocked != 0;
	}

	/** Account locked. */
	public void lockAccount() {
		setNaccountLocked(1);
	}

	/** Account unlocked. */
	public void unlockAccount() {
		setNaccountLocked(0);
	}

	@Column(name = "NGRACE_LOGINS", nullable = false, precision = 2, scale = 0)
	public int getNgraceLogins() {
		return this.ngraceLogins;
	}

	public void setNgraceLogins(final int ngraceLogins) {
		this.ngraceLogins = ngraceLogins;
	}

	/** @return {@code true} if grace logins available */
	@Transient
	@JsonIgnore
	public boolean isGraceLoginsAvailable() {
		return ngraceLogins > 0;
	}

	/** Reduces the available grace logins by 1, if there are still some grace logins available */
	@Transient
	@JsonIgnore
	public void reduceGraceLogins() {
		if (isGraceLoginsAvailable()) {
			setNgraceLogins(getNgraceLogins() - 1);
		}
	}

	/** Resets the temp password and the temp password validity */
	@Transient
	@JsonIgnore
	public void resetTempPwd() {
		ctempPwd = null;
		dvalidtoTemppwd = null;
	}

	@Column(name = "NFAILED_LOGINS", precision = 2, scale = 0)
	public Integer getNfailedLogins() {
		return this.nfailedLogins;
	}

	public void setNfailedLogins(final Integer nfailedLogins) {
		this.nfailedLogins = nfailedLogins;
	}

	/**
	 * Date for last change of Password.
	 *
	 * @return the last change password date.
	 */
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DPWD_DATE", length = 7)
	public Date getDpwdDate() {
		return this.dpwdDate;
	}

	public void setDpwdDate(final Date dpwdDate) {
		this.dpwdDate = dpwdDate;
	}

	@Column(name = "CEMAIL_ADDRESS", length = 80)
	public String getCemailAddress() {
		return this.cemailAddress;
	}

	public void setCemailAddress(final String cemailAddress) {
		this.cemailAddress = cemailAddress;
	}

	/**
	 * The user password is encryped and bas64 encoded.
	 *
	 * @return the encrypted user password.
	 */
	@Column(name = "CUSER_PWD", length = 200)
	public String getCuserPwd() {
		return this.cuserPwd;
	}

	public void setCuserPwd(final String cuserPwd) {
		this.cuserPwd = cuserPwd;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DLASTLOGIN", length = 7)
	public Date getDlastlogin() {
		return this.dlastlogin;
	}

	public void setDlastlogin(final Date dlastlogin) {
		this.dlastlogin = dlastlogin;
	}

	@Column(name = "CTEMP_PWD", length = 200)
	public String getCtempPwd() {
		return this.ctempPwd;
	}

	public void setCtempPwd(String ctempPwd) {
		this.ctempPwd = ctempPwd;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALIDTO_TEMPPWD", length = 7)
	public Date getDvalidtoTemppwd() {
		return this.dvalidtoTemppwd;
	}

	public void setDvalidtoTemppwd(Date dvalidtoTemppwd) {
		this.dvalidtoTemppwd = dvalidtoTemppwd;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLogin")
	public Set<SysLoginHistory> getSysLoginHistories() {
		return this.sysLoginHistories;
	}

	public void setSysLoginHistories(final Set<SysLoginHistory> sysLoginHistories) {
		this.sysLoginHistories = sysLoginHistories;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "SYS_LOGIN_GROUPS", joinColumns = {
			@JoinColumn(name = "NUSER_ID", nullable = false, updatable = false) }, inverseJoinColumns = {
			@JoinColumn(name = "NROLE_GROUPKEY", nullable = false, updatable = false) })
	public Set<SysRoleGroups> getSysRoleGroupses() {
		return this.sysRoleGroupses;
	}

	public void setSysRoleGroupses(final Set<SysRoleGroups> sysRoleGroupses) {
		this.sysRoleGroupses = sysRoleGroupses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLogin")
	public Set<SysLoginRoles> getSysLoginRoleses() {
		return this.sysLoginRoleses;
	}

	public void setSysLoginRoleses(final Set<SysLoginRoles> sysLoginRoleses) {
		this.sysLoginRoleses = sysLoginRoleses;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLogin")
	public Set<SysAppUserSetting> getSysAppUserSettings() {
		return this.sysAppUserSettings;
	}

	public void setSysAppUserSettings(final Set<SysAppUserSetting> sysAppUserSettings) {
		this.sysAppUserSettings = sysAppUserSettings;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysLogins")
	public Set<CenOut> getCenOuts() {
		return this.cenOuts;
	}

	public void setCenOuts(final Set<CenOut> cenOuts) {
		this.cenOuts = cenOuts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysLogin")
	public Set<CenOutCsoShown> getCenOutCsoShowns() {
		return this.cenOutCsoShowns;
	}

	public void setCenOutCsoShowns(final Set<CenOutCsoShown> cenOutCsoShowns) {
		this.cenOutCsoShowns = cenOutCsoShowns;
	}
}
