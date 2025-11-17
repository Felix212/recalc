package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 01.06.2016 14:43:50 by Hibernate Tools 4.3.2-SNAPSHOT

import java.util.Date;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Entity(DomainObject) for table CEN_AIRCRAFT_REGISTRATIONS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_AIRCRAFT_REGISTRATIONS")
@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
public class CenAircraftRegistrations implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;
	private CenAircraftRegistrationsId id;
	@JsonIgnore
	private CenAircraft cenAircraft;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "naircraftKey",
					column = @Column(name = "NAIRCRAFT_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "cregistration", column = @Column(name = "CREGISTRATION", nullable = false, length = 10)) })
	public CenAircraftRegistrationsId getId() {
		return this.id;
	}

	public void setId(final CenAircraftRegistrationsId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRCRAFT_KEY", nullable = false, insertable = false, updatable = false)
	public CenAircraft getCenAircraft() {
		return this.cenAircraft;
	}

	public void setCenAircraft(final CenAircraft cenAircraft) {
		this.cenAircraft = cenAircraft;
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
