package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.09.2023 14:50:08 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PL_TEMPERATURE_CATEGORY
 *
 * @author Hibernate Tools
 */
@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name = "CEN_PL_TEMPERATURE_CATEGORY")
public class CenPlTemperatureCategory implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nplTemperatureCategoryKey;
	@JsonIgnore
	private CenPackinglists cenPackinglists;
	@JsonIgnore
	private SysUnits sysUnits;
	private SysTemperatureCategory sysTemperatureCategory;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PL_TEMPERATURE_CATEGORY")
	@SequenceGenerator(name = "SEQ_CEN_PL_TEMPERATURE_CATEGORY", sequenceName = "SEQ_CEN_PL_TEMPERATURE_CATEGORY", allocationSize = 1)
	@Column(name = "NPL_TEMPERATURE_CATEGORY_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplTemperatureCategoryKey() {
		return this.nplTemperatureCategoryKey;
	}

	public void setNplTemperatureCategoryKey(long nplTemperatureCategoryKey) {
		this.nplTemperatureCategoryKey = nplTemperatureCategoryKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUNIT", nullable = false)
	public SysUnits getSysUnits() {
		return this.sysUnits;
	}

	public void setSysUnits(SysUnits sysUnits) {
		this.sysUnits = sysUnits;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NTEMPERATURE_CATEGORY_KEY", nullable = false)
	public SysTemperatureCategory getSysTemperatureCategory() {
		return this.sysTemperatureCategory;
	}

	public void setSysTemperatureCategory(SysTemperatureCategory sysTemperatureCategory) {
		this.sysTemperatureCategory = sysTemperatureCategory;
	}

	@CreationTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DCREATED_ON", length = 7)
	public Date getDcreatedOn() {
		return this.dcreatedOn;
	}

	public void setDcreatedOn(Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	@CreatedBy
	@Column(name = "CCREATED_BY", length = 40)
	public String getCcreatedBy() {
		return this.ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	@UpdateTimestamp
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_ON", length = 7)
	public Date getDupdatedOn() {
		return this.dupdatedOn;
	}

	public void setDupdatedOn(Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	@LastModifiedBy
	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

}


