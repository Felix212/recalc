package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 07.09.2022 09:54:55 by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_MEALS_SPML
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MEALS_SPML",
		uniqueConstraints = @UniqueConstraint(columnNames = { "NHANDLING_MEAL_KEY", "NHANDLING_KEY_SPML", "DVALID_FROM", "DVALID_TO",
				"CMEAL_CONTROL_CODE" })
)
public class CenMealsSpml implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nhandlingSpmlDetailKey;
	private CenMeals cenMeals;
	private CenHandling cenHandling;
	private Date dvalidFrom;
	private Date dvalidTo;
	private String cmealControlCode;
	private String cremark;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NHANDLING_SPML_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNhandlingSpmlDetailKey() {
		return this.nhandlingSpmlDetailKey;
	}

	public void setNhandlingSpmlDetailKey(long nhandlingSpmlDetailKey) {
		this.nhandlingSpmlDetailKey = nhandlingSpmlDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_MEAL_KEY", nullable = false)
	public CenMeals getCenMeals() {
		return this.cenMeals;
	}

	public void setCenMeals(CenMeals cenMeals) {
		this.cenMeals = cenMeals;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NHANDLING_KEY_SPML", nullable = false)
	public CenHandling getCenHandling() {
		return this.cenHandling;
	}

	public void setCenHandling(CenHandling cenHandling) {
		this.cenHandling = cenHandling;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_FROM", nullable = false, length = 7)
	public Date getDvalidFrom() {
		return this.dvalidFrom;
	}

	public void setDvalidFrom(Date dvalidFrom) {
		this.dvalidFrom = dvalidFrom;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DVALID_TO", nullable = false, length = 7)
	public Date getDvalidTo() {
		return this.dvalidTo;
	}

	public void setDvalidTo(Date dvalidTo) {
		this.dvalidTo = dvalidTo;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "CREMARK", length = 40)
	public String getCremark() {
		return this.cremark;
	}

	public void setCremark(String cremark) {
		this.cremark = cremark;
	}

	@Column(name = "CUPDATED_BY", length = 40)
	public String getCupdatedBy() {
		return this.cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE", length = 7)
	public Date getDupdatedDate() {
		return this.dupdatedDate;
	}

	public void setDupdatedDate(Date dupdatedDate) {
		this.dupdatedDate = dupdatedDate;
	}

	@Column(name = "CUPDATED_BY_PREV", length = 40)
	public String getCupdatedByPrev() {
		return this.cupdatedByPrev;
	}

	public void setCupdatedByPrev(String cupdatedByPrev) {
		this.cupdatedByPrev = cupdatedByPrev;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DUPDATED_DATE_PREV", length = 7)
	public Date getDupdatedDatePrev() {
		return this.dupdatedDatePrev;
	}

	public void setDupdatedDatePrev(Date dupdatedDatePrev) {
		this.dupdatedDatePrev = dupdatedDatePrev;
	}
}


