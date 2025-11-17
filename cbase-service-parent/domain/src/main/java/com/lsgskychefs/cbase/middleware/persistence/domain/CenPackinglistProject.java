package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 30.11.2021 12:18:42 by Hibernate Tools 4.3.5.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_PROJECT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_PROJECT", uniqueConstraints = @UniqueConstraint(columnNames = { "NPROJECT_KEY", "NPROJECT_STRUCTURE_KEY",
		"NPACKINGLIST_INDEX_KEY", "NPACKINGLIST_DETAIL_KEY" }))
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenPackinglistProject implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistProjectKey;
	private CenPackinglists cenPackinglists;
	@JsonIgnore
	private CenProject cenProject;
	@JsonIgnore
	private CenProjectStructure cenProjectStructure;
	private String ccomment;
	private Long nsort;
	private CenFollowUpMaster cenFollowUpMaster;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PACKINGLIST_PROJECT")
	@SequenceGenerator(name = "SEQ_CEN_PACKINGLIST_PROJECT", sequenceName = "SEQ_CEN_PACKINGLIST_PROJECT", allocationSize = 1)
	@Column(name = "NPACKINGLIST_PROJECT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNpackinglistProjectKey() {
		return this.npackinglistProjectKey;
	}

	public void setNpackinglistProjectKey(final long npackinglistProjectKey) {
		this.npackinglistProjectKey = npackinglistProjectKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_KEY", nullable = false)
	public CenProject getCenProject() {
		return this.cenProject;
	}

	public void setCenProject(final CenProject cenProject) {
		this.cenProject = cenProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPROJECT_STRUCTURE_KEY")
	public CenProjectStructure getCenProjectStructure() {
		return this.cenProjectStructure;
	}

	public void setCenProjectStructure(final CenProjectStructure cenProjectStructure) {
		this.cenProjectStructure = cenProjectStructure;
	}

	@Column(name = "CCOMMENT", length = 512)
	public String getCcomment() {
		return this.ccomment;
	}

	public void setCcomment(final String ccomment) {
		this.ccomment = ccomment;
	}

	@Column(name = "NSORT", precision = 12, scale = 0)
	public Long getNsort() {
		return this.nsort;
	}

	public void setNsort(final Long nsort) {
		this.nsort = nsort;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NFOLLOW_UP_MASTER_KEY")
	public CenFollowUpMaster getCenFollowUpMaster() {
		return this.cenFollowUpMaster;
	}

	public void setCenFollowUpMaster(final CenFollowUpMaster cenFollowUpMaster) {
		this.cenFollowUpMaster = cenFollowUpMaster;
	}

}
