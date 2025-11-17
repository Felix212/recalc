package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Sep 11, 2024 4:18:20 PM by Hibernate Tools 4.3.5.Final

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_MP_MENUGRID_CYCLE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MP_MENUGRID_CYCLE")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenMpMenugridCycle implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nmpMenugridCycleKey;
	private CenMpMenugrid cenMpMenugrid;
	private String cname;
	private long nsort;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;

	private List<CenMpMenugridCategory> cenMpMenugridCategories = new ArrayList<>();

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MP_MENUGRID_CYCLE")
	@SequenceGenerator(name = "SEQ_CEN_MP_MENUGRID_CYCLE", sequenceName = "SEQ_CEN_MP_MENUGRID_CYCLE", allocationSize = 1)
	@Column(name = "NMP_MENUGRID_CYCLE_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmpMenugridCycleKey() {
		return this.nmpMenugridCycleKey;
	}

	public void setNmpMenugridCycleKey(long nmpMenugridCycleKey) {
		this.nmpMenugridCycleKey = nmpMenugridCycleKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NMP_MENUGRID_KEY", nullable = false)
	public CenMpMenugrid getCenMpMenugrid() {
		return this.cenMpMenugrid;
	}

	public void setCenMpMenugrid(CenMpMenugrid cenMpMenugrid) {
		this.cenMpMenugrid = cenMpMenugrid;
	}

	@Column(name = "CNAME", length = 256)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "NSORT", nullable = false, precision = 12, scale = 0)
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenMpMenugridCycle")
	public List<CenMpMenugridCategory> getCenMpMenugridCategories() {
		return cenMpMenugridCategories;
	}

	public void setCenMpMenugridCategories(
			List<CenMpMenugridCategory> cenMpMenugridCategories) {
		this.cenMpMenugridCategories = cenMpMenugridCategories;
	}
}


