package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 23, 2023 3:57:49 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_LAYOUT
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_LAYOUT"
)
public class CenPackinglistLayout implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutKey;
	private CenPackinglists cenPackinglists;
	private CenAirlineEq cenAirlineEq;
	private Integer ncomponentlist;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Set<CenPlLayoutDetail> cenPlLayoutDetails = new HashSet<>(0);

	@Id
	@Column(name = "NLAYOUT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutKey() {
		return this.nlayoutKey;
	}

	public void setNlayoutKey(long nlayoutKey) {
		this.nlayoutKey = nlayoutKey;
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
	@JoinColumn(name = "NEQUIPMENT_KEY", nullable = false)
	public CenAirlineEq getCenAirlineEq() {
		return this.cenAirlineEq;
	}

	public void setCenAirlineEq(CenAirlineEq cenAirlineEq) {
		this.cenAirlineEq = cenAirlineEq;
	}

	@Column(name = "NCOMPONENTLIST", precision = 1, scale = 0)
	public Integer getNcomponentlist() {
		return this.ncomponentlist;
	}

	public void setNcomponentlist(Integer ncomponentlist) {
		this.ncomponentlist = ncomponentlist;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPackinglistLayout")
	public Set<CenPlLayoutDetail> getCenPlLayoutDetails() {
		return this.cenPlLayoutDetails;
	}

	public void setCenPlLayoutDetails(Set<CenPlLayoutDetail> cenPlLayoutDetails) {
		this.cenPlLayoutDetails = cenPlLayoutDetails;
	}

}


