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
 * Entity(DomainObject) for table SYS_ROLE_GROUPS_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ROLE_GROUPS_DETAIL")
public class SysRoleGroupsDetail implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private SysRoleGroupsDetailId id;

	private SysRoleGroups sysRoleGroups;

	private SysRoles sysRoles;

	private int ndefaultread;

	private int ndefaultwrite;

	private int ndefaultdelete;

	private int ndefaultprint;

	private int nuse4web;

	public SysRoleGroupsDetail() {
	}

	public SysRoleGroupsDetail(final SysRoleGroupsDetailId id, final SysRoleGroups sysRoleGroups, final SysRoles sysRoles,
			final int ndefaultread, final int ndefaultwrite, final int ndefaultdelete, final int ndefaultprint, final int nuse4web) {
		this.id = id;
		this.sysRoleGroups = sysRoleGroups;
		this.sysRoles = sysRoles;
		this.ndefaultread = ndefaultread;
		this.ndefaultwrite = ndefaultwrite;
		this.ndefaultdelete = ndefaultdelete;
		this.ndefaultprint = ndefaultprint;
		this.nuse4web = nuse4web;
	}

	@EmbeddedId

	@AttributeOverrides({
			@AttributeOverride(name = "nroleGroupkey",
					column = @Column(name = "NROLE_GROUPKEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nroleId", column = @Column(name = "NROLE_ID", nullable = false, precision = 5, scale = 0)) })
	public SysRoleGroupsDetailId getId() {
		return this.id;
	}

	public void setId(final SysRoleGroupsDetailId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROLE_GROUPKEY", nullable = false, insertable = false, updatable = false)
	public SysRoleGroups getSysRoleGroups() {
		return this.sysRoleGroups;
	}

	public void setSysRoleGroups(final SysRoleGroups sysRoleGroups) {
		this.sysRoleGroups = sysRoleGroups;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NROLE_ID", nullable = false, insertable = false, updatable = false)
	public SysRoles getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(final SysRoles sysRoles) {
		this.sysRoles = sysRoles;
	}

	@Column(name = "NDEFAULTREAD", nullable = false, precision = 1, scale = 0)
	public int getNdefaultread() {
		return this.ndefaultread;
	}

	public void setNdefaultread(final int ndefaultread) {
		this.ndefaultread = ndefaultread;
	}

	@Column(name = "NDEFAULTWRITE", nullable = false, precision = 1, scale = 0)
	public int getNdefaultwrite() {
		return this.ndefaultwrite;
	}

	public void setNdefaultwrite(final int ndefaultwrite) {
		this.ndefaultwrite = ndefaultwrite;
	}

	@Column(name = "NDEFAULTDELETE", nullable = false, precision = 1, scale = 0)
	public int getNdefaultdelete() {
		return this.ndefaultdelete;
	}

	public void setNdefaultdelete(final int ndefaultdelete) {
		this.ndefaultdelete = ndefaultdelete;
	}

	@Column(name = "NDEFAULTPRINT", nullable = false, precision = 1, scale = 0)
	public int getNdefaultprint() {
		return this.ndefaultprint;
	}

	public void setNdefaultprint(final int ndefaultprint) {
		this.ndefaultprint = ndefaultprint;
	}

	@Column(name = "NUSE4WEB", nullable = false, precision = 1, scale = 0)
	public int getNuse4web() {
		return this.nuse4web;
	}

	public void setNuse4web(final int nuse4web) {
		this.nuse4web = nuse4web;
	}

}
