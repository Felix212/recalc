package com.lsgskychefs.cbase.middleware.persistence.domain;
// Generated Mar 10, 2025 3:00:23 PM by Hibernate Tools 4.3.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * Entity(DomainObject) for table CEN_MG_CATEGORY_VERSION
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_MG_CATEGORY_VERSION"
)
public class CenMgCategoryVersion implements DomainObject, java.io.Serializable {

	private long nmgCategoryVersionKey;
	private CenPackinglistTypes cenPackinglistTypes;
	private long nmpMenugridCategoryKey;
	private long nmpMenugridCycleKey;
	private String cname;
	private Long nplMpProjectKey;
	private int nisNeeded;
	private long nsort;
	private Date dcreatedOn;
	private String ccreatedBy;
	private Date dupdatedOn;
	private String cupdatedBy;
	private long nversionNumber;
	private Date dtimestamp;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CEN_MG_CATEGORY_VERSION")
	@SequenceGenerator(name = "SEQ_CEN_MG_CATEGORY_VERSION", sequenceName = "SEQ_CEN_MG_CATEGORY_VERSION", allocationSize = 1)
	@Column(name = "NMG_CATEGORY_VERSION_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNmgCategoryVersionKey() {
		return nmgCategoryVersionKey;
	}

	public void setNmgCategoryVersionKey(long nmgCategoryVersionKey) {
		this.nmgCategoryVersionKey = nmgCategoryVersionKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NPACKINGLIST_KEY")
	public CenPackinglistTypes getCenPackinglistTypes() {
		return cenPackinglistTypes;
	}

	public void setCenPackinglistTypes(CenPackinglistTypes cenPackinglistTypes) {
		this.cenPackinglistTypes = cenPackinglistTypes;
	}

	public long getNmpMenugridCategoryKey() {
		return nmpMenugridCategoryKey;
	}

	public void setNmpMenugridCategoryKey(long nmpMenugridCategoryKey) {
		this.nmpMenugridCategoryKey = nmpMenugridCategoryKey;
	}

	public long getNmpMenugridCycleKey() {
		return nmpMenugridCycleKey;
	}

	public void setNmpMenugridCycleKey(long nmpMenugridCycleKey) {
		this.nmpMenugridCycleKey = nmpMenugridCycleKey;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public Long getNplMpProjectKey() {
		return nplMpProjectKey;
	}

	public void setNplMpProjectKey(Long nplMpProjectKey) {
		this.nplMpProjectKey = nplMpProjectKey;
	}

	public int getNisNeeded() {
		return nisNeeded;
	}

	public void setNisNeeded(int nisNeeded) {
		this.nisNeeded = nisNeeded;
	}

	public long getNsort() {
		return nsort;
	}

	public void setNsort(long nsort) {
		this.nsort = nsort;
	}

	public Date getDcreatedOn() {
		return dcreatedOn;
	}

	public void setDcreatedOn(Date dcreatedOn) {
		this.dcreatedOn = dcreatedOn;
	}

	public String getCcreatedBy() {
		return ccreatedBy;
	}

	public void setCcreatedBy(String ccreatedBy) {
		this.ccreatedBy = ccreatedBy;
	}

	public Date getDupdatedOn() {
		return dupdatedOn;
	}

	public void setDupdatedOn(Date dupdatedOn) {
		this.dupdatedOn = dupdatedOn;
	}

	public String getCupdatedBy() {
		return cupdatedBy;
	}

	public void setCupdatedBy(String cupdatedBy) {
		this.cupdatedBy = cupdatedBy;
	}

	public long getNversionNumber() {
		return nversionNumber;
	}

	public void setNversionNumber(long nversionNumber) {
		this.nversionNumber = nversionNumber;
	}

	public Date getDtimestamp() {
		return dtimestamp;
	}

	public void setDtimestamp(Date dtimestamp) {
		this.dtimestamp = dtimestamp;
	}
}


