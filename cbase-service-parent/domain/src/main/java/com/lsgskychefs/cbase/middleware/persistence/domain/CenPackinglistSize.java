package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Oct 13, 2025 12:50:54 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_SIZE
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_SIZE"
)
public class CenPackinglistSize implements DomainObject, java.io.Serializable {

	private long nplDistributionKey;
	private SysPackinglistTypes sysPackinglistTypes;

	@JsonIgnore
	private CenPackinglists cenPackinglists;
	private String cmealControlCode;
	private Long nheight;
	private Long nwidth;
	private int nquantity;
	private int ndisable2ndDistribution;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	public CenPackinglistSize() {
	}

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_PACKINGLIST_SIZE")
	@SequenceGenerator(name = "SEQ_CEN_PACKINGLIST_SIZE", sequenceName = "SEQ_CEN_PACKINGLIST_SIZE", allocationSize = 1)
	@Column(name = "NPL_DISTRIBUTION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNplDistributionKey() {
		return this.nplDistributionKey;
	}

	public void setNplDistributionKey(long nplDistributionKey) {
		this.nplDistributionKey = nplDistributionKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPLTYPE_KEY", nullable = false)
	public SysPackinglistTypes getSysPackinglistTypes() {
		return this.sysPackinglistTypes;
	}

	public void setSysPackinglistTypes(SysPackinglistTypes sysPackinglistTypes) {
		this.sysPackinglistTypes = sysPackinglistTypes;
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

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 3)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NHEIGHT", precision = 12, scale = 0)
	public Long getNheight() {
		return this.nheight;
	}

	public void setNheight(Long nheight) {
		this.nheight = nheight;
	}

	@Column(name = "NWIDTH", precision = 12, scale = 0)
	public Long getNwidth() {
		return this.nwidth;
	}

	public void setNwidth(Long nwidth) {
		this.nwidth = nwidth;
	}

	@Column(name = "NQUANTITY", nullable = false, precision = 6, scale = 0)
	public int getNquantity() {
		return this.nquantity;
	}

	public void setNquantity(int nquantity) {
		this.nquantity = nquantity;
	}

	@Column(name = "NDISABLE_2ND_DISTRIBUTION", nullable = false, precision = 1, scale = 0)
	public int getNdisable2ndDistribution() {
		return this.ndisable2ndDistribution;
	}

	public void setNdisable2ndDistribution(int ndisable2ndDistribution) {
		this.ndisable2ndDistribution = ndisable2ndDistribution;
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


