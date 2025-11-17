package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.12.2015 16:57:35 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table SYS_ROLES
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_ROLES")
public class SysRoles implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private int nroleId;
	private String croleName;
	private int ndefaultread;
	private int ndefaultwrite;
	private int ndefaultdelete;
	private int ndefaultprint;
	private int nuse4web;
	private String cdescription;
	private Integer ccheckdata;
	private Long nroleTypeKey;
	private Set<SysEuRegions> sysEuRegionses = new HashSet<>(0);
	private Set<SysRoleGroupsDetail> sysRoleGroupsDetails = new HashSet<>(0);
	private Set<SysLoginRoles> sysLoginRoleses = new HashSet<>(0);
	private Set<SysAppUserSetting> sysAppUserSettings = new HashSet<>(0);

	public SysRoles() {
	}

	public SysRoles(final int nroleId, final String croleName, final int ndefaultread, final int ndefaultwrite, final int ndefaultdelete,
			final int ndefaultprint, final int nuse4web) {
		this.nroleId = nroleId;
		this.croleName = croleName;
		this.ndefaultread = ndefaultread;
		this.ndefaultwrite = ndefaultwrite;
		this.ndefaultdelete = ndefaultdelete;
		this.ndefaultprint = ndefaultprint;
		this.nuse4web = nuse4web;
	}

	public SysRoles(final int nroleId, final String croleName, final int ndefaultread, final int ndefaultwrite, final int ndefaultdelete,
			final int ndefaultprint, final int nuse4web, final String cdescription, final Integer ccheckdata, final Long nroleTypeKey,
			final Set<SysEuRegions> sysEuRegionses, final Set<SysRoleGroupsDetail> sysRoleGroupsDetails,
			final Set<SysLoginRoles> sysLoginRoleses) {
		this.nroleId = nroleId;
		this.croleName = croleName;
		this.ndefaultread = ndefaultread;
		this.ndefaultwrite = ndefaultwrite;
		this.ndefaultdelete = ndefaultdelete;
		this.ndefaultprint = ndefaultprint;
		this.nuse4web = nuse4web;
		this.cdescription = cdescription;
		this.ccheckdata = ccheckdata;
		this.nroleTypeKey = nroleTypeKey;
		this.sysEuRegionses = sysEuRegionses;
		this.sysRoleGroupsDetails = sysRoleGroupsDetails;
		this.sysLoginRoleses = sysLoginRoleses;
	}

	@Id

	@Column(name = "NROLE_ID", unique = true, nullable = false, precision = 5, scale = 0)
	public int getNroleId() {
		return this.nroleId;
	}

	public void setNroleId(final int nroleId) {
		this.nroleId = nroleId;
	}

	@Column(name = "CROLE_NAME", nullable = false, length = 60)
	public String getCroleName() {
		return this.croleName;
	}

	public void setCroleName(final String croleName) {
		this.croleName = croleName;
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

	@Column(name = "CDESCRIPTION", length = 250)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CCHECKDATA", precision = 1, scale = 0)
	public Integer getCcheckdata() {
		return this.ccheckdata;
	}

	public void setCcheckdata(final Integer ccheckdata) {
		this.ccheckdata = ccheckdata;
	}

	@Column(name = "NROLE_TYPE_KEY", precision = 12, scale = 0)
	public Long getNroleTypeKey() {
		return this.nroleTypeKey;
	}

	public void setNroleTypeKey(final Long nroleTypeKey) {
		this.nroleTypeKey = nroleTypeKey;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRoles")
	public Set<SysEuRegions> getSysEuRegionses() {
		return this.sysEuRegionses;
	}

	public void setSysEuRegionses(final Set<SysEuRegions> sysEuRegionses) {
		this.sysEuRegionses = sysEuRegionses;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRoles")
	public Set<SysRoleGroupsDetail> getSysRoleGroupsDetails() {
		return this.sysRoleGroupsDetails;
	}

	public void setSysRoleGroupsDetails(final Set<SysRoleGroupsDetail> sysRoleGroupsDetails) {
		this.sysRoleGroupsDetails = sysRoleGroupsDetails;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRoles")
	public Set<SysLoginRoles> getSysLoginRoleses() {
		return this.sysLoginRoleses;
	}

	public void setSysLoginRoleses(final Set<SysLoginRoles> sysLoginRoleses) {
		this.sysLoginRoleses = sysLoginRoleses;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysRoles")
	public Set<SysAppUserSetting> getSysAppUserSettings() {
		return this.sysAppUserSettings;
	}

	public void setSysAppUserSettings(Set<SysAppUserSetting> sysAppUserSettings) {
		this.sysAppUserSettings = sysAppUserSettings;
	}

}
