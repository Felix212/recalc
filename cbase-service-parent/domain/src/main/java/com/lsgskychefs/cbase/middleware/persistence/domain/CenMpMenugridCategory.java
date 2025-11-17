package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 11, 2024 4:18:20 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_MENUGRID_CATEGORY
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_MENUGRID_CATEGORY")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenMpMenugridCategory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpMenugridCategoryKey;
	@JsonIgnore
	private CenMpMenugridCycle cenMpMenugridCycle;

	private CenPlMpProject cenPlMpProject;

	@JsonIgnore
	private CenPackinglistTypes cenPackinglistTypes;
	private String cname;
	private int nisNeeded;
	private long nsort;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_MENUGRID_CATEGORY")
	@SequenceGenerator(name = "SEQ_CEN_MP_MENUGRID_CATEGORY", sequenceName = "SEQ_CEN_MP_MENUGRID_CATEGORY", allocationSize = 1)
	@Column(name = "NMP_MENUGRID_CATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpMenugridCategoryKey() {
		return this.nmpMenugridCategoryKey;
	}

	public void setNmpMenugridCategoryKey(long nmpMenugridCategoryKey) {
		this.nmpMenugridCategoryKey = nmpMenugridCategoryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_MENUGRID_CYCLE_KEY", nullable = false)
	public CenMpMenugridCycle getCenMpMenugridCycle() {
		return this.cenMpMenugridCycle;
	}

	public void setCenMpMenugridCycle(CenMpMenugridCycle cenMpMenugridCycle) {
		this.cenMpMenugridCycle = cenMpMenugridCycle;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPL_MP_PROJECT_KEY")
	public CenPlMpProject getCenPlMpProject() {
		return this.cenPlMpProject;
	}

	public void setCenPlMpProject(CenPlMpProject cenPlMpProject) {
		this.cenPlMpProject = cenPlMpProject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_KEY")
	public CenPackinglistTypes getCenPackinglistTypes() {
		return this.cenPackinglistTypes;
	}

	public void setCenPackinglistTypes(CenPackinglistTypes cenPackinglistTypes) {
		this.cenPackinglistTypes = cenPackinglistTypes;
	}

	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public int getNisNeeded() {
		return this.nisNeeded;
	}

	public void setNisNeeded(int nisNeeded) {
		this.nisNeeded = nisNeeded;
	}

	public long getNsort() {
		return this.nsort;
	}

	public void setNsort(long nsort) {
		this.nsort = nsort;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON", length = 7)
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON", length = 7)
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}


