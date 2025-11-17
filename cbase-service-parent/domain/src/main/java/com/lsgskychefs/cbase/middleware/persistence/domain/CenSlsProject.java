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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table CEN_SLS_PROJECT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_PROJECT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojectKey")
public class CenSlsProject implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojectKey;

	private SysSlsAirline sysSlsAirline;

	private String cname;

	private int nstatus;

	private String cowner;

	private Date dtimestamp;

	private Set<CenSlsProjFreetext> cenSlsProjFreetexts = new HashSet<>(0);

	private Set<CenSlsProjConcept> cenSlsProjConcepts = new HashSet<>(0);

	private Set<SysSlsProjKwGroup> sysSlsProjKwGroups = new HashSet<>(0);

	private Set<SysSlsProjKw> sysSlsProjKws = new HashSet<>(0);

	private Set<CenSlsProjKpiGroup> cenSlsProjKpiGroups = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_SLS_PROJECT", sequenceName = "SEQ_CEN_SLS_PROJECT", allocationSize = 1)
	@Column(name = "NPROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNprojectKey() {
		return this.nprojectKey;
	}

	public void setNprojectKey(final long nprojectKey) {
		this.nprojectKey = nprojectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_KEY", nullable = false)
	@JsonView(View.SimpleWithReferences.class)
	public SysSlsAirline getSysSlsAirline() {
		return this.sysSlsAirline;
	}

	public void setSysSlsAirline(final SysSlsAirline sysSlsAirline) {
		this.sysSlsAirline = sysSlsAirline;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	@JsonView(View.Simple.class)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	@JsonView(View.Simple.class)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "COWNER", nullable = false, length = 40)
	@JsonView(View.Simple.class)
	public String getCowner() {
		return this.cowner;
	}

	public void setCowner(final String cowner) {
		this.cowner = cowner;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	@JsonView(View.Simple.class)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProject")
	@JsonView(View.SimpleWithReferences.class)
	public Set<SysSlsProjKwGroup> getSysSlsProjKwGroups() {
		return this.sysSlsProjKwGroups;
	}

	public void setSysSlsProjKwGroups(final Set<SysSlsProjKwGroup> sysSlsProjKwGroups) {
		this.sysSlsProjKwGroups = sysSlsProjKwGroups;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProject")
	@JsonView(View.SimpleWithReferences.class)
	public Set<CenSlsProjFreetext> getCenSlsProjFreetexts() {
		return this.cenSlsProjFreetexts;
	}

	public void setCenSlsProjFreetexts(final Set<CenSlsProjFreetext> cenSlsProjFreetexts) {
		this.cenSlsProjFreetexts = cenSlsProjFreetexts;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProject")
	@JsonView(View.SimpleWithReferences.class)
	public Set<CenSlsProjConcept> getCenSlsProjConcepts() {
		return this.cenSlsProjConcepts;
	}

	public void setCenSlsProjConcepts(final Set<CenSlsProjConcept> cenSlsProjConcepts) {
		this.cenSlsProjConcepts = cenSlsProjConcepts;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "CEN_SLS_PROJ_KEYWORD", joinColumns = {
			@JoinColumn(name = "NPROJECT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NPROJ_KW_KEY", nullable = false, updatable = false) })
	@JsonView(View.SimpleWithReferences.class)
	public Set<SysSlsProjKw> getSysSlsProjKws() {
		return this.sysSlsProjKws;
	}

	public void setSysSlsProjKws(final Set<SysSlsProjKw> sysSlsProjKws) {
		this.sysSlsProjKws = sysSlsProjKws;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsProject")
	@JsonView(View.SimpleWithReferences.class)
	public Set<CenSlsProjKpiGroup> getCenSlsProjKpiGroups() {
		return this.cenSlsProjKpiGroups;
	}

	public void setCenSlsProjKpiGroups(final Set<CenSlsProjKpiGroup> cenSlsProjKpiGroups) {
		this.cenSlsProjKpiGroups = cenSlsProjKpiGroups;
	}

}
