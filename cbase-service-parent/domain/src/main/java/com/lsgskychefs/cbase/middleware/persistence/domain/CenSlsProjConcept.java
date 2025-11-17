package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 27.02.2017 14:23:34 by Hibernate Tools 4.3.5.Final

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJ_CONCEPT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJ_CONCEPT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojConceptKey")
public class CenSlsProjConcept implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojConceptKey;
	private CenSlsProject cenSlsProject;
	private Long nconceptKey;
	private String cname;
	private byte[] bpicture;
	private String cdescription;
	private Integer nstatus;
	private String cowner;
	private Date dtimestamp;
	private Set<CenSlsProjConceptKpi> cenSlsProjConceptKpis = new HashSet<>(0);
	private Set<CenSlsProjConcAtt> cenSlsProjConcAtts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_PROJ_CONCEPT")
	@SequenceGenerator(name = "SEQ_CEN_SLS_PROJ_CONCEPT", sequenceName = "SEQ_CEN_SLS_PROJ_CONCEPT", allocationSize = 1)
	@Column(name = "NPROJ_CONCEPT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojConceptKey() {
		return this.nprojConceptKey;
	}

	public void setNprojConceptKey(final long nprojConceptKey) {
		this.nprojConceptKey = nprojConceptKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_KEY")
	@JsonIgnore
	public CenSlsProject getCenSlsProject() {
		return this.cenSlsProject;
	}

	public void setCenSlsProject(final CenSlsProject cenSlsProject) {
		this.cenSlsProject = cenSlsProject;
	}

	@Column(name = "NCONCEPT_KEY", precision = 12, scale = 0)
	public Long getNconceptKey() {
		return this.nconceptKey;
	}

	public void setNconceptKey(final Long nconceptKey) {
		this.nconceptKey = nconceptKey;
	}

	@Column(name = "CNAME", length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSTATUS", precision = 2, scale = 0)
	public Integer getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final Integer nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "COWNER", length = 40)
	public String getCowner() {
		return this.cowner;
	}

	public void setCowner(final String cowner) {
		this.cowner = cowner;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProjConcept")
	public Set<CenSlsProjConceptKpi> getCenSlsProjConceptKpis() {
		return this.cenSlsProjConceptKpis;
	}

	public void setCenSlsProjConceptKpis(final Set<CenSlsProjConceptKpi> cenSlsProjConceptKpis) {
		this.cenSlsProjConceptKpis = cenSlsProjConceptKpis;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProjConcept")
	public Set<CenSlsProjConcAtt> getCenSlsProjConcAtts() {
		return this.cenSlsProjConcAtts;
	}

	public void setCenSlsProjConcAtts(final Set<CenSlsProjConcAtt> cenSlsProjConcAtts) {
		this.cenSlsProjConcAtts = cenSlsProjConcAtts;
	}

}
