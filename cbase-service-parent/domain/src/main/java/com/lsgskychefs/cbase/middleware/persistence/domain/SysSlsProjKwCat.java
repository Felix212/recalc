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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

/**
 * Entity(DomainObject) for table SYS_SLS_PROJ_KW_CAT
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "SYS_SLS_PROJ_KW_CAT")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "nprojKwCatKey")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class SysSlsProjKwCat implements DomainObject, java.io.Serializable {

	/** serial versionUID */
	private static final long serialVersionUID = 1L;

	private long nprojKwCatKey;
	private SysSlsProjKwGroup sysSlsProjKwGroup;
	private long ngroupKey;
	private long ncategoryKey;
	private String ccategory;
	private String cdescription;
	private String ccustDesc;
	private int nsort;
	private boolean nmandatory;
	private boolean nmultiselect;
	private boolean nconceptRelevant;
	private int nprjSort;
	private Set<SysSlsProjKw> sysSlsProjKws = new HashSet<>(0);
	private Set<CenSlsProjFreetext> cenSlsProjFreetexts = new HashSet<>(0);

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_SYS_SLS_PROJ_KW_CAT")
	@SequenceGenerator(name = "SEQ_SYS_SLS_PROJ_KW_CAT", sequenceName = "SEQ_SYS_SLS_PROJ_KW_CAT", allocationSize = 1)
	@Column(name = "NPROJ_KW_CAT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNprojKwCatKey() {
		return this.nprojKwCatKey;
	}

	public void setNprojKwCatKey(final long nprojKwCatKey) {
		this.nprojKwCatKey = nprojKwCatKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJ_KW_GROUP_KEY", nullable = false)
	@JsonIgnore
	public SysSlsProjKwGroup getSysSlsProjKwGroup() {
		return this.sysSlsProjKwGroup;
	}

	public void setSysSlsProjKwGroup(final SysSlsProjKwGroup sysSlsProjKwGroup) {
		this.sysSlsProjKwGroup = sysSlsProjKwGroup;
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

	// Soft reference to original SysSlsKeywordCategory where it was copied from
	@JsonIgnore
	@Column(name = "NCATEGORY_KEY", nullable = false, precision = 12, scale = 0)
	public long getNcategoryKey() {
		return this.ncategoryKey;
	}

	public void setNcategoryKey(final long ncategoryKey) {
		this.ncategoryKey = ncategoryKey;
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
	public boolean isNconceptRelevant() {
		return this.nconceptRelevant;
	}

	public void setNconceptRelevant(final boolean nconceptRelevant) {
		this.nconceptRelevant = nconceptRelevant;
	}

	@Column(name = "NPRJ_SORT", nullable = false, precision = 3, scale = 0)
	public int getNprjSort() {
		return this.nprjSort;
	}

	public void setNprjSort(final int nprjSort) {
		this.nprjSort = nprjSort;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsProjKwCat")
	public Set<SysSlsProjKw> getSysSlsProjKws() {
		return this.sysSlsProjKws;
	}

	public void setSysSlsProjKws(final Set<SysSlsProjKw> sysSlsProjKws) {
		this.sysSlsProjKws = sysSlsProjKws;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysSlsProjKwCat")
	@JsonIgnore
	public Set<CenSlsProjFreetext> getCenSlsProjFreetexts() {
		return this.cenSlsProjFreetexts;
	}

	public void setCenSlsProjFreetexts(final Set<CenSlsProjFreetext> cenSlsProjFreetexts) {
		this.cenSlsProjFreetexts = cenSlsProjFreetexts;
	}

}
