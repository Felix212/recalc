package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:34:11 by Hibernate Tools 4.3.1.Final

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
 * Entity(DomainObject) for table SYS_LOGIN_GROUPS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_LOGIN_GROUPS")
public class SysLoginGroups implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private SysLoginGroupsId id;
	private SysLogin sysLogin;

	public SysLoginGroups() {
	}

	public SysLoginGroups(final SysLoginGroupsId id, final SysLogin sysLogin) {
		this.id = id;
		this.sysLogin = sysLogin;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nuserId", column = @Column(name = "NUSER_ID", nullable = false, precision = 5, scale = 0)),
			@AttributeOverride(name = "nroleGroupkey",
					column = @Column(name = "NROLE_GROUPKEY", nullable = false, precision = 12, scale = 0)) })
	public SysLoginGroupsId getId() {
		return this.id;
	}

	public void setId(final SysLoginGroupsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NUSER_ID", nullable = false, insertable = false, updatable = false)
	public SysLogin getSysLogin() {
		return this.sysLogin;
	}

	public void setSysLogin(final SysLogin sysLogin) {
		this.sysLogin = sysLogin;
	}

}
