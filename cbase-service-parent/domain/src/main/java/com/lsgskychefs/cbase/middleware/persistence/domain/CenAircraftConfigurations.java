package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.06.2016 14:43:50 by Hibernate Tools 4.3.2-SNAPSHOT

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_AIRCRAFT_CONFIGURATIONS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRCRAFT_CONFIGURATIONS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenAircraftConfigurations implements DomainObject, Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nconfigurationKey;
	@JsonIgnore
	private CenAircraft cenAircraft;
	private CenClassName cenClassName;
	private long ngroupKey;
	private int nversion;
	private int ndefault;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NCONFIGURATION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNconfigurationKey() {
		return this.nconfigurationKey;
	}

	public void setNconfigurationKey(final long nconfigurationKey) {
		this.nconfigurationKey = nconfigurationKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(final CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NAIRLINE_KEY", referencedColumnName = "NAIRLINE_KEY", nullable = false),
			@JoinColumn(name = "CCLASS", referencedColumnName = "CCLASS", nullable = false) })
	public CenClassName getCenClassName() {
		return this.cenClassName;
	}

	public void setCenClassName(final CenClassName cenClassName) {
		this.cenClassName = cenClassName;
	}

	@Column(name = "NGROUP_KEY", nullable = false, precision = 12, scale = 0)
	public long getNgroupKey() {
		return this.ngroupKey;
	}

	public void setNgroupKey(final long ngroupKey) {
		this.ngroupKey = ngroupKey;
	}

	@Column(name = "NVERSION", nullable = false, precision = 4, scale = 0)
	public int getNversion() {
		return this.nversion;
	}

	public void setNversion(final int nversion) {
		this.nversion = nversion;
	}

	@Column(name = "NDEFAULT", nullable = false, precision = 1, scale = 0)
	public int getNdefault() {
		return this.ndefault;
	}

	public void setNdefault(final int ndefault) {
		this.ndefault = ndefault;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(final String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(final Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(final String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(final Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

}
