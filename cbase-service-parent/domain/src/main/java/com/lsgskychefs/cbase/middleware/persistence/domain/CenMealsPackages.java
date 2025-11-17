package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Jan 23, 2019 2:41:41 PM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_MEALS_PACKAGES
 * 
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEALS_PACKAGES")
public class CenMealsPackages implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	/** id */
	private CenMealsPackagesId id;

	/** cenAirlinePackages */
	private CenAirlinePackages cenAirlinePackages;

	/** cenMeals */
	private CenMeals cenMeals;

	/** dtimestamp */
	private Date dtimestamp;

	/** cupdatedBy */
	private String cupdatedBy;

	/** dupdatedDate */
	private Date dupdatedDate;

	/** cupdatedByPrev */
	private String cupdatedByPrev;

	/** dupdatedDatePrev */
	private Date dupdatedDatePrev;

	/** cpackageClass */
	private String cpackageClass;

	/** cpackageAll */
	private String cpackageAll;

	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "nhandlingMealKey", column = @Column(name = "NHANDLING_MEAL_KEY", nullable = false, precision = 12, scale = 0)),
			@AttributeOverride(name = "nairlinePackagesKey", column = @Column(name = "NAIRLINE_PACKAGES_KEY", nullable = false, precision = 12, scale = 0)) })
	public CenMealsPackagesId getId() {
		return this.id;
	}

	public void setId(final CenMealsPackagesId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NAIRLINE_PACKAGES_KEY", nullable = false, insertable = false, updatable = false)
	public CenAirlinePackages getCenAirlinePackages() {
		return this.cenAirlinePackages;
	}

	public void setCenAirlinePackages(final CenAirlinePackages cenAirlinePackages) {
		this.cenAirlinePackages = cenAirlinePackages;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_MEAL_KEY", nullable = false, insertable = false, updatable = false)
	public CenMeals getCenMeals() {
		return this.cenMeals;
	}

	public void setCenMeals(final CenMeals cenMeals) {
		this.cenMeals = cenMeals;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DTIMESTAMP", nullable = false, length = 7)
	public Date getDtimestamp() {
		return this.dtimestamp;
	}

	public void setDtimestamp(final Date dtimestamp) {
		this.dtimestamp = dtimestamp;
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

	@Column(name = "CPACKAGE_CLASS", nullable = false, length = 25)
	public String getCpackageClass() {
		return this.cpackageClass;
	}

	public void setCpackageClass(final String cpackageClass) {
		this.cpackageClass = cpackageClass;
	}

	@Column(name = "CPACKAGE_ALL", nullable = false, length = 25)
	public String getCpackageAll() {
		return this.cpackageAll;
	}

	public void setCpackageAll(final String cpackageAll) {
		this.cpackageAll = cpackageAll;
	}

}
