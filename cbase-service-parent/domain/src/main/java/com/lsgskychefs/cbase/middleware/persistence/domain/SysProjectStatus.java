package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.11.2021 12:18:42 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_PROJECT_STATUS
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_PROJECT_STATUS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysProjectStatus implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nprojectStatusKey;
	@JsonView(View.Simple.class)
	private String cstatus;
	@JsonIgnore
	private Set<CenProject> cenProjects = new HashSet<>(0);

	@Id
	@Column(name = "NPROJECT_STATUS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojectStatusKey() {
		return this.nprojectStatusKey;
	}

	public void setNprojectStatusKey(long nprojectStatusKey) {
		this.nprojectStatusKey = nprojectStatusKey;
	}

	@Column(name = "CSTATUS", length = 40)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysProjectStatus")
	public Set<CenProject> getCenProjects() {
		return this.cenProjects;
	}

	public void setCenProjects(Set<CenProject> cenProjects) {
		this.cenProjects = cenProjects;
	}

}
