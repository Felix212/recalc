package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

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
 * Entity(DomainObject) for table CEN_SLS_CONCEPT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_SLS_CONCEPT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nconceptKey")
public class CenSlsConcept implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	@JsonView(View.Simple.class)
	private long nconceptKey;

	@JsonView(View.Simple.class)
	private String cname;

	@JsonView(View.Simple.class)
	private String cdescription;

	@JsonView(View.Simple.class)
	private int nstatus;

	@JsonView(View.Simple.class)
	private String cowner;

	@JsonView(View.Simple.class)
	private Date dtimestamp;

	@JsonView(View.Simple.class)
	private byte[] bpicture;

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenSlsConceptUsage> cenSlsConceptUsages = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<SysSlsKeyword> sysSlsKeywords = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<SysSlsSupplier> sysSlsSuppliers = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<CenSlsConceptAttach> cenSlsConceptAttaches = new HashSet<>(0);

	@JsonView(View.SimpleWithReferences.class)
	private Set<SysSlsKeywordGroup> sysSlsKeywordGroups = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_SLS_CONCEPT")
	@SequenceGenerator(name = "SEQ_CEN_SLS_CONCEPT", sequenceName = "SEQ_CEN_SLS_CONCEPT", allocationSize = 1)
	@Column(name = "NCONCEPT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNconceptKey() {
		return this.nconceptKey;
	}

	public void setNconceptKey(final long nconceptKey) {
		this.nconceptKey = nconceptKey;
	}

	@Column(name = "CNAME", nullable = false, length = 40)
	public String getCname() {
		return this.cname;
	}

	public void setCname(final String cname) {
		this.cname = cname;
	}

	@Column(name = "CDESCRIPTION", nullable = false, length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "NSTATUS", nullable = false, precision = 2, scale = 0)
	public int getNstatus() {
		return this.nstatus;
	}

	public void setNstatus(final int nstatus) {
		this.nstatus = nstatus;
	}

	@Column(name = "COWNER", nullable = false, length = 40)
	public String getCowner() {
		return this.cowner;
	}

	public void setCowner(final String cowner) {
		this.cowner = cowner;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}

	@Column(name = "BPICTURE")
	@JsonView(View.SimpleWithReferences.class)
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsConcept")
	@JsonView(View.SimpleWithReferences.class)
	public Set<CenSlsConceptUsage> getCenSlsConceptUsages() {
		return this.cenSlsConceptUsages;
	}

	public void setCenSlsConceptUsages(final Set<CenSlsConceptUsage> cenSlsConceptUsages) {
		this.cenSlsConceptUsages = cenSlsConceptUsages;
	}

	@JsonView(View.SimpleWithReferences.class)
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "CEN_SLS_CONCEPT_KEYWORD", joinColumns = {
			@JoinColumn(name = "NCONCEPT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NKEYWORD_KEY", nullable = false, updatable = false) })
	public Set<SysSlsKeyword> getSysSlsKeywords() {
		return this.sysSlsKeywords;
	}

	public void setSysSlsKeywords(final Set<SysSlsKeyword> sysSlsKeywords) {
		this.sysSlsKeywords = sysSlsKeywords;
	}

	@JsonView(View.SimpleWithReferences.class)
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "CEN_SLS_CONCEPT_SUPPLIER", joinColumns = {
			@JoinColumn(name = "NCONCEPT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NSUPPLIER_KEY", nullable = false, updatable = false) })
	public Set<SysSlsSupplier> getSysSlsSuppliers() {
		return this.sysSlsSuppliers;
	}

	public void setSysSlsSuppliers(final Set<SysSlsSupplier> sysSlsSuppliers) {
		this.sysSlsSuppliers = sysSlsSuppliers;
	}

	@JsonView(View.SimpleWithReferences.class)
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenSlsConcept")
	public Set<CenSlsConceptAttach> getCenSlsConceptAttaches() {
		return this.cenSlsConceptAttaches;
	}

	public void setCenSlsConceptAttaches(final Set<CenSlsConceptAttach> cenSlsConceptAttaches) {
		this.cenSlsConceptAttaches = cenSlsConceptAttaches;
	}

	@JsonView(View.SimpleWithReferences.class)
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "CEN_SLS_CONCEPT_CONTENT", joinColumns = {
			@JoinColumn(name = "NCONCEPT_KEY", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "NGROUP_KEY", nullable = false, updatable = false) })
	public Set<SysSlsKeywordGroup> getSysSlsKeywordGroups() {
		return this.sysSlsKeywordGroups;
	}

	public void setSysSlsKeywordGroups(final Set<SysSlsKeywordGroup> sysSlsKeywordGroups) {
		this.sysSlsKeywordGroups = sysSlsKeywordGroups;
	}

}
