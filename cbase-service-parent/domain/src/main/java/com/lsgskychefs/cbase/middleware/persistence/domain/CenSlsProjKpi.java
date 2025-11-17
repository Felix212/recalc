package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.02.2017 14:23:34 by Hibernate Tools 4.3.5.Final

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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_KPI
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_KPI")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojKpiKey")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenSlsProjKpi implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojKpiKey;
	private CenSlsProjKpiGroup cenSlsProjKpiGroup;
	private long nkpiKey;
	private String ckpi;
	private int nkpiSort;
	private Integer ncustomerKpi;
	private Set<CenSlsProjConceptKpi> cenSlsProjConceptKpis = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_PROJ_KPI")
	@SequenceGenerator(name = "SEQ_CEN_SLS_PROJ_KPI", sequenceName = "SEQ_CEN_SLS_PROJ_KPI", allocationSize = 1)
	@Column(name = "NPROJ_KPI_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojKpiKey() {
		return this.nprojKpiKey;
	}

	public void setNprojKpiKey(final long nprojKpiKey) {
		this.nprojKpiKey = nprojKpiKey;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_KPI_GROUP_KEY", nullable = false)
	public CenSlsProjKpiGroup getCenSlsProjKpiGroup() {
		return this.cenSlsProjKpiGroup;
	}

	public void setCenSlsProjKpiGroup(final CenSlsProjKpiGroup cenSlsProjKpiGroup) {
		this.cenSlsProjKpiGroup = cenSlsProjKpiGroup;
	}

	@Column(name = "NKPI_KEY", nullable = false, precision = 12, scale = 0)
	public long getNkpiKey() {
		return this.nkpiKey;
	}

	public void setNkpiKey(final long nkpiKey) {
		this.nkpiKey = nkpiKey;
	}

	@Column(name = "CKPI", nullable = false, length = 200)
	public String getCkpi() {
		return this.ckpi;
	}

	public void setCkpi(final String ckpi) {
		this.ckpi = ckpi;
	}

	@Column(name = "NKPI_SORT", nullable = false, precision = 3, scale = 0)
	public int getNkpiSort() {
		return this.nkpiSort;
	}

	public void setNkpiSort(final int nkpiSort) {
		this.nkpiSort = nkpiSort;
	}

	@Column(name = "NCUSTOMER_KPI", precision = 2, scale = 0)
	public Integer getNcustomerKpi() {
		return this.ncustomerKpi;
	}

	public void setNcustomerKpi(final Integer ncustomerKpi) {
		this.ncustomerKpi = ncustomerKpi;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProjKpi")
	public Set<CenSlsProjConceptKpi> getCenSlsProjConceptKpis() {
		return this.cenSlsProjConceptKpis;
	}

	public void setCenSlsProjConceptKpis(final Set<CenSlsProjConceptKpi> cenSlsProjConceptKpis) {
		this.cenSlsProjConceptKpis = cenSlsProjConceptKpis;
	}

}
