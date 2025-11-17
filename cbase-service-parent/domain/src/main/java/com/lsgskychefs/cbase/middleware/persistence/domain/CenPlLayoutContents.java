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
 * Entity(DomainObject) for table CEN_PL_LAYOUT_CONTENTS
 *
 * @author Hibernate Tools
 */
@Entity
@Table(name = "CEN_PL_LAYOUT_CONTENTS"
)
public class CenPlLayoutContents implements DomainObject, java.io.Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 1L;

	private long nlayoutContentKey;
	private CenPlLayoutDetail cenPlLayoutDetail;
	private Integer nheaderFlag;
	private String cupdatedBy;
	private Date dupdatedDate;
	private String cupdatedByPrev;
	private Date dupdatedDatePrev;

	@Id
	@Column(name = "NLAYOUT_CONTENT_KEY", unique = true, nullable = false, precision = 12, scale = 0)
	public long getNlayoutContentKey() {
		return this.nlayoutContentKey;
	}

	public void setNlayoutContentKey(long nlayoutContentKey) {
		this.nlayoutContentKey = nlayoutContentKey;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "NLAYOUT_DETAIL_KEY", nullable = false)
	public CenPlLayoutDetail getCenPlLayoutDetail() {
		return this.cenPlLayoutDetail;
	}

	public void setCenPlLayoutDetail(CenPlLayoutDetail cenPlLayoutDetail) {
		this.cenPlLayoutDetail = cenPlLayoutDetail;
	}

	@Column(name = "NHEADER_FLAG", precision = 1, scale = 0)
	public Integer getNheaderFlag() {
		return this.nheaderFlag;
	}

	public void setNheaderFlag(Integer nheaderFlag) {
		this.nheaderFlag = nheaderFlag;
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


