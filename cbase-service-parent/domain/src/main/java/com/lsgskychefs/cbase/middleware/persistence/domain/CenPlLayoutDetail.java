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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_PL_LAYOUT_DETAIL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_LAYOUT_DETAIL"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "NLAYOUT_KEY", "NCOLUMN", "NROW" })
)
public class CenPlLayoutDetail implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutDetailKey;
	private CenPackinglistLayout cenPackinglistLayout;
	private int ncolumn;
	private int nrow;
	private int ntype;
	private Integer ncontent;
	private byte[] bdatawindow;
	private Integer norder;
	private Integer ncolumns;
	private Integer nrungs;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;
	private Set<CenPlLayoutDim> cenPlLayoutDims = new HashSet<>(0);

	@Id
	@Column(name = "NLAYOUT_DETAIL_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutDetailKey() {
		return this.nlayoutDetailKey;
	}

	public void setNlayoutDetailKey(long nlayoutDetailKey) {
		this.nlayoutDetailKey = nlayoutDetailKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLAYOUT_KEY", nullable = false)
	public CenPackinglistLayout getCenPackinglistLayout() {
		return this.cenPackinglistLayout;
	}

	public void setCenPackinglistLayout(CenPackinglistLayout cenPackinglistLayout) {
		this.cenPackinglistLayout = cenPackinglistLayout;
	}

	@Column(name = "NCOLUMN", nullable = false, precision = 1, scale = 0)
	public int getNcolumn() {
		return this.ncolumn;
	}

	public void setNcolumn(int ncolumn) {
		this.ncolumn = ncolumn;
	}

	@Column(name = "NROW", nullable = false, precision = 3, scale = 0)
	public int getNrow() {
		return this.nrow;
	}

	public void setNrow(int nrow) {
		this.nrow = nrow;
	}

	@Column(name = "NTYPE", nullable = false, precision = 3, scale = 0)
	public int getNtype() {
		return this.ntype;
	}

	public void setNtype(int ntype) {
		this.ntype = ntype;
	}

	@Column(name = "NCONTENT", precision = 1, scale = 0)
	public Integer getNcontent() {
		return this.ncontent;
	}

	public void setNcontent(Integer ncontent) {
		this.ncontent = ncontent;
	}

	@Column(name = "BDATAWINDOW")
	public byte[] getBdatawindow() {
		return this.bdatawindow;
	}

	public void setBdatawindow(byte[] bdatawindow) {
		this.bdatawindow = bdatawindow;
	}

	@Column(name = "NORDER", precision = 6, scale = 0)
	public Integer getNorder() {
		return this.norder;
	}

	public void setNorder(Integer norder) {
		this.norder = norder;
	}

	@Column(name = "NCOLUMNS", precision = 2, scale = 0)
	public Integer getNcolumns() {
		return this.ncolumns;
	}

	public void setNcolumns(Integer ncolumns) {
		this.ncolumns = ncolumns;
	}

	@Column(name = "NRUNGS", precision = 2, scale = 0)
	public Integer getNrungs() {
		return this.nrungs;
	}

	public void setNrungs(Integer nrungs) {
		this.nrungs = nrungs;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "cenPlLayoutDetail")
	public Set<CenPlLayoutDim> getCenPlLayoutDims() {
		return this.cenPlLayoutDims;
	}

	public void setCenPlLayoutDims(Set<CenPlLayoutDim> cenPlLayoutDims) {
		this.cenPlLayoutDims = cenPlLayoutDims;
	}

}


