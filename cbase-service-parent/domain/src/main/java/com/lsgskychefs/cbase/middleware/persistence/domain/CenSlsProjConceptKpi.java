package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 28.02.2017 11:41:38 by Hibernate Tools 4.3.5.Final

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_CONCEPT_KPI
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_CONCEPT_KPI")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
@JsonIdentityReference(alwaysAsId = true)
public class CenSlsProjConceptKpi implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private CenSlsProjConceptKpiId id;
	private CenSlsProjKpi cenSlsProjKpi;
	private CenSlsProjConcept cenSlsProjConcept;
	private Integer ninternalKpi;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nprojConceptKey", column = @Column(name = "NPROJ_CONCEPT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nprojKpiKey", column = @Column(name = "NPROJ_KPI_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenSlsProjConceptKpiId getId() {
		return this.id;
	}

	public void setId(final CenSlsProjConceptKpiId id) {
		this.id = id;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_KPI_KEY", nullable = false, insertable = false, updatable = false)
	public CenSlsProjKpi getCenSlsProjKpi() {
		return this.cenSlsProjKpi;
	}

	public void setCenSlsProjKpi(final CenSlsProjKpi cenSlsProjKpi) {
		this.cenSlsProjKpi = cenSlsProjKpi;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_CONCEPT_KEY", nullable = false, insertable = false, updatable = false)
	public CenSlsProjConcept getCenSlsProjConcept() {
		return this.cenSlsProjConcept;
	}

	public void setCenSlsProjConcept(final CenSlsProjConcept cenSlsProjConcept) {
		this.cenSlsProjConcept = cenSlsProjConcept;
	}

	@Column(name = "NINTERNAL_KPI", precision = 2, scale = 0)
	public Integer getNinternalKpi() {
		return this.ninternalKpi;
	}

	public void setNinternalKpi(final Integer ninternalKpi) {
		this.ninternalKpi = ninternalKpi;
	}

}
