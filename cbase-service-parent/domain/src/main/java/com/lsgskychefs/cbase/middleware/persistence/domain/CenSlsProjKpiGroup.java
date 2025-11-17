package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 17, 2017 10:39:57 AM by Hibernate Tools 4.3.5.Final

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
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_KPI_GROUP
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_KPI_GROUP")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojKpiGroupKey")
public class CenSlsProjKpiGroup implements DomainObject, java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private long nprojKpiGroupKey;
	private CenSlsProject cenSlsProject;
	private long nkpiGroupKey;
	private String ckpiGroup;
	private int nkpiGroupSort;
	private Set<CenSlsProjKpi> cenSlsProjKpis = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_PROJ_KPI_GROUP")
	@SequenceGenerator(name = "SEQ_CEN_SLS_PROJ_KPI_GROUP", sequenceName = "SEQ_CEN_SLS_PROJ_KPI_GROUP", allocationSize = 1)
	@Column(name = "NPROJ_KPI_GROUP_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojKpiGroupKey() {
		return this.nprojKpiGroupKey;
	}

	public void setNprojKpiGroupKey(final long nprojKpiGroupKey) {
		this.nprojKpiGroupKey = nprojKpiGroupKey;
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

	@Column(name = "NKPI_GROUP_KEY", nullable = false, precision = 12, scale = 0)
	public long getNkpiGroupKey() {
		return this.nkpiGroupKey;
	}

	public void setNkpiGroupKey(final long nkpiGroupKey) {
		this.nkpiGroupKey = nkpiGroupKey;
	}

	@Column(name = "CKPI_GROUP", nullable = false, length = 100)
	public String getCkpiGroup() {
		return this.ckpiGroup;
	}

	public void setCkpiGroup(final String ckpiGroup) {
		this.ckpiGroup = ckpiGroup;
	}

	@Column(name = "NKPI_GROUP_SORT", nullable = false, precision = 3, scale = 0)
	public int getNkpiGroupSort() {
		return this.nkpiGroupSort;
	}

	public void setNkpiGroupSort(final int nkpiGroupSort) {
		this.nkpiGroupSort = nkpiGroupSort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProjKpiGroup")
	public Set<CenSlsProjKpi> getCenSlsProjKpis() {
		return this.cenSlsProjKpis;
	}

	public void setCenSlsProjKpis(final Set<CenSlsProjKpi> cenSlsProjKpis) {
		this.cenSlsProjKpis = cenSlsProjKpis;
	}

}
