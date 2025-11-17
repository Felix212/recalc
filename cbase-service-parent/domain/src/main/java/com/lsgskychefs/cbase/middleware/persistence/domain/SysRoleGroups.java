package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table SYS_ROLE_GROUPS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ROLE_GROUPS", uniqueConstraints = @UniqueConstraint(columnNames = "CTEXT"))
public class SysRoleGroups implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nroleGroupkey;

	private String ctext;

	private String cdescription;

	private Set<SysLogin> sysLogins = new HashSet<>(0);

	private Set<SysRoleGroupsDetail> sysRoleGroupsDetails = new HashSet<>(0);

	public SysRoleGroups() {
	}

	public SysRoleGroups(final long nroleGroupkey, final String ctext) {
		this.nroleGroupkey = nroleGroupkey;
		this.ctext = ctext;
	}

	public SysRoleGroups(final long nroleGroupkey, final String ctext, final String cdescription, final Set<SysLogin> sysLogins,
			final Set<SysRoleGroupsDetail> sysRoleGroupsDetails) {
		this.nroleGroupkey = nroleGroupkey;
		this.ctext = ctext;
		this.cdescription = cdescription;
		this.sysLogins = sysLogins;
		this.sysRoleGroupsDetails = sysRoleGroupsDetails;
	}

	@Id

	@Column(name = "NROLE_GROUPKEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNroleGroupkey() {
		return this.nroleGroupkey;
	}

	public void setNroleGroupkey(final long nroleGroupkey) {
		this.nroleGroupkey = nroleGroupkey;
	}

	@Column(name = "CTEXT", unique = true, nullable = false, length = 30)
	public String getCtext() {
		return this.ctext;
	}

	public void setCtext(final String ctext) {
		this.ctext = ctext;
	}

	@Column(name = "CDESCRIPTION", length = 250)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysRoleGroupses")
	public Set<SysLogin> getSysLogins() {
		return this.sysLogins;
	}

	public void setSysLogins(final Set<SysLogin> sysLogins) {
		this.sysLogins = sysLogins;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRoleGroups")
	public Set<SysRoleGroupsDetail> getSysRoleGroupsDetails() {
		return this.sysRoleGroupsDetails;
	}

	public void setSysRoleGroupsDetails(final Set<SysRoleGroupsDetail> sysRoleGroupsDetails) {
		this.sysRoleGroupsDetails = sysRoleGroupsDetails;
	}

}
