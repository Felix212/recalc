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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_KEYWORD_CATEGORY
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_KEYWORD_CATEGORY")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "ncategoryKey")
public class SysSlsKeywordCategory implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long ncategoryKey;
	private SysSlsKeywordGroup sysSlsKeywordGroup;
	private String ccategory;
	private String cdescription;
	private String ccustDesc;
	private int nsort;
	private boolean nmandatory;
	private boolean nmultiselect;
	private int nconceptRelevant;
	private int nprjSort;
	private Set<SysSlsKeyword> sysSlsKeywords = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_KEYWORD_CATEGORY")
	@SequenceGenerator(name = "SEQ_SYS_SLS_KEYWORD_CATEGORY", sequenceName = "SEQ_SYS_SLS_KEYWORD_CATEGORY", allocationSize = 1)
	@Column(name = "NCATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNcategoryKey() {
		return this.ncategoryKey;
	}

	public void setNcategoryKey(final long ncategoryKey) {
		this.ncategoryKey = ncategoryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NGROUP_KEY", nullable = false)
	public SysSlsKeywordGroup getSysSlsKeywordGroup() {
		return this.sysSlsKeywordGroup;
	}

	public void setSysSlsKeywordGroup(final SysSlsKeywordGroup sysSlsKeywordGroup) {
		this.sysSlsKeywordGroup = sysSlsKeywordGroup;
	}

	@Column(name = "CCATEGORY", nullable = false, length = 40)
	public String getCcategory() {
		return this.ccategory;
	}

	public void setCcategory(final String ccategory) {
		this.ccategory = ccategory;
	}

	@Column(name = "CDESCRIPTION", length = 256)
	public String getCdescription() {
		return this.cdescription;
	}

	public void setCdescription(final String cdescription) {
		this.cdescription = cdescription;
	}

	@Column(name = "CCUST_DESC", length = 256)
	public String getCcustDesc() {
		return this.ccustDesc;
	}

	public void setCcustDesc(final String ccustDesc) {
		this.ccustDesc = ccustDesc;
	}

	@Column(name = "NSORT", nullable = false, precision = 3, scale = 0)
	public int getNsort() {
		return this.nsort;
	}

	public void setNsort(final int nsort) {
		this.nsort = nsort;
	}

	@Column(name = "NMANDATORY", nullable = false, precision = 1, scale = 0)
	public boolean isNmandatory() {
		return this.nmandatory;
	}

	public void setNmandatory(final boolean nmandatory) {
		this.nmandatory = nmandatory;
	}

	@Column(name = "NMULTISELECT", nullable = false, precision = 1, scale = 0)
	public boolean isNmultiselect() {
		return this.nmultiselect;
	}

	public void setNmultiselect(final boolean nmultiselect) {
		this.nmultiselect = nmultiselect;
	}

	@Column(name = "NCONCEPT_RELEVANT", nullable = false, precision = 1, scale = 0)
	public int getNconceptRelevant() {
		return this.nconceptRelevant;
	}

	public void setNconceptRelevant(final int nconceptRelevant) {
		this.nconceptRelevant = nconceptRelevant;
	}

	@Column(name = "NPRJ_SORT", nullable = false, precision = 3, scale = 0)
	public int getNprjSort() {
		return this.nprjSort;
	}

	public void setNprjSort(final int nprjSort) {
		this.nprjSort = nprjSort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsKeywordCategory")
	public Set<SysSlsKeyword> getSysSlsKeywords() {
		return this.sysSlsKeywords;
	}

	public void setSysSlsKeywords(final Set<SysSlsKeyword> sysSlsKeywords) {
		this.sysSlsKeywords = sysSlsKeywords;
	}

}
