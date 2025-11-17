package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table SYS_LOGIN_ROLES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGIN_ROLES")
public class SysLoginRoles implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysLoginRolesId id;

	private SysRoles sysRoles;

	private SysLogin sysLogin;

	private int nread;

	private int nwrite;

	private int ndelete;

	private int nprint;

	public SysLoginRoles() {
	}

	public SysLoginRoles(final SysLoginRolesId id, final SysRoles sysRoles, final SysLogin sysLogin, final int nread, final int nwrite,
			final int ndelete, final int nprint) {
		this.id = id;
		this.sysRoles = sysRoles;
		this.sysLogin = sysLogin;
		this.nread = nread;
		this.nwrite = nwrite;
		this.ndelete = ndelete;
		this.nprint = nprint;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nuserId", column = @Column(name = "NUSER_ID", nullable = false, precision = 5, scale = 0)),
			@AttributeOverride(name = "nroleId", column = @Column(name = "NROLE_ID", nullable = false, precision = 5, scale = 0)) })
	public SysLoginRolesId getId() {
		return this.id;
	}

	public void setId(final SysLoginRolesId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROLE_ID", nullable = false, insertable = false, updatable = false)
	public SysRoles getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(final SysRoles sysRoles) {
		this.sysRoles = sysRoles;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false, insertable = false, updatable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

	@Column(name = "NREAD", nullable = false, precision = 1, scale = 0)
	public int getNread() {
		return this.nread;
	}

	public void setNread(final int nread) {
		this.nread = nread;
	}

	@Column(name = "NWRITE", nullable = false, precision = 1, scale = 0)
	public int getNwrite() {
		return this.nwrite;
	}

	public void setNwrite(final int nwrite) {
		this.nwrite = nwrite;
	}

	@Column(name = "NDELETE", nullable = false, precision = 1, scale = 0)
	public int getNdelete() {
		return this.ndelete;
	}

	public void setNdelete(final int ndelete) {
		this.ndelete = ndelete;
	}

	@Column(name = "NPRINT", nullable = false, precision = 1, scale = 0)
	public int getNprint() {
		return this.nprint;
	}

	public void setNprint(final int nprint) {
		this.nprint = nprint;
	}

}
