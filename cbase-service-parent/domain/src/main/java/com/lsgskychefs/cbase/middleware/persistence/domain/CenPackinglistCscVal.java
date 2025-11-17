package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated 12.04.2022 13:05:50 by Hibernate Tools 4.3.5.Final

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
import javax.persistence.UniqueConstraint;

/**
 * Entity(DomainObject) for table CEN_PACKINGLIST_CSC_VAL
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PACKINGLIST_CSC_VAL"
		, uniqueConstraints = @UniqueConstraint(columnNames = { "NPACKINGLIST_INDEX_KEY", "NPACKINGLIST_DETAIL_KEY" })
)
public class CenPackinglistCscVal implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long npackinglistCscValKey;
	private CenPackinglists cenPackinglists;
	private SysPackinglistLeancode sysPackinglistLeancode;
	private String cunit;
	private String cprocurementType;
	private String cleanFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	public CenPackinglistCscVal() {
	}

	public CenPackinglistCscVal(final long npackinglistCscValKey, final CenPackinglists cenPackinglists, final String cunit, final String cprocurementType) {
		this.npackinglistCscValKey = npackinglistCscValKey;
		this.cenPackinglists = cenPackinglists;
		this.cunit = cunit;
		this.cprocurementType = cprocurementType;
	}

	public CenPackinglistCscVal(final long npackinglistCscValKey, final CenPackinglists cenPackinglists, final SysPackinglistLeancode sysPackinglistLeancode,
			final String cunit, final String cprocurementType, final String cleanFlag, final String cupdatedBy, final Date dupdatedDate, final String cupdatedByPrev,
			final Date dupdatedDatePrev) {
		this.npackinglistCscValKey = npackinglistCscValKey;
		this.cenPackinglists = cenPackinglists;
		this.sysPackinglistLeancode = sysPackinglistLeancode;
		this.cunit = cunit;
		this.cprocurementType = cprocurementType;
		this.cleanFlag = cleanFlag;
		this.cupdatedBy = cupdatedBy;
		this.dupdatedDate = dupdatedDate;
		this.cupdatedByPrev = cupdatedByPrev;
		this.dupdatedDatePrev = dupdatedDatePrev;
	}

	@Id

	@Column(name = "NPACKINGLIST_CSC_VAL_KEY", unique = true, nullable = false, precision = 13, scale = 0)
	public long getNpackinglistCscValKey() {
		return this.npackinglistCscValKey;
	}

	public void setNpackinglistCscValKey(final long npackinglistCscValKey) {
		this.npackinglistCscValKey = npackinglistCscValKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns({
			@JoinColumn(name = "NPACKINGLIST_INDEX_KEY", referencedColumnName = "NPACKINGLIST_INDEX_KEY", nullable = false),
			@JoinColumn(name = "NPACKINGLIST_DETAIL_KEY", referencedColumnName = "NPACKINGLIST_DETAIL_KEY", nullable = false) })
	public CenPackinglists getCenPackinglists() {
		return this.cenPackinglists;
	}

	public void setCenPackinglists(final CenPackinglists cenPackinglists) {
		this.cenPackinglists = cenPackinglists;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLEANCODE_KEY")
	public SysPackinglistLeancode getSysPackinglistLeancode() {
		return this.sysPackinglistLeancode;
	}

	public void setSysPackinglistLeancode(final SysPackinglistLeancode sysPackinglistLeancode) {
		this.sysPackinglistLeancode = sysPackinglistLeancode;
	}

	@Column(name = "CUNIT", nullable = false, length = 4)
	public String getCunit() {
		return this.cunit;
	}

	public void setCunit(final String cunit) {
		this.cunit = cunit;
	}

	@Column(name = "CPROCUREMENT_TYPE", nullable = false, length = 1)
	public String getCprocurementType() {
		return this.cprocurementType;
	}

	public void setCprocurementType(final String cprocurementType) {
		this.cprocurementType = cprocurementType;
	}

	@Column(name = "CLEAN_FLAG", length = 5)
	public String getCleanFlag() {
		return this.cleanFlag;
	}

	public void setCleanFlag(final String cleanFlag) {
		this.cleanFlag = cleanFlag;
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


