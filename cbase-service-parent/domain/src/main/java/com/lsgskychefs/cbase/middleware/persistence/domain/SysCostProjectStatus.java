package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 18.07.2023 10:16:43 by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table SYS_COST_PROJECT_STATUS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_COST_PROJECT_STATUS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysCostProjectStatus implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long ncostProjectStatusKey;
	private String cstatus;
	@JsonIgnore
	private Set<CenCostProject> cenCostProjects = new HashSet<>(0);

	@Id
	@Column(name = "NCOST_PROJECT_STATUS_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcostProjectStatusKey() {
		return this.ncostProjectStatusKey;
	}

	public void setNcostProjectStatusKey(long ncostProjectStatusKey) {
		this.ncostProjectStatusKey = ncostProjectStatusKey;
	}

	@Column(name = "CSTATUS", length = 40)
	public String getCstatus() {
		return this.cstatus;
	}

	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysCostProjectStatus")
	public Set<CenCostProject> getCenCostProjects() {
		return this.cenCostProjects;
	}

	public void setCenCostProjects(Set<CenCostProject> cenCostProjects) {
		this.cenCostProjects = cenCostProjects;
	}

}


