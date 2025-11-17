package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Aug 23, 2023 3:57:49 PM by Hibernate Tools 4.3.5.Final

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

/**
 * Entity(DomainObject) for table CEN_PL_LAYOUT_DIM
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_LAYOUT_DIM"
)
public class CenPlLayoutDim implements DomainObject, java.io.Serializable {

	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutDimKey;
	private CenPlLayoutDetail cenPlLayoutDetail;
	private SysPackinglistTypes sysPackinglistTypes;
	private String cmealControlCode;
	private int nspml;
	private Integer norder;
	private String cclass;
	private Integer nlimit;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NLAYOUT_DIM_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutDimKey() {
		return this.nlayoutDimKey;
	}

	public void setNlayoutDimKey(long nlayoutDimKey) {
		this.nlayoutDimKey = nlayoutDimKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLAYOUT_DETAIL_KEY", nullable = false)
	public CenPlLayoutDetail getCenPlLayoutDetail() {
		return this.cenPlLayoutDetail;
	}

	public void setCenPlLayoutDetail(CenPlLayoutDetail cenPlLayoutDetail) {
		this.cenPlLayoutDetail = cenPlLayoutDetail;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPLTYPE_KEY", nullable = false)
	public SysPackinglistTypes getSysPackinglistTypes() {
		return this.sysPackinglistTypes;
	}

	public void setSysPackinglistTypes(SysPackinglistTypes sysPackinglistTypes) {
		this.sysPackinglistTypes = sysPackinglistTypes;
	}

	@Column(name = "CMEAL_CONTROL_CODE", nullable = false, length = 4)
	public String getCmealControlCode() {
		return this.cmealControlCode;
	}

	public void setCmealControlCode(String cmealControlCode) {
		this.cmealControlCode = cmealControlCode;
	}

	@Column(name = "NSPML", nullable = false, precision = 1, scale = 0)
	public int getNspml() {
		return this.nspml;
	}

	public void setNspml(int nspml) {
		this.nspml = nspml;
	}

	@Column(name = "NORDER", precision = 6, scale = 0)
	public Integer getNorder() {
		return this.norder;
	}

	public void setNorder(Integer norder) {
		this.norder = norder;
	}

	@Column(name = "CCLASS", length = 5)
	public String getCclass() {
		return this.cclass;
	}

	public void setCclass(String cclass) {
		this.cclass = cclass;
	}

	@Column(name = "NLIMIT", precision = 6, scale = 0)
	public Integer getNlimit() {
		return this.nlimit;
	}

	public void setNlimit(Integer nlimit) {
		this.nlimit = nlimit;
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


