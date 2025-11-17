package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.10.2016 06:28:29 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_KEYWORD_GROUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_KEYWORD_GROUP")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "ngroupKey")
public class SysSlsKeywordGroup implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long ngroupKey;
	private String cgroup;
	private int ngroupsort;
	private boolean nalways;
	private String ccontentText;
	private String cintroductionText;
	private int nprjGroupsort;
	private Set<SysSlsKeywordCategory> sysSlsKeywordCategories = new HashSet<>(0);
	private Set<CenSlsConcept> cenSlsConceptses = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_KEYWORD_GROUP")
	@SequenceGenerator(name = "SEQ_SYS_SLS_KEYWORD_GROUP", sequenceName = "SEQ_SYS_SLS_KEYWORD_GROUP", allocationSize = 1)
	@Column(name = "NGROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNgroupKey() {
		return this.ngroupKey;
	}

	public void setNgroupKey(final long ngroupKey) {
		this.ngroupKey = ngroupKey;
	}

	@Column(name = "CGROUP", nullable = false, length = 100)
	public String getCgroup() {
		return this.cgroup;
	}

	public void setCgroup(final String cgroup) {
		this.cgroup = cgroup;
	}

	@Column(name = "NGROUPSORT", nullable = false, precision = 3, scale = 0)
	public int getNgroupsort() {
		return this.ngroupsort;
	}

	public void setNgroupsort(final int ngroupsort) {
		this.ngroupsort = ngroupsort;
	}

	@Column(name = "NALWAYS", nullable = false, precision = 1, scale = 0)
	public boolean isNalways() {
		return this.nalways;
	}

	public void setNalways(final boolean nalways) {
		this.nalways = nalways;
	}

	@Column(name = "CCONTENT_TEXT", nullable = false, length = 100)
	public String getCcontentText() {
		return this.ccontentText;
	}

	public void setCcontentText(final String ccontentText) {
		this.ccontentText = ccontentText;
	}

	@Column(name = "CINTRODUCTION_TEXT", nullable = false, length = 500)
	public String getCintroductionText() {
		return this.cintroductionText;
	}

	public void setCintroductionText(final String cintroductionText) {
		this.cintroductionText = cintroductionText;
	}

	@Column(name = "NPRJ_GROUPSORT", nullable = false, precision = 3, scale = 0)
	public int getNprjGroupsort() {
		return this.nprjGroupsort;
	}

	public void setNprjGroupsort(final int nprjGroupsort) {
		this.nprjGroupsort = nprjGroupsort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsKeywordGroup")
	public Set<SysSlsKeywordCategory> getSysSlsKeywordCategories() {
		return this.sysSlsKeywordCategories;
	}

	public void setSysSlsKeywordCategories(final Set<SysSlsKeywordCategory> sysSlsKeywordCategories) {
		this.sysSlsKeywordCategories = sysSlsKeywordCategories;
	}

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsKeywordGroups")
	public Set<CenSlsConcept> getCenSlsConceptses() {
		return this.cenSlsConceptses;
	}

	public void setCenSlsConceptses(final Set<CenSlsConcept> cenSlsConceptses) {
		this.cenSlsConceptses = cenSlsConceptses;
	}

}
