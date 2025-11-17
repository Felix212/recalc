package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_SLS_AIRLINE
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_AIRLINE")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nairlineKey")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysSlsAirline implements DomainObject, java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private long nairlineKey;
	private String cairline;
	private String cname;
	private Set<CenSlsConceptUsage> cenSlsConceptUsages = new HashSet<>(0);
	private Set<CenSlsProject> cenSlsProjects = new HashSet<>(0);

	@Id
	@JsonView(View.Simple.class)
	@Column(name = "NAIRLINE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNairlineKey() {
		return this.nairlineKey;
	}

	public void setNairlineKey(final long nairlineKey) {
		this.nairlineKey = nairlineKey;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CAIRLINE", nullable = false, length = 5)
	public String getCairline() {
		return this.cairline;
	}

	public void setCairline(final String cairline) {
		this.cairline = cairline;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CNAME", nullable = false, length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsAirline")
	public Set<CenSlsConceptUsage> getCenSlsConceptUsages() {
		return this.cenSlsConceptUsages;
	}

	public void setCenSlsConceptUsages(final Set<CenSlsConceptUsage> cenSlsConceptUsages) {
		this.cenSlsConceptUsages = cenSlsConceptUsages;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsAirline")
	public Set<CenSlsProject> getCenSlsProjects() {
		return this.cenSlsProjects;
	}

	public void setCenSlsProjects(final Set<CenSlsProject> cenSlsProjects) {
		this.cenSlsProjects = cenSlsProjects;
	}

}
