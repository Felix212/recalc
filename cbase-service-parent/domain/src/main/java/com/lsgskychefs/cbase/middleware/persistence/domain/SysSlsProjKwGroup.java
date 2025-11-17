package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.03.2017 10:38:49 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_PROJ_KW_GROUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_PROJ_KW_GROUP")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojKwGroupKey")
public class SysSlsProjKwGroup implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojKwGroupKey;
	private CenSlsProject cenSlsProject;
	private long ngroupKey;
	private String cgroup;
	private int ngroupsort;
	private boolean nalways;
	private String ccontentText;
	private String cintroductionText;
	private int nprjGroupsort;
	private Set<SysSlsProjKwCat> sysSlsProjKwCats = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_PROJ_KW_GROUP")
	@SequenceGenerator(name = "SEQ_SYS_SLS_PROJ_KW_GROUP", sequenceName = "SEQ_SYS_SLS_PROJ_KW_GROUP", allocationSize = 1)
	@Column(name = "NPROJ_KW_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojKwGroupKey() {
		return this.nprojKwGroupKey;
	}

	public void setNprojKwGroupKey(final long nprojKwGroupKey) {
		this.nprojKwGroupKey = nprojKwGroupKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_KEY", nullable = false)
	@JsonIgnore
	public CenSlsProject getCenSlsProject() {
		return this.cenSlsProject;
	}

	public void setCenSlsProject(final CenSlsProject cenSlsProject) {
		this.cenSlsProject = cenSlsProject;
	}

	// Soft reference to original SysSlsKeywordGroup where it was copied from
	@JsonIgnore
	@Column(name = "NGROUP_KEY", nullable = false, precision = 12, scale = 0)
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsProjKwGroup")
	@JsonManagedReference(value = "sys-kw-groups")
	public Set<SysSlsProjKwCat> getSysSlsProjKwCats() {
		return this.sysSlsProjKwCats;
	}

	public void setSysSlsProjKwCats(final Set<SysSlsProjKwCat> sysSlsProjKwCats) {
		this.sysSlsProjKwCats = sysSlsProjKwCats;
	}

}
