package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 10.10.2016 11:20:34 by Hibernate Tools 4.3.5.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.lsgskychefs.cbase.middleware.persistence.utils.View;

/**
 * Entity(DomainObject) for table SYS_SLS_KEYWORD
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_KEYWORD")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nkeywordKey")
public class SysSlsKeyword implements DomainObject, java.io.Serializable {
	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nkeywordKey;

	private SysSlsKeywordCategory sysSlsKeywordCategory;

	private String ckeyword;

	private String cdescription;

	private int nsort;

	private byte[] bpicture;

	private Set<CenSlsConcept> cenSlsConcepts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_KEYWORD")
	@SequenceGenerator(name = "SEQ_SYS_SLS_KEYWORD", sequenceName = "SEQ_SYS_SLS_KEYWORD", allocationSize = 1)
	@Column(name = "NKEYWORD_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	@JsonView(View.Simple.class)
	public long getNkeywordKey() {
		return this.nkeywordKey;
	}

	public void setNkeywordKey(final long nkeywordKey) {
		this.nkeywordKey = nkeywordKey;
	}

	@JsonView(View.SimpleWithReferences.class)
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NCATEGORY_KEY", nullable = false)
	public SysSlsKeywordCategory getSysSlsKeywordCategory() {
		return this.sysSlsKeywordCategory;
	}

	public void setSysSlsKeywordCategory(final SysSlsKeywordCategory sysSlsKeywordCategory) {
		this.sysSlsKeywordCategory = sysSlsKeywordCategory;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CKEYWORD", nullable = false, length = 40)
	public String getCkeyword() {
		return this.ckeyword;
	}

	public void setCkeyword(final String ckeyword) {
		this.ckeyword = ckeyword;
	}

	@JsonView(View.Simple.class)
	@Column(name = "CDESCRIPTION", nullable = true, length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@JsonView(View.Simple.class)
	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@JsonView(View.Simple.class)
	@Column(name = "BPICTURE")
	public byte[] getBpicture() {
		return this.bpicture;
	}

	public void setBpicture(final byte[] bpicture) {
		this.bpicture = bpicture;
	}

	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsKeywords")
	public Set<CenSlsConcept> getCenSlsConcepts() {
		return this.cenSlsConcepts;
	}

	public void setCenSlsConcepts(final Set<CenSlsConcept> cenSlsConcepts) {
		this.cenSlsConcepts = cenSlsConcepts;
	}

}
